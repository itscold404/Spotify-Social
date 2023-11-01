import os
import MySQLdb

def connect_to_db():
    if os.getenv('GAE_APPLICATION', None):
        host_val = '/cloudsql/spotify-social-media:us-east4:spotify-social-media'
    else:
        # Running locally
        host_val = '127.0.0.1'
        
    return MySQLdb.connect(
        host=host_val,
        user='david',
        passwd='r00tp@ssword',
        db='spotifySocial_dummy'
    )