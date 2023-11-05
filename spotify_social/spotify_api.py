from dotenv import load_dotenv
import os
import base64
from requests import post, get
import json

load_dotenv()

client_id = os.getenv("SPOTIFY_CLIENT_ID")
client_secret = os.getenv("SPOTIFY_CLIENT_SECRET")


# TODO: handle error 401 (token expired)
class Spotify_API:
    def __init__(self):
        return
    
    def authorize(self):
        auth_string = client_id + ":" + client_secret
        auth_bytes = auth_string.encode("utf-8")
        auth_base64 = str(base64.b64encode(auth_bytes), "utf-8")
        
        url = "https://accounts.spotify.com/api/token"
        headers = {
            "Authorization": "Basic " + auth_base64,
            "Content-Type": "application/x-www-form-urlencoded"
        }
        
        data = {"grant_type": "client_credentials"}
        result = post(url, headers = headers, data = data)
        json_result = json.loads(result.content)
        token = json_result["access_token"]
        print(token)
        
        # self.auth_header = {"Authorization": "Bearer " + token}
        self.auth_header = {"Authorization": "Bearer " + "BQC2BgR5IBrQ48qAk2liwhO7HbRRPfPq_0UwEboGbGnPQaQwzJ830FGdqT-dygrTdmaGsT4KhxssQB8zEXsO9VzcBpx5dnrnscke-6Dtm76ihGjj1CQ"}
    
    # Searches for artist, track, or album
    # type is the type of the item ("artist", "track", "album")
    # name is the name of the item you are searching for
    # limit is how many of the item you want
    def search_for(self, type, name, limit):
        url = "https://api.spotify.com/v1/search"
        headers = self.auth_header
        query = f"?q={name}&type={type}&limit={limit}"
        
        query_url = url + query
        result = get(query_url, headers=headers)
        
        # bad/expired token
        if "error" in result:
            print("error number was", result["error"])
            return self.search_for(type, name, limit)
        
        json_result = json.loads(result.content)[f"{type}s"]["items"]
        
        if len(json_result) == 0:
            return None
        
        return json_result
    
    # TODO: songs have a preview url
    # Search for the top tracks by an artist in the US
    def get_songs_by_artist(self, artist_id):
        url = f"https://api.spotify.com/v1/artists/{artist_id}/top-tracks?country=US"
        headers = self.auth_header
        result = get(url, headers=headers)
        
        # bad/expired token
        if "error" in result:
            print("error number was", result["error"])
            return self.get_songs_by_artist(artist_id)
        
        json_result = json.loads(result.content)["tracks"]
        return json_result
        
        


spot = Spotify_API()
spot.authorize()

artist_id = spot.search_for("artist", "IU", 1)[0]["id"]

print(artist_id)
songs = spot.get_songs_by_artist(artist_id)

for idx, song in enumerate(songs):
    print(str(idx) + ". " + song["name"])
