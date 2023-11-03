from django.contrib import messages
from django.shortcuts import render, redirect
from django.http import HttpResponse
from spotify_social.utils import *
from django.urls import reverse
import bcrypt
    
# Runs the input SQL query command
# param: query (string)
# return: list of tuples
def run_query(query):
    connection = connect_to_db()
    cursor = connection.cursor()
    
    cursor.execute(query)
    
    if "SELECT" in query:
        results = cursor.fetchall()
        return results
    
    connection.commit()
    cursor.close()
    connection.close()
    
    
# Shows the user the landing page. This should be the first page they see
def landing_page(request):
    results_django = run_query("SELECT * FROM user_profile;")
    
    # 'result' is the variable in HTML and results_django is the variable being 
    # passed from django
    
    # return HttpResponse("hello world")
    return render(request, 'landing_page.html', {'results': results_django})


def login_page(request):
    return render(request, 'login_page.html', {})


def signup_page(request):
    # if username taken or password mismatch, user info stored in request.session["user_inputs"]
    if "user_inputs" in request.session:
        user_data = request.session.pop('user_inputs', {})
        inputted_user_name = user_data[0]
        inputted_name = user_data[1]
        
        return render(request, 'signup_page.html', {'username':inputted_user_name, 'full_name':inputted_name})
            
    return render(request, 'signup_page.html', {})


def user_home_page(request):
    # TODO: populate user home page by passing variables into HTML below
    return render(request, 'user_home_page.html', {})


def check_credentials(request):
    if request.method == "POST":
        inputted_user_name = request.POST.get('user_name')
        inputted_password = request.POST.get('password')
        
        print("username and password----", inputted_user_name, inputted_password)
        print(request.POST)
        
        db = Database()
        result = db.execute('''
                            SELECT user_login.password 
                            FROM user_login
                            WHERE user_login.user_name = %s;
                            ''', (inputted_user_name, ), True)
        
        num_matches, matches = result[0], result[1]
        
        if num_matches == 0:
            db.close()
            messages.error(request, "Invalid Username Password Combination")
            return redirect(reverse('login_page'))
        
        hashed_password = matches[0][0]
        
        # Close connections to the database to save resources
        db.close()
        
        print(hashed_password, inputted_password)
        # A matching username found, now check if password matches
        # TODO: CREATE HASHING
        # if (matches == 1) and (bcrypt.checkpw(hashed_password, inputted_password)):
        if (num_matches == 1) and (hashed_password == inputted_password):
                request.session['user_id'] = inputted_user_name
                
                # TODO: create/populate user home page
                # redirect used to ensure user is using a proper url to avoid errors
                return redirect(reverse('user_home_page'))
        else:
            messages.error(request, "Invalid Username Password Combination")
            return redirect(reverse('login_page'))


def create_account(request):
    if request.method == "POST":        
        inputted_user_name = request.POST.get('user_name')
        inputted_name = request.POST.get('name')
        inputted_password = request.POST.get('password')
        inputted_re_password = request.POST.get('re_password')
        
        db = Database()
        
        result = db.execute('''
                            SELECT user_login.user_name 
                            FROM user_login
                            WHERE user_login.user_name = %s;
                            ''', (inputted_user_name, ), True)
                
        num_same_username = result[0]
        
        # The username is unique and password matches, create account
        if num_same_username == 0:
            if inputted_password == inputted_re_password:
                db.execute('''
                            INSERT INTO user_login (user_name, password) 
                            VALUES (%s,%s);
                            ''', (inputted_user_name, inputted_password), False) 
                
                db.execute('''
                            INSERT INTO user_profile (user_name, full_name)
                            VALUES (%s, %s);
                            ''', (inputted_user_name, inputted_name), False) 
                
                db.update_db_and_close()
                
                # user_id will be our main way to tell which user is logged in so what data 
                # he/she will have access to
                request.session['user_id'] = inputted_user_name
                
                return redirect(reverse('user_home_page'))
            
            else:
                db.close()
                
                messages.error(request, "Passwords Do Not Match")
                
                # Store user input data to be used when sign up page is called again
                request.session['user_inputs'] = [inputted_user_name, inputted_name]   
                return redirect(reverse('signup_page'))
        else:
            db.close()
            
            messages.error(request, "Username Already Exists")
            request.session['user_inputs'] = [inputted_user_name, inputted_name]            
            return redirect(reverse('signup_page'))

def logout(request):
    if 'user_id' in request.session:
        del request.session['user_id']
        messages.success(request, "You have logged out")
    
    return redirect(reverse('login_page'))