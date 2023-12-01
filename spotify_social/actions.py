from django.contrib import messages
from django.shortcuts import redirect
from django.urls import reverse
from django.http import HttpResponseRedirect
from spotify_social.database import *
from spotify_social.spotify_api import *
from requests import post
from dotenv import load_dotenv
import bcrypt
import urllib.parse
import secrets
import os
import base64

load_dotenv()

# how many results the API should produce for the respective category
SEARCH_LIMIT_ARTIST = 6
SEARCH_LIMIT_TRACK = 6
SEARCH_LIMIT_ALBUM = 6

# how many of each category (tracks, artists) of user's top items should be displayed in his/her profile
PROFILE_LIMIT_ITEMS = 5

CLIENT_ID = os.getenv("SPOTIFY_CLIENT_ID")
CLIENT_SECRET = os.getenv("SPOTIFY_CLIENT_SECRET")
REDIRECT_URI = "http://127.0.0.1:8000/home"

# # TODO: UNCOMMENT THIS WHEN PUSHING TO CLOUD
# REDIRECT_URI = "https://spotify-social-media.uk.r.appspot.com/home/"


# ----------------------------------------------------------------------------
# Check whether the username and password matches with a user to sign them in
# ----------------------------------------------------------------------------
def check_credentials(request):
    if request.method == "POST":
        inputted_user_name = request.POST.get("user_name")
        inputted_password = request.POST.get("password")

        db = Database()
        result = db.execute(
            """
            SELECT user_login.password 
            FROM user_login
            WHERE user_login.user_name = %s;
            """,
            (inputted_user_name,),
            True,
        )

        num_matches, matches = result[0], result[1]

        if num_matches == 0:
            db.close()
            messages.error(request, "Invalid Username Password Combination")
            return redirect(reverse("login_page"))

        hashed_password = matches[0][0]

        # Close connections to the database to save resources
        db.close()

        # A matching username found, now check if password matches
        # TODO: delete except section after database wipe with real data
        # try:
        if (num_matches == 1) and bcrypt.checkpw(
            inputted_password.encode("utf-8"), hashed_password.encode("utf-8")
        ):
            request.session["user_id"] = inputted_user_name

            # TODO: create/populate user home page
            # redirect used to ensure user is using a proper url to avoid errors
            request.session["user_id"] = inputted_user_name
            return redirect(reverse("authorize_page"))
        else:
            messages.error(request, "Invalid Username Password Combination")
            return redirect(reverse("login_page"))


# ----------------------------------------------------------------------------
# Create a new account for the user
# ----------------------------------------------------------------------------
def create_account(request):
    if request.method == "POST":
        inputted_user_name = request.POST.get("user_name")
        inputted_fname = request.POST.get("fname")
        inputted_lname = request.POST.get("lname")
        inputted_phone = request.POST.get("phone_number")
        inputted_dob = request.POST.get("dob")
        inputted_password = request.POST.get("password")
        inputted_re_password = request.POST.get("re_password")

        db = Database()

        result = db.execute(
            """
            SELECT user_login.user_name 
            FROM user_login
            WHERE user_login.user_name = %s;
            """,
            (inputted_user_name,),
            True,
        )

        num_same_username = result[0]

        # The username is unique and password matches, create account
        if num_same_username == 0:
            if inputted_password == inputted_re_password:
                hashed_password = bcrypt.hashpw(
                    inputted_password.encode("utf-8"), bcrypt.gensalt()
                )

                db.execute(
                    """
                    INSERT INTO user_profile (user_name, first_name, last_name, phone_number, date_of_birth)
                    VALUES (%s, %s, %s, %s, %s);
                    """,
                    (
                        inputted_user_name,
                        inputted_fname,
                        inputted_lname,
                        inputted_phone,
                        inputted_dob,
                    ),
                    False,
                )

                db.execute(
                    """
                    INSERT INTO user_login (user_name, password) 
                    VALUES (%s,%s);
                    """,
                    (inputted_user_name, hashed_password),
                    False,
                )

                db.update_db_and_close()

                # user_id will be our main way to tell which user is logged in so what data
                # he/she will have access to
                request.session["user_id"] = inputted_user_name

                return redirect(reverse("authorize_page"))

            else:
                db.close()

                messages.error(request, "Passwords Do Not Match")

                # Store user input data to be used when sign up page is called again
                request.session["user_inputs"] = [
                    inputted_user_name,
                    inputted_fname,
                    inputted_lname,
                    inputted_phone,
                    inputted_dob,
                ]
                return redirect(reverse("signup_page"))
        else:
            db.close()

            messages.error(request, "Username Already Exists")
            request.session["user_inputs"] = [
                inputted_user_name,
                inputted_fname,
                inputted_lname,
                inputted_phone,
                inputted_dob,
            ]
            return redirect(reverse("signup_page"))


# ----------------------------------------------------------------------------
# Update user profile with the info they input
# ----------------------------------------------------------------------------
def update_profile(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    if request.method == "POST":
        user = request.session["user_id"]
        bio = request.POST.get("bio")
        comp_id = request.POST.get("comp_id")
        school = request.POST.get("school")
        area_study = request.POST.get("area_study")
        password = request.POST.get("password")
        re_password = request.POST.get("re_password")

        db = Database()
        db.execute(
            """
            UPDATE user_profile
            SET bio=%s, computing_id=%s, school = %s, area_of_study=%s
            WHERE user_name = %s;
            """,
            (bio, comp_id, school, area_study, user),
            False,
        )

        db.update_db_and_close()
        messages.success(request, "Updated Profile!")

        return redirect(reverse("user_profile_page"))


# ----------------------------------------------------------------------------
# Logs the user out if they are signed in
# ----------------------------------------------------------------------------
def logout(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    request.session.flush()
    messages.success(request, "You have logged out")

    return redirect(reverse("login_page"))


# ----------------------------------------------------------------------------
# Deletes the user profile
# ----------------------------------------------------------------------------
def delete_profile(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    if "user_id" in request.session:
        user_name = request.session["user_id"]

        db = Database()
        db.execute(
            """
            DELETE FROM user_profile WHERE user_name=%s;
            """,
            (user_name,),
            False,
        )
        db.update_db_and_close()

        if "user_id" in request.session:
            del request.session["user_id"]

        messages.success(request, "Account deleted successfully")

    return redirect(reverse("login_page"))


# ----------------------------------------------------------------------------
# get authorization from user to use account information
# ----------------------------------------------------------------------------
def authorize(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    state = secrets.token_urlsafe(16)
    scope = "user-top-read user-read-recently-played"  # Read access to a user's top artists and tracks and recently played tracks

    query_parameters = {
        "response_type": "code",
        "client_id": CLIENT_ID,
        "scope": scope,
        "redirect_uri": REDIRECT_URI,
        "state": state,
    }
    query_string = urllib.parse.urlencode(query_parameters)
    spotify_auth_url = f"https://accounts.spotify.com/authorize?{query_string}"

    messages.success(request, "Spotify login successful!")
    return HttpResponseRedirect(spotify_auth_url)


# ----------------------------------------------------------------------------
# retrieves access token that is valid for an hour
# ----------------------------------------------------------------------------
def get_token(auth_code):
    auth_string = CLIENT_ID + ":" + CLIENT_SECRET
    auth_bytes = auth_string.encode("utf-8")
    auth_base64 = str(base64.b64encode(auth_bytes), "utf-8")

    url = "https://accounts.spotify.com/api/token"
    headers = {
        "Authorization": "Basic " + auth_base64,
        "Content-Type": "application/x-www-form-urlencoded",
    }

    data = {
        "code": auth_code,
        "redirect_uri": REDIRECT_URI,
        "grant_type": "authorization_code",
    }
    result = post(url, headers=headers, data=data)
    json_result = json.loads(result.content)
    token = json_result["access_token"]

    auth_header = {"Authorization": "Bearer " + token}
    return auth_header


# ----------------------------------------------------------------------------
# store spotify callback code and state
# ----------------------------------------------------------------------------
def get_callback(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    if "state" in request.GET and "code" in request.GET:
        code = request.GET.get("code")
        state = request.GET.get("state")

        request.session["code"] = code  # authorization code
        request.session["state"] = state

    if "auth_header" not in request.session:
        request.session["auth_header"] = get_token(request.session["code"])

    return redirect(reverse("user_home_page"))


# ----------------------------------------------------------------------------
# Fills the database if the ID's of artists, tracks, albums do not exist
# ----------------------------------------------------------------------------
def fill_database(search_result: list):
    # search_result index: 0 = artists, 1 = tracks, 2 = albums
    db = Database()
    needs_update = False

    if len(search_result) >= 2:
        # fill artists table
        for i in range(len(search_result[0])):
            artist = search_result[0][i]
            query_result = db.execute(
                "SELECT * FROM artist WHERE artist_id = %s;", (artist["id"],), True
            )

            if query_result[0] == 0:
                db.execute(
                    """                    
                    INSERT INTO artist (artist_id, artist_name)
                    VALUES (%s, %s);
                    """,
                    (artist["id"], artist["name"]),
                    False,
                )
                needs_update = True

        # fill songs table
        for i in range(len(search_result[1])):
            track = search_result[1][i]
            query_result = db.execute(
                "SELECT * FROM song WHERE song_id = %s;", (track["id"],), True
            )

            if query_result[0] == 0:
                db.execute(
                    """                    
                    INSERT INTO song (song_id, song_name)
                    VALUES (%s, %s);
                    """,
                    (track["id"], track["name"]),
                    False,
                )
                needs_update = True

    if len(search_result) >= 3:
        # fill albums table
        for i in range(len(search_result[2])):
            album = search_result[2][i]
            query_result = db.execute(
                "SELECT * FROM album WHERE album_id = %s;", (album["id"],), True
            )

            if query_result[0] == 0:
                db.execute(
                    """                    
                    INSERT INTO album (album_id, title)
                    VALUES (%s, %s);
                    """,
                    (album["id"], album["name"]),
                    False,
                )
                needs_update = True

    if needs_update:
        db.update_db_and_close()
    else:
        db.close()


# ----------------------------------------------------------------------------
# Creates a list to store display info on search page of artist, album, track
# ----------------------------------------------------------------------------
def get_display_info(matches: list):
    # matches index: 0 = artists, 1 = tracks, 2 = albums
    display_info = []
    if len(matches) >= 2:
        artist_result = []
        for i in range(len(matches[0])):
            artist = matches[0][i]
            info = [
                artist["id"],
                artist["name"],
                artist["followers"]["total"],
            ]

            if len(artist["images"]) > 0:
                info.append(artist["images"][0]["url"])
            else:
                info.append([])

            artist_result.append(info)

        track_result = []
        for i in range(len(matches[1])):
            track = matches[1][i]
            info = [
                track["id"],
                track["name"],
            ]

            track_artist = []
            for a in track["artists"]:
                track_artist.append(a["name"])

            info.append(track_artist)

            track_result.append(info)

        display_info.append(artist_result)
        display_info.append(track_result)

    if len(matches) >= 3:
        album_result = []
        for i in range(len(matches[2])):
            album = matches[2][i]
            info = [
                album["id"],
                album["name"],
                album["total_tracks"],
            ]

            if len(album["images"]) > 0:
                info.append(album["images"][0]["url"])
            else:
                info.append([])

            album_artist = []
            for a in album["artists"]:
                album_artist.append(a["name"])

            info.append(album_artist)

            album_result.append(info)

        display_info.append(album_result)

    return display_info


# ----------------------------------------------------------------------------
# sends request to spotify api to get artists, tracks, ablumbs that matches
# what the user is searching for
# ----------------------------------------------------------------------------
def search_items(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    if request.method == "POST":
        searched_phrase = request.POST.get("searched-phrase")

        if "code" in request.session and "auth_header" in request.session:
            token = request.session["auth_header"]
            if searched_phrase != "":
                artist_matches = search_for(
                    token, "artist", searched_phrase, SEARCH_LIMIT_ARTIST
                )
                track_matches = search_for(
                    token, "track", searched_phrase, SEARCH_LIMIT_TRACK
                )
                album_matches = search_for(
                    token, "album", searched_phrase, SEARCH_LIMIT_ALBUM
                )

                # spotify authorization expired, reauthorize
                if (
                    artist_matches == "ERROR"
                    or track_matches == "ERROR"
                    or album_matches == "ERROR"
                ):
                    return authorize(request)

                matches = [artist_matches, track_matches, album_matches]
                fill_database(matches)
                display_info = get_display_info(matches)

                request.session["search_results"] = display_info

                return redirect(reverse("search_page"))

            # TODO: search on other pages will also redirect to user home page
        return redirect(reverse("user_home_page"))


# ----------------------------------------------------------------------------
# retrieve information for the current useer(user top tracks and artists)
# from spotify api to load in user profile
# ----------------------------------------------------------------------------
def load_user_profile(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    if "code" in request.session and "auth_header" in request.session:
        token = request.session["auth_header"]
        artists = get_user_top_items(token, "artists", PROFILE_LIMIT_ITEMS)
        tracks = get_user_top_items(token, "tracks", PROFILE_LIMIT_ITEMS)

        # spotify authorization expired, reauthorize
        if artists == "ERROR" or tracks == "ERROR":
            return authorize(request)

        display_info = get_display_info([artists, tracks])
        request.session["top_items_user_profile"] = display_info
        fill_top_items(display_info[0], request.session["user_id"], "artist")
        fill_top_items(display_info[1], request.session["user_id"], "track")


# ----------------------------------------------------------------------------
# retrieve user profiles that have similar names to input
# ----------------------------------------------------------------------------
def search_profile(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    sUser_name = request.POST.get("searched-profile")
    pattern = f"{sUser_name}%"
    db = Database()
    result = db.execute(
        """
        SELECT * 
        FROM protected_profile
        WHERE user_name LIKE %s;
        """,
        (pattern,),
        True,
    )
    db.close()
    matches, profiles = result[0], result[1]
    num_profiles = min(10, matches)  # number of profiles to display
    request.session["searched_profiles"] = profiles[0:num_profiles]

    return redirect(reverse("search_profile_page"))


# ----------------------------------------------------------------------------
# update the user_top_items table with the updated current user's
# top items
# ----------------------------------------------------------------------------
def fill_top_items(items: list, user_name, type):
    if len(items) > 0:
        db = Database()

        for i in range(len(items)):
            result = db.execute(
                """
                SELECT *
                FROM user_top_items
                WHERE item_type=%s and item_ranking = %s;
                """,
                (type, i + 1),
                True,
            )

            # if there is nothing for that type and ranking, then add to the table
            if result[0] == 0:
                db.execute(
                    """
                    INSERT INTO user_top_items (user_name, item_id, item_type, item_ranking)
                    VALUES (%s, %s, %s, %s);
                    """,
                    (user_name, items[i][0], type, i + 1),
                    False,
                )
            # if there is an item for that type and ranking, then update the table
            elif result[0] == 1:
                db.execute(
                    """
                    UPDATE user_top_items
                    SET item_id=%s
                    WHERE user_name = %s and item_ranking = %s and item_type=%s;
                    """,
                    (items[i][0], user_name, i + 1, type),
                    False,
                )
        db.update_db_and_close()


# ----------------------------------------------------------------------------
# retrieve information of a different profile to display
# ----------------------------------------------------------------------------
def view_user_profile(request):
    user_name = request.POST.get("user_name")
    db = Database()

    result = db.execute(
        """
        SELECT *
        FROM protected_profile
        WHERE user_name=%s;
        """,
        (user_name,),
        True,
    )

    # if the user_name exists in the database
    if result[0] == 1:
        artists = db.execute(
            """
            SELECT item_id
            FROM user_top_items
            WHERE user_name=%s AND item_type="artist"
            ORDER BY item_ranking ASC;
            """,
            (user_name,),
            True,
        )

        tracks = db.execute(
            """
            SELECT item_id
            FROM user_top_items
            WHERE user_name=%s AND item_type="track"
            ORDER BY item_ranking ASC;
            """,
            (user_name,),
            True,
        )

        db.update_db_and_close()

        artist_id_list = []
        track_id_list = []
        auth_header = request.session["auth_header"]

        for a in artists[1]:
            artist_id_list.append(a[0])

        for t in tracks[1]:
            track_id_list.append(t[0])

        artists = []
        tracks = []
        for a in artist_id_list:
            artists.append(find_artist(auth_header, a))

        for t in track_id_list:
            tracks.append(find_track(auth_header, t))

        request.session["selected_profile_info"] = [
            result[1],
            get_display_info([artists, tracks]),
        ]

    else:
        db.close()

    return redirect(reverse("view_profile_page"))
