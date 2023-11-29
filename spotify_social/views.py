from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.urls import reverse
from spotify_social.database import *
from spotify_social.actions import get_callback, load_profile, check_signedin


# Shows the user the landing page. This should be the first page they see
# TODO: clean up landing page of user info
def landing_page(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    # results_django = run_query("SELECT * FROM user_profile;")

    db = Database()
    result = db.execute("SELECT * FROM user_profile;", (), True)

    db.close()
    # 'result' is the variable in HTML and results_django is the variable being
    # passed from django

    # return HttpResponse("hello world")
    return render(request, "signed-out/landing_page.html", {"results": result[1]})


def login_page(request):
    return render(request, "signed-out/login_page.html", {})


def signup_page(request):
    # if username taken or password mismatch, user info stored in request.session["user_inputs"]
    if "user_inputs" in request.session:
        user_data = request.session.pop("user_inputs", {})
        inputted_user_name = user_data[0]
        inputted_fname = user_data[1]
        inputted_lname = user_data[2]

        return render(
            request,
            "signed-out/signup_page.html",
            {
                "username": inputted_user_name,
                "first_name": inputted_fname,
                "last_name": inputted_lname,
            },
        )

    return render(request, "signed-out/signup_page.html", {})


def authorize_spotify(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    return render(request, "signed-in/authorize.html", {})


def user_home_page(request):
    # check if user is signed in before proceeding
    if "user_id" in request.session:
        # TODO: populate user home page by passing variables into HTML below

        get_callback(request)
        return render(request, "signed-in/home_page.html", {})

    else:
        return redirect(reverse("login_page"))


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

    top_artists = []
    top_tracks = []

    # TODO: THIS IS CAUSING ERROR. NEED TO COMMENT THIS, AUTORIZE USER, THEN UNCOMMENT TO GET
    # PASS THIS ISSUE CURRENTLY

    load_profile(request)

    if "top_items_user_profile" in request.session:
        top_artists = request.session["top_items_user_profile"][0]
        top_tracks = request.session["top_items_user_profile"][1]

    return render(
        request,
        "signed-in/profile_page.html",
        {"results": result[1], "top_artists": top_artists, "top_tracks": top_tracks},
    )


def user_edit_profile_page(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    return render(request, "signed-in/edit_profile_page.html", {})


def search_page(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    if "search_results" in request.session:
        artists = request.session["search_results"][0]
        tracks = request.session["search_results"][1]
        albums = request.session["search_results"][2]

    return render(
        request,
        "search pages/search_items.html",
        {"artists": artists, "tracks": tracks, "albums": albums},
    )


def search_profile_page(request):
    # check if user is signed in before proceeding
    if "user_id" not in request.session:
        return redirect(reverse("login_page"))

    profiles = request.session.pop("searched_profiles", {})
    print("profiles in search", profiles)
    return render(
        request,
        "search pages/search_profile.html",
        {"profiles": profiles},
    )
