import os
import MySQLdb

def connect_to_db():
    # Environment variables should be defined in app.yaml for GAE deployment
    db_user = os.environ.get('CLOUD_SQL_USERNAME')  
    db_pass = os.environ.get('CLOUD_SQL_PASSWORD')
    db_name = os.environ.get('CLOUD_SQL_DATABASE_NAME', 'spotifySocial_dummy')
    db_socket_dir = os.environ.get('DB_SOCKET_DIR', '/cloudsql')
    instance_connection_name = os.environ.get('INSTANCE_CONNECTION_NAME')
    
    print(db_user, db_pass, db_name, db_socket_dir, instance_connection_name)

    # Check if running on GAE
    if os.environ.get('GAE_ENV', '').startswith('standard'):
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