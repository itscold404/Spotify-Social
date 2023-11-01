from django.contrib import messages
from django.shortcuts import render, redirect
from django.http import HttpResponse
from spotify_social.utils import connect_to_db
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
        connection = connect_to_db()
        cursor = connection.cursor()
        
        matches = cursor.execute('''
                                    SELECT user_login.password 
                                    FROM user_login
                                    WHERE user_login.user_name = %s;
                                    ''', (inputted_user_name, ) ) #include this trailing comma for single input
        
        print("matches", matches)
        # print("mathces.fetchALL()", cursor.fetchall())
        
        if matches == 0:
            cursor.close()
            connection.close()
            
            messages.error(request, "Invalid Username Password Combination")
            return redirect('login_page')
        
        db_password = cursor.fetchall()
        print("password", db_password)
        
        hashed_password = db_password[0][0]
        print("hashed password", hashed_password)
        
        # Close connections to the database to save resources
        cursor.close()
        connection.close()
        
        # A matching username found, now check if password matches
        # TODO: CREATE HASHING
        # if (matches == 1) and (bcrypt.checkpw(hashed_password, inputted_password)):
        if (matches == 1) and (hashed_password == inputted_password):
                request.session['user_id'] = inputted_user_name
                
                # TODO: create/populate user home page
                # redirect used to ensure user is using a proper url to avoid errors
                return redirect('user_home_page')
        else:
            messages.error(request, "Invalid Username Password Combination")
            return redirect('login_page')


def create_account(request):
    if request.method == "POST":
        
        print("found in session?", "user_inputs" in request.session)
        
        inputted_user_name = request.POST.get('user_name')
        inputted_name = request.POST.get('name')
        inputted_password = request.POST.get('password')
        inputted_re_password = request.POST.get('re_password')
        
        connection = connect_to_db()
        cursor = connection.cursor()
        
        matches = cursor.execute('''
                                SELECT user_login.password 
                                FROM user_login
                                WHERE user_login.user_name = %s;
                                ''', (inputted_user_name, ) ) #include this trailing comma for single input
        
        
        # The username is unique and password matches, create account
        if matches == 0:
            if inputted_password == inputted_re_password:
                cursor.execute('''
                                INSERT INTO user_login (user_name, password) 
                                VALUES (%s,%s);
                                ''', (inputted_user_name, inputted_password)) 
                
                cursor.execute('''
                                INSERT INTO user_profile (user_name, full_name)
                                VALUES (%s, %s);
                                ''', (inputted_user_name, inputted_name)) 
                
                connection.commit()
                cursor.close()
                connection.close()
                
                # user_id will be our main way to tell which user is logged in so what data 
                # he/she will have access to
                request.session['user_id'] = inputted_user_name
                
                return redirect('user_home_page')
            
            else:
                cursor.close()
                connection.close()
                
                messages.error(request, "Passwords Do Not Match")
                
                # Store user input data to be used when sign up page is called again
                request.session['user_inputs'] = [inputted_user_name, inputted_name]   
                return redirect('signup_page')
        else:
            cursor.close()
            connection.close()
            
            messages.error(request, "Username Already Exists")
            request.session['user_inputs'] = [inputted_user_name, inputted_name]            
            return redirect('signup_page')

def logout(request):
    del request.session['user_id']
    messages.success(request, "You have logged out")
    
    return redirect('login_page')