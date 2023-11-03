from django.contrib import messages
from django.shortcuts import render, redirect
from django.urls import reverse
from spotify_social.utils import *
from django.http import HttpResponse
import bcrypt

#----------------------------------------------------------------------------
# Check whether the username and password matches with a user to sign then in
#----------------------------------------------------------------------------
def check_credentials(request):
    if request.method == "POST":
        inputted_user_name = request.POST.get('user_name')
        inputted_password = request.POST.get('password')
        
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
        
        # A matching username found, now check if password matches
        # TODO: delete except section after database wipe with real data
        try:
            if (num_matches == 1) and bcrypt.checkpw(inputted_password.encode('utf-8'), hashed_password.encode('utf-8')):
                    request.session['user_id'] = inputted_user_name
                    
                    # TODO: create/populate user home page
                    # redirect used to ensure user is using a proper url to avoid errors
                    request.session['user_id'] = inputted_user_name
                    return redirect(reverse('user_home_page'))
            else:
                messages.error(request, "Invalid Username Password Combination")
                return redirect(reverse('login_page'))
            
        except:
            if (num_matches == 1) and (inputted_password == hashed_password):
                    request.session['user_id'] = inputted_user_name
                    
                    # TODO: create/populate user home page
                    # redirect used to ensure user is using a proper url to avoid errors
                    request.session['user_id'] = inputted_user_name
                    return redirect(reverse('user_home_page'))
            else:
                messages.error(request, "Invalid Username Password Combination")
                return redirect(reverse('login_page'))

#----------------------------------------------------------------------------
# Create a new account for the user
#----------------------------------------------------------------------------
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
                hashed_password = bcrypt.hashpw(inputted_password.encode('utf-8'), bcrypt.gensalt())
                
                db.execute('''
                            INSERT INTO user_profile (user_name, full_name)
                            VALUES (%s, %s);
                            ''', (inputted_user_name, inputted_name), False) 
                                
                db.execute('''
                            INSERT INTO user_login (user_name, password) 
                            VALUES (%s,%s);
                            ''', (inputted_user_name, hashed_password), False) 
                
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

#----------------------------------------------------------------------------
# Update user profile with the info they input
#----------------------------------------------------------------------------
def update_profile(request):
    if request.method == "POST":
        user = request.session['user_id']
        name = request.POST.get('name')
        bio = request.POST.get('bio')
        comp_id = request.POST.get('comp_id')
        school = request.POST.get('school')
        area_study = request.POST.get('area_study')
        password = request.POST.get('password')
        re_password = request.POST.get('re_password')
        
        db = Database()
        db.execute('''
                   UPDATE user_profile
                   SET full_name=%s, bio=%s, computing_id=%s, school = %s, area_of_study=%s
                   WHERE user_name = %s;
                   ''', (name, bio, comp_id, school, area_study, user), False)
        
        db.update_db_and_close()
        messages.success(request, "Updated Profile!")
        
        return redirect(reverse('user_profile_page'))
    
#----------------------------------------------------------------------------
# Logs the user out if they are signed in
#----------------------------------------------------------------------------
def logout(request):
    if 'user_id' in request.session:
        del request.session['user_id']
        messages.success(request, "You have logged out")
    
    return redirect(reverse('login_page'))