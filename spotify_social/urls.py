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
    path("edit_profile/", views.user_edit_profile_page, name="user_edit_profile_page"),
    path("search_page/", views.search_page, name="search_page"),
    path("songs_page/", views.songs_page, name="songs_page"),
    path("albums_page/", views.albums_page, name="albums_page"),
    path("create_posts_page/", views.create_posts_page, name="create_posts_page"),
    path("check_credentials/", actions.check_credentials, name="check_credentials"),
    path("create_account/", actions.create_account, name="create_account"),
    path("update_profile/", actions.update_profile, name="update_user_profile"),
    path("create_post/", actions.create_post, name="create_post"),
    path("logout/", actions.logout, name="logout"),
    path("delete_profile/", actions.delete_profile, name="delete_user_profile"),
    path("search/", actions.search, name="search"),
    path("authorize/", actions.authorize, name="authorize"),
]
