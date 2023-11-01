from django.urls import path
from . import views

urlpatterns = [
    # parameters are: addition to url path, function called from views, name of the page
    path('', views.landing_page, name = 'landing_page'),
    path('login', views.login_page, name = 'login_page'),
    path('signup', views.signup_page, name = 'signup_page'),
    path('check_credentials', views.check_credentials, name = "check_credentials")
]