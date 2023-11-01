from django.urls import path
from . import views

# parameters are: addition to url path, function called from views, name of the page
urlpatterns = [
    path('', views.landing_page, name = 'landing_page'),
    path('login/', views.login_page, name = 'login_page'),
    path('signup/', views.signup_page, name = 'signup_page'),
    path('home/', views.user_home_page, name ="user_home_page"),
    path('check_credentials/', views.check_credentials, name = "check_credentials"),
    path('create_account/', views.create_account, name = "create_account"),
    path('logout/', views.logout, name = "logout"),
]