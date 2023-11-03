from django.urls import path
from . import views, actions

# parameters are: addition to url path, function called from views, name of the page
urlpatterns = [
    path('', views.landing_page, name = 'landing_page'),
    path('login/', views.login_page, name = 'login_page'),
    path('signup/', views.signup_page, name = 'signup_page'),
    path('home/', views.user_home_page, name ="user_home_page"),
    path('profile/', views.user_profile_page, name ="user_profile_page"),
    path('edit_profile/', views.user_edit_profile_page, name ="user_edit_profile_page"),
    path('check_credentials/', actions.check_credentials, name = "check_credentials"),
    path('create_account/', actions.create_account, name = "create_account"),
    path('update_profile/', actions.update_profile, name ="update_user_profile"),
    path('logout/', actions.logout, name = "logout"),
]