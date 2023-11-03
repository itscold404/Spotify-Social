import os
import MySQLdb
from decouple import config

def connect_to_db():
    db_user = config('CLOUD_SQL_USERNAME')  
    db_pass = config('CLOUD_SQL_PASSWORD')
    db_name = config('CLOUD_SQL_DATABASE_NAME', 'spotifySocial_dummy')
    db_socket_dir = config('DB_SOCKET_DIR', '/cloudsql')
    instance_connection_name = config('INSTANCE_CONNECTION_NAME')

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
        
class Database:
    def __init__(self):
        db_user = config('CLOUD_SQL_USERNAME')  
        db_pass = config('CLOUD_SQL_PASSWORD')
        db_name = config('CLOUD_SQL_DATABASE_NAME', 'spotifySocial_dummy')
        db_socket_dir = config('DB_SOCKET_DIR', '/cloudsql')
        instance_connection_name = config('INSTANCE_CONNECTION_NAME')

        # Check if running on GAE
        if os.environ.get('GAE_ENV', '').startswith('standard'):
            # Connect using the Unix socket located at
            # /cloudsql/INSTANCE_CONNECTION_NAME
            cloud_sql_unix_socket = os.path.join(db_socket_dir, instance_connection_name)

            self.connection = MySQLdb.connect(
                unix_socket=cloud_sql_unix_socket,
                user=db_user,
                passwd=db_pass,
                db=db_name
            )
        else:
            # Connect using the local development server
            self.connection = MySQLdb.connect(
                host='127.0.0.1',
                user=db_user,
                passwd=db_pass,
                db=db_name
            )
            
    def execute(self, query:str, args:tuple, returnResult):
        self.cursor = self.connection.cursor()
        
        num_matches = self.cursor.execute(query, args)
        matches = self.cursor.fetchall()
        
        if returnResult:
            return (num_matches, matches)
    
    def update_db_and_close(self):
        self.connection.commit()
        self.cursor.close()
        self.connection.close()
        
    def close(self):
        self.cursor.close()
        self.connection.close()
        