from django.urls import path
from . import views, actions

# parameters are: addition to url path, function called from views, name of the page
urlpatterns = [
    path("", views.landing_page, name="landing_page"),
    path("login/", views.login_page, name="login_page"),
    path("signup/", views.signup_page, name="signup_page"),
    path("authorize_spotify/", views.authorize_spotify, name="authorize_page"),
    path("home/", views.user_home_page, name="user_home_page"),
    path("profile/", views.user_profile_page, name="user_profile_page"),
    path(
        "view_profile/", views.view_profile_page, name="view_profile_page"
    ),  # view the profile of diff user
    path("edit_profile/", views.user_edit_profile_page, name="user_edit_profile_page"),
    path("search_page/", views.search_page, name="search_page"),  # the spotify items
    path("songs_page/", views.songs_page, name="songs_page"),
    path("albums_page/", views.albums_page, name="albums_page"),
    path("create_posts_page/", views.create_posts_page, name="create_posts_page"),
    path("search_profile_page/", views.search_profile_page, name="search_profile_page"),
    path("songs_page/", views.songs_page, name="songs_page"),
    path("albums_page/", views.albums_page, name="albums_page"),
    path("artists_page/", views.artists_page, name="artists_page"),
    path("check_credentials/", actions.check_credentials, name="check_credentials"),
    path("create_account/", actions.create_account, name="create_account"),
    path("update_profile/", actions.update_profile, name="update_user_profile"),
    path("create_post/", actions.create_post, name="create_post"),
    path("logout/", actions.logout, name="logout"),
    path("delete_profile/", actions.delete_profile, name="delete_user_profile"),
    path("search_items/", actions.search_items, name="search_items"),
    path("authorize/", actions.authorize, name="authorize"),
    path("search_profile/", actions.search_profile, name="search_profile"),
    path("view_user/", actions.view_user_profile, name="view_user_profile"),
    path("follow_profile/", actions.follow_profile, name="follow_profile"),
    path("unfollow_profile/", actions.unfollow_profile, name="unfollow_profile"),
]
