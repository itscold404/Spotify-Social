import os
import MySQLdb

def connect_to_db():
    # Environment variables should be defined in app.yaml for GAE deployment
    db_user = os.environ.get('CLOUD_SQL_USERNAME', 'david')  
    db_pass = os.environ.get('CLOUD_SQL_PASSWORD', 'r00tp@ssword')
    db_name = os.environ.get('CLOUD_SQL_DATABASE_NAME', 'spotifySocial_dummy')
    db_socket_dir = os.environ.get('DB_SOCKET_DIR', '/cloudsql')
    instance_connection_name = os.environ.get('INSTANCE_CONNECTION_NAME', 'spotify-social-media:us-east4:spotify-social-media')

    # Check if running on GAE
    if os.environ.get('GAE_ENV', '').startswith('standard'):
        print("TRUE ENTERED FOUND REMOTE")
        # Connect using the Unix socket located at
        # /cloudsql/INSTANCE_CONNECTION_NAME
        cloud_sql_unix_socket = os.path.join(db_socket_dir, instance_connection_name)

        return MySQLdb.connect(
            unix_socket=cloud_sql_unix_socket,
            user=db_user,
            passwd=db_pass,
            db=db_name
        )
    else:
        # Connect using the local development server
        return MySQLdb.connect(
            host='127.0.0.1',
            user=db_user,
            passwd=db_pass,
            db=db_name
        )

# Additional debugging output
# print('Connecting to DB using GAE_ENV:', os.environ.get('GAE_ENV'))
# print('Unix socket path:', os.path.join('/cloudsql', os.environ.get('INSTANCE_CONNECTION_NAME')))

# import os
# import MySQLdb

# def connect_to_db():
#     if os.getenv('GAE_APPLICATION', None):
#         host_val = '/cloudsql/spotify-social-media:us-east4:spotify-social-media'
#     else:
#         # Running locally
#         host_val = '127.0.0.1'
        
#     return MySQLdb.connect(
#         host=host_val,
#         user='david',
#         passwd='r00tp@ssword',
#         db='spotifySocial_dummy'
#     )

# import os
# import MySQLdb

# def connect_to_db():
#     db_user = os.getenv('CLOUD_SQL_USERNAME', 'david')  # Fallback to 'david' if not set
#     db_pass = os.getenv('CLOUD_SQL_PASSWORD', 'r00tp@ssword')  # Fallback to 'r00tp@ssword' if not set
#     db_name = os.getenv('CLOUD_SQL_DATABASE_NAME', 'spotifySocial_dummy')  # Fallback if not set
#     db_socket_dir = os.getenv('DB_SOCKET_DIR', '/cloudsql')
#     instance_connection_name = os.getenv('INSTANCE_CONNECTION_NAME', 'spotify-social-media:us-east4:spotify-social-media')

#     if os.getenv('GAE_APPLICATION', None):
#         # Running on App Engine
#         host_val = os.path.join(db_socket_dir, instance_connection_name)
#     else:
#         # Running locally
#         host_val = '127.0.0.1'

#     try:
#         return MySQLdb.connect(
#             unix_socket=host_val if os.getenv('GAE_APPLICATION', None) else None,
#             host=host_val if not os.getenv('GAE_APPLICATION', None) else None,
#             user=db_user,
#             passwd=db_pass,
#             db=db_name
#         )
#     except MySQLdb.MySQLError as e:
#         print(f"Error connecting to MySQL: {e}")
#         # Handle error as needed