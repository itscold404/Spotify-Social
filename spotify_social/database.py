import os
import MySQLdb
from dotenv import load_dotenv
  
class Database:
    def __init__(self):
        load_dotenv()
        db_user = os.getenv('CLOUD_SQL_USERNAME')  
        db_pass = os.getenv('CLOUD_SQL_PASSWORD')
        db_name = os.getenv('CLOUD_SQL_DATABASE_NAME')
        db_socket_dir = os.getenv('DB_SOCKET_DIR')
        instance_connection_name = os.getenv('INSTANCE_CONNECTION_NAME')

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
            
    #----------------------------------------------------------------------------
    # executes the sql query 
    #----------------------------------------------------------------------------
    def execute(self, query:str, args:tuple, returnResult:bool):
        self.cursor = self.connection.cursor()
        
        num_matches = self.cursor.execute(query, args)
        matches = self.cursor.fetchall()
        
        if returnResult:
            return (num_matches, matches)
    
    #----------------------------------------------------------------------------
    # update and close the database connection
    #----------------------------------------------------------------------------
    def update_db_and_close(self):
        self.connection.commit()
        self.close()
    
    #----------------------------------------------------------------------------
    # closes the database connection without updating the database
    #----------------------------------------------------------------------------
    def close(self):
        self.cursor.close()
        self.connection.close()
        