import MySQLdb

def connect_to_db():
    return MySQLdb.connect(
        # uncomment host below for hosting remotely
        # host='/cloudsql/spotify-social-media:us-east4:spotify-social-media',
        # uncomment the host below for hosting locally 
        host='127.0.0.1', 
        user='david',
        passwd='r00tp@ssword',
        db='spotifySocial_dummy'
    )
    