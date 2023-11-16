from django.contrib import messages
from django.shortcuts import render, redirect
from django.urls import reverse
from django.http import HttpResponseRedirect
from spotify_social.database import *
from spotify_social.spotify_api import *
import bcrypt
import urllib.parse
import secrets

# how many results the API should produce for the respective category
SEARCH_LIMIT_ARTIST = 6
SEARCH_LIMIT_TRACK = 6
SEARCH_LIMIT_ALBUM = 6

# how many of each category of user's top items should be displayed in his/her profile
PROFILE_LIMIT_ARTISTS = 5
PROFILE_LIMIT_TRACKS = 5

CLIENT_ID = os.getenv("SPOTIFY_CLIENT_ID")
CLIENT_SECRET = os.getenv("SPOTIFY_CLIENT_SECRET")
REDIRECT_URI = 'http://127.0.0.1:8000/home'

#TODO: UNCOMMENT THIS WHEN PUSHING TO CLOUD
#REDIRECT_URI = "https://spotify-social-media.uk.r.appspot.com/home/"

# ----------------------------------------------------------------------------
# Check whether the username and password matches with a user to sign then in
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
        try:
            if (num_matches == 1) and bcrypt.checkpw(
                inputted_password.encode("utf-8"), hashed_password.encode("utf-8")
            ):
                request.session["user_id"] = inputted_user_name

                # TODO: create/populate user home page
                # redirect used to ensure user is using a proper url to avoid errors
                request.session["user_id"] = inputted_user_name
                return redirect(reverse("user_home_page"))
            else:
                messages.error(request, "Invalid Username Password Combination")
                return redirect(reverse("login_page"))

        except:
            if (num_matches == 1) and (inputted_password == hashed_password):
                request.session["user_id"] = inputted_user_name

                # TODO: create/populate user home page
                # redirect used to ensure user is using a proper url to avoid errors
                request.session["user_id"] = inputted_user_name
                return redirect(reverse("user_home_page"))
            else:
                messages.error(request, "Invalid Username Password Combination")
                return redirect(reverse("login_page"))


# ----------------------------------------------------------------------------
# Create a new account for the user
# ----------------------------------------------------------------------------
def create_account(request):
    if request.method == "POST":
        inputted_user_name = request.POST.get("user_name")
        inputted_name = request.POST.get("name")
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
                    INSERT INTO user_profile (user_name, full_name)
                    VALUES (%s, %s);
                    """,
                    (inputted_user_name, inputted_name),
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

                return redirect(reverse("user_home_page"))

            else:
                db.close()

                messages.error(request, "Passwords Do Not Match")

                # Store user input data to be used when sign up page is called again
                request.session["user_inputs"] = [inputted_user_name, inputted_name]
                return redirect(reverse("signup_page"))
        else:
            db.close()

            messages.error(request, "Username Already Exists")
            request.session["user_inputs"] = [inputted_user_name, inputted_name]
            return redirect(reverse("signup_page"))


# ----------------------------------------------------------------------------
# Update user profile with the info they input
# ----------------------------------------------------------------------------
def update_profile(request):
    if request.method == "POST":
        user = request.session["user_id"]
        name = request.POST.get("name")
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
            SET full_name=%s, bio=%s, computing_id=%s, school = %s, area_of_study=%s
            WHERE user_name = %s;
            """,
            (name, bio, comp_id, school, area_study, user),
            False,
        )

        db.update_db_and_close()
        messages.success(request, "Updated Profile!")

        return redirect(reverse("user_profile_page"))


# ----------------------------------------------------------------------------
# Logs the user out if they are signed in
# ----------------------------------------------------------------------------
def logout(request):
    if "code" in request.session:
        del request.session["code"]
    if "state" in request.session:
        del request.session["state"]
    if "user_id" in request.session:
        del request.session["user_id"]
        messages.success(request, "You have logged out")

    return redirect(reverse("login_page"))


# ----------------------------------------------------------------------------
# Deletes the user profile
# ----------------------------------------------------------------------------
def delete_profile(request):
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
    state = secrets.token_urlsafe(16)
    scope = 'user-top-read user-read-recently-played'# Read access to a user's top artists and tracks and recently played tracks
    
    query_parameters = {
        'response_type': 'code',
        'client_id': CLIENT_ID,
        'scope': scope,
        'redirect_uri': REDIRECT_URI,
        'state': state
    }
    query_string = urllib.parse.urlencode(query_parameters)
    spotify_auth_url = f'https://accounts.spotify.com/authorize?{query_string}'
    return HttpResponseRedirect(spotify_auth_url)


# ----------------------------------------------------------------------------
# store spotify callback code and state
# ----------------------------------------------------------------------------
def get_callback(request):
    if 'state' in request.GET and 'code' in request.GET:
        code = request.GET.get('code')
        state = request.GET.get('state')
        
        request.session["code"] = code #authorization code
        request.session["state"] = state
    
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
def get_display_info(matches:list):
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
def search(request):
    if request.method == "POST":
        searched_phrase = request.POST.get("searched-phrase")

        if "code" in request.session:
            if searched_phrase != "":
                api = Spotify_API(request.session["code"])
                api.get_token()
                
                artist_matches = api.search_for(
                    "artist", searched_phrase, SEARCH_LIMIT_ARTIST
                )
                track_matches = api.search_for("track", searched_phrase, SEARCH_LIMIT_TRACK)
                album_matches = api.search_for("album", searched_phrase, SEARCH_LIMIT_ALBUM)

                matches = [artist_matches, track_matches, album_matches]
                fill_database(matches)
                display_info = get_display_info(matches)

                request.session["search_results"] = display_info

                return redirect(reverse("search_page"))

            # TODO: search on other pages will also redirect to user home page
        return redirect(reverse("user_home_page"))
    
# ----------------------------------------------------------------------------
# retrieve information (user top tracks and artists) from spotify api 
# to load in user profile
# ----------------------------------------------------------------------------
def load_profile(request):
    if "code" in request.session:
        api = Spotify_API(request.session["code"])
        api.get_token()
        artists = api.get_user_top_items("artists", PROFILE_LIMIT_ARTISTS)
        tracks = api.get_user_top_items("tracks", PROFILE_LIMIT_TRACKS)
        
        request.session["top_items_user_profile"] = get_display_info([artists, tracks])

        return redirect(reverse("search_page"))

    # TODO: search on other pages will also redirect to user home page
    return redirect(reverse("user_home_page"))