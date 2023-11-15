from django.shortcuts import render, redirect
from django.http import HttpResponse
from spotify_social.database import *
    

# Shows the user the landing page. This should be the first page they see
def landing_page(request):
    # results_django = run_query("SELECT * FROM user_profile;")
    
    db = Database()
    result  = db.execute("SELECT * FROM user_profile;", (), True)
    
    db.close()
    # 'result' is the variable in HTML and results_django is the variable being 
    # passed from django
    
    # return HttpResponse("hello world")
    return render(request, 'signed-out/landing_page.html', {'results': result[1]})


def login_page(request):
    return render(request, 'signed-out/login_page.html', {})


def signup_page(request):
    # if username taken or password mismatch, user info stored in request.session["user_inputs"]
    if "user_inputs" in request.session:
        user_data = request.session.pop('user_inputs', {})
        inputted_user_name = user_data[0]
        inputted_name = user_data[1]
        
        return render(request, 'signed-out/signup_page.html', {'username':inputted_user_name, 'full_name':inputted_name})
            
    return render(request, 'signed-out/signup_page.html', {})


def user_home_page(request):
    # TODO: populate user home page by passing variables into HTML below
    return render(request, 'signed-in/home_page.html', {})


def user_profile_page(request):
    user_name = request.session['user_id']
    db = Database()
    result = db.execute('''
                        SELECT * 
                        FROM user_profile
                        WHERE user_name = %s;
                        ''', (user_name,), True)
    
    return render(request, 'signed-in/profile_page.html', {'results': result[1]})


def user_edit_profile_page(request):
    return render(request, 'signed-in/edit_profile_page.html', {})


def search_page(request):
    return render(request, 'signed-in/search_page.html', {})