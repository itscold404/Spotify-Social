from django.shortcuts import render, redirect
from django.urls import reverse
from spotify_social.database import *
from spotify_social.actions import get_callback, load_user_profile


# ----------------------------------------------------------------------------
# # Shows the user the landing page. This should be the first page they see
# TODO: clean up landing page of user info
# ----------------------------------------------------------------------------
def landing_page(request):
    return render(request, "signed-out/landing_page.html", {})


# ----------------------------------------------------------------------------
# displays a page for user to log in
# ----------------------------------------------------------------------------
def login_page(request):
    return render(request, "signed-out/login_page.html", {})


# ----------------------------------------------------------------------------
# displays a page for the user to create an account
# ----------------------------------------------------------------------------
def signup_page(request):
    # if username taken or password mismatch, user info stored in request.session["user_inputs"]
    if "user_inputs" in request.session:
        user_data = request.session.pop("user_inputs", {})
        inputted_user_name = user_data[0]
        inputted_fname = user_data[1]
        inputted_lname = user_data[2]
        inputted_phone = user_data[3]
        inputted_dob = user_data[4]

        return render(
            request,
            "signed-out/signup_page.html",
            {
                "username": inputted_user_name,
                "first_name": inputted_fname,
                "last_name": inputted_lname,
                "phone_number": inputted_phone,
                "dob": inputted_dob,
            },
        )

    return render(request, "signed-out/signup_page.html", {})


# ----------------------------------------------------------------------------
# displays a page to ask user to sign into spotify
# ----------------------------------------------------------------------------
def authorize_spotify(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    return render(request, "signed-in/authorize.html", {})


# ----------------------------------------------------------------------------
# displays the home page of the user
# TODO: could add posts here
# ----------------------------------------------------------------------------
def user_home_page(request):
    # TODO: populate user home page by passing variables into HTML below
    # same code as posts page function

    # check if user is signed in before proceeding
    if "user_id" in request.session:
        # TODO: populate user home page by passing variables into HTML below

        get_callback(request)

        db = Database()
        ## fix query to include only the users own posts and people they follow 
        posts = db.execute(
            """
            SELECT *
            FROM post
            ORDER BY date_time DESC;
            """,
            (),
            True,
        )
        db.close()
        print(posts)

        return render(request, "signed-in/home_page.html", {"posts": posts[1]})

    else:
        return redirect(reverse("login_page"))


# ----------------------------------------------------------------------------
# displays the profile of the current user
# TODO: show that there are no top songs/artists if the user does not
# ----------------------------------------------------------------------------
def user_profile_page(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    user_name = request.session["user_id"]
    db = Database()
    result = db.execute(
        """
        SELECT * 
        FROM user_profile
        WHERE user_name = %s;
        """,
        (user_name,),
        True,
    )
    db.close()

    top_artists = []
    top_tracks = []

    load_user_profile(request)

    if "top_items_user_profile" in request.session:
        top_artists = request.session["top_items_user_profile"][0]
        top_tracks = request.session["top_items_user_profile"][1]

    return render(
        request,
        "signed-in/profile_page.html",
        {"results": result[1], "top_artists": top_artists, "top_tracks": top_tracks},
    )


# ----------------------------------------------------------------------------
# display the profile editing page
# ----------------------------------------------------------------------------
def user_edit_profile_page(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    return render(request, "signed-in/edit_profile_page.html", {})


# ----------------------------------------------------------------------------
# display a page of all the items related to user's search
# ----------------------------------------------------------------------------
def search_page(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    user_name = request.session["user_id"]

    # list of boolean to represent if user is following each artist
    isFollowing_artist = []
    likes_track = []  # if the user likes the track
    track_likes = []  # the number of likes of each track
    likes_album = []  # if the user likes the album
    album_likes = []  # the number of likes of each album

    if "search_results" in request.session:
        artists = request.session["search_results"][0]
        tracks = request.session["search_results"][1]
        albums = request.session["search_results"][2]

        db = Database()
        for artist in artists:
            artist_id = artist[0]
            match = db.execute(
                """
                SELECT *
                FROM follows_artist
                WHERE user_name=%s and artist_id=%s;
                """,
                (user_name, artist_id),
                True,
            )

            isFollowing = True if (match[0] == 1) else False

            isFollowing_artist.append(isFollowing)

        for track in tracks:
            track_id = track[0]
            match = db.execute(
                """
                SELECT *
                FROM upvote_song
                WHERE user_name=%s and song_id=%s;
                """,
                (user_name, track_id),
                True,
            )

            isLiked = True if (match[0] == 1) else False
            likes_track.append(isLiked)

            likes = db.execute(
                """
                SELECT *
                FROM upvote_song
                WHERE song_id=%s;
                """,
                (track_id,),
                True,
            )
            track_likes.append(likes[0])

        for album in albums:
            album_id = album[0]
            match = db.execute(
                """
                SELECT *
                FROM upvote_album
                WHERE user_name=%s and album_id=%s;
                """,
                (user_name, album_id),
                True,
            )

            isLiked = True if (match[0] == 1) else False
            likes_album.append(isLiked)

            likes = db.execute(
                """
                SELECT *
                FROM upvote_album
                WHERE album_id=%s;
                """,
                (album_id),
                True,
            )
            album_likes.append(likes[0])

        db.close()

    artist_follow_status = zip(artists, isFollowing_artist)
    track_with_likes = zip(tracks, likes_track, track_likes)
    album_with_likes = zip(albums, likes_album, album_likes)

    return render(
        request,
        "search pages/search_items.html",
        {
            "artist_follow_status": artist_follow_status,
            "track_with_likes": track_with_likes,
            "album_with_likes": album_with_likes,
        },
    )


# ----------------------------------------------------------------------------
# display the page to where user can create their post
# ----------------------------------------------------------------------------
def create_posts_page(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    return render(request, "signed-in/create_posts_page.html", {})


# ----------------------------------------------------------------------------
# display a page with a list of user profiles that have similar user names
# to the user name searched by the user
# ----------------------------------------------------------------------------
def search_profile_page(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    profiles = request.session.pop("searched_profiles", {})

    return render(
        request,
        "search pages/search_profile.html",
        {"profiles": profiles},
    )


# ----------------------------------------------------------------------------
# displays the profile that the user wants to view (not his/her own)
# TODO: show that there are no top songs/artists if the user does not
# ----------------------------------------------------------------------------
def view_profile_page(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    top_artists = []
    top_tracks = []
    if "selected_profile_info" in request.session:
        user_info, items, isFollowing = request.session["selected_profile_info"]
        top_artists, top_tracks = items[0], items[1]

    return render(
        request,
        "search pages/view_profile_page.html",
        {
            "results": user_info,
            "top_artists": top_artists,
            "top_tracks": top_tracks,
            "isFollowing": isFollowing,
        },
    )


# ----------------------------------------------------------------------------
# displays the longer list of user top songs
# ----------------------------------------------------------------------------
def songs_page(request):
    top_tracks = []

    load_user_profile(request)

    if "top_items_user_profile" in request.session:
        top_tracks = request.session["top_items_user_profile"][1]

    return render(
        request,
        "signed-in/songs_page.html",
        {"top_tracks": top_tracks},
    )


# ----------------------------------------------------------------------------
# displays the longer list of user top albums
# ----------------------------------------------------------------------------
def albums_page(request):
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    unique_tracks = []
    seen_values = set()

    load_user_profile(request)

    if "top_items_user_profile" in request.session:
        top_tracks = request.session["top_items_user_profile"][1]

    for track in top_tracks:
        value_to_check = track[10]

        # Check if the value is not in the set of seen values
        if value_to_check not in seen_values:
            seen_values.add(value_to_check)
            unique_tracks.append(track)

    return render(
        request,
        "signed-in/albums_page.html",
        {"top_tracks": unique_tracks},
    )


# ----------------------------------------------------------------------------
# displays the longer list of user top artists
# ----------------------------------------------------------------------------
def artists_page(request):
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    top_artists = []

    load_user_profile(request)

    if "top_items_user_profile" in request.session:
        top_artists = request.session["top_items_user_profile"][0]

    return render(
        request,
        "signed-in/artists_page.html",
        {"top_artists": top_artists},
    )
