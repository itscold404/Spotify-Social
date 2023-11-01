import MySQLdb

def connect_to_db():
    return MySQLdb.connect(
        host='/cloudsql/spotify-social-media:us-east4:spotify-social-media',  
        user='david',
        passwd='r00tp@ssword',
        db='spotifySocial_dummy'
    )