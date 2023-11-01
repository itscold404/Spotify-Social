from django.shortcuts import render
from django.http import HttpResponse
from spotify_social.utils import connect_to_db
    
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
    return HttpResponse('this is the sign up page')


def login_page(request):
    return HttpResponse('this is the log in page')