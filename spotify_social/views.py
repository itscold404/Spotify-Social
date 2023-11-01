from django.shortcuts import render
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
    return HttpResponse('this is the signup page')


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
        
        db_password = cursor.fetchall()
        print("password", db_password)
        
        hashed_password = db_password[0][0]
        print("hashed password", hashed_password)
        
        # Saves changes to the Database if needed use
        # connection.commit()
        
        # Close connections to the database to save resources
        cursor.close()
        connection.close()
        
        # A matching username found, now check if password matches
        # TODO: CREATE HASHING
        # if (matches == 1) and (bcrypt.checkpw(hashed_password, inputted_password)):
        if (matches == 1) and (hashed_password == inputted_password):
                request.session['user_id'] = inputted_user_name
                return HttpResponse('authorized')
        else:
            message = ["Invalid Username and Password Combination"]
            return render(request, 'login_page.html', {'messages':message})


def logout(request):
    del request.session['user_id']
    message = ["You have logged out"]
    
    return render(request, 'login_page.html', {'messages':message})