from dotenv import load_dotenv
import os
import base64
from requests import post, get
import json

from django.shortcuts import redirect
from django.http import JsonResponse
import urllib

load_dotenv()

client_id = os.getenv("SPOTIFY_CLIENT_ID")
client_secret = os.getenv("SPOTIFY_CLIENT_SECRET")
REDIRECT_URI = 'http://127.0.0.1:8000/home'

# number of songs or artist to retrieve from
LIMIT = 5

# Spotify URLs
SPOTIFY_AUTH_URL = "https://accounts.spotify.com/authorize"
SPOTIFY_TOKEN_URL = "https://accounts.spotify.com/api/token"
SPOTIFY_API_BASE_URL = "https://api.spotify.com"
VERSION = "v1"
SPOTIFY_API_URL = f"{SPOTIFY_API_BASE_URL}/{VERSION}"

# Server-side Parameters
SCOPE = "user-top-read"
STATE = ""
SHOW_DIALOG_bool = True
SHOW_DIALOG_str = str(SHOW_DIALOG_bool).lower()

auth_query_parameters = {
    "response_type": "code",
    "redirect_uri": REDIRECT_URI,
    "scope": SCOPE,
    "client_id": client_id
}

def index(request):
    url_args = "&".join(["{}={}".format(key, urllib.parse.quote(val)) for key, val in auth_query_parameters.items()])
    auth_url = f"https://accounts.spotify.com/authorize/?{url_args}"
    return redirect(auth_url)


def callback(request):
    # Requests refresh and access tokens
    auth_token = request.args['code']
    code_payload = {
        "grant_type": "authorization_code",
        "code": str(auth_token),
        "redirect_uri": REDIRECT_URI
    }
    base64encoded = base64.urlsafe_b64encode(f"{client_id}:{client_secret}".encode()).decode()
    headers = {"Authorization": f"Basic {base64encoded}"}
    post_request = request.post(SPOTIFY_TOKEN_URL, data=code_payload, headers=headers)

    # Tokens are returned to the app
    response_data = post_request.json()
    access_token = response_data["access_token"]

    # Use the access token to access Spotify API
    authorization_header = {"Authorization": f"Bearer {access_token}"}

    # Get user's top tracks
    user_top_tracks_endpoint = f"{SPOTIFY_API_URL}/me/top/tracks"
    top_tracks_response = request.get(user_top_tracks_endpoint, headers=authorization_header)
    top_tracks_data = top_tracks_response.json()

    print(top_tracks_data)
    return top_tracks_data

class Spotify_API:
    def __init__(self):
        self.authorize()
        
    # ----------------------------------------------------------------------------
    # create a new token
    # ----------------------------------------------------------------------------
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
        
        self.auth_header = {"Authorization": "Bearer " + token}
        
        # expired token for testing
        # self.auth_header = {"Authorization": "Bearer " + "BQC2BgR5IBrQ48qAk2liwhO7HbRRPfPq_0UwEboGbGnPQaQwzJ830FGdqT-dygrTdmaGsT4KhxssQB8zEXsO9VzcBpx5dnrnscke-6Dtm76ihGjj1CQ"}
   
    # ----------------------------------------------------------------------------
    # Searches for artist, track, or album
    # type is the item_type of the item ("artist", "track", "album")
    # name is the name of the item you are searching for
    # limit is how many of the item you want
    # ----------------------------------------------------------------------------
    def search_for(self, item_type:str, name:str, limit:int):
        url = "https://api.spotify.com/v1/search"
        headers = self.auth_header
        query = f"?q={name}&type={item_type}&limit={limit}"
        
        query_url = url + query
        result = get(query_url, headers=headers)
        
        loaded_content = json.loads(result.content)
            
        if "error" in loaded_content and loaded_content["error"]["status"] == 401:
            print("error found")
            self.authorize()
            return self.search_for(item_type, name, limit)
        else:
            json_result = loaded_content[f"{item_type}s"]["items"]
            
            if len(json_result) == 0:
                return None
            
            return json_result
    
    # TODO: songs have a preview url
    # ----------------------------------------------------------------------------
    # Search for the top tracks by an artist in the US
    # ----------------------------------------------------------------------------
    def get_songs_by_artist(self, artist_id:str):
        url = f"https://api.spotify.com/v1/artists/{artist_id}/top-tracks?country=US"
        headers = self.auth_header
        result = get(url, headers=headers)
        loaded_content = json.loads(result.content)
        
        if "error" in loaded_content and loaded_content["error"]["status"] == 401:
            self.authorize()
            return self.get_songs_by_artist(artist_id)
        else:
            json_result = loaded_content["tracks"]
            return json_result
    
    # ----------------------------------------------------------------------------
    # Retrieve the top artists and songs of the current user
    # type is ("artists" or "tracks")
    # ----------------------------------------------------------------------------
    def get_user_top_items(self):
        type = "artist"
        url = f"https://api.spotify.com/v1/me/top/{type}"
        headers = self.auth_header
        result = get(url, headers=headers)
        print(result)
        loaded_content = json.loads(result.content)
        
        # if "error" in loaded_content and loaded_content["error"]["status"] == 401:
        #     self.authorize()
        #     return self.get_user_top_items(type)
        # else:
        print(loaded_content)
        json_result = loaded_content["items"]
        print(json_result)
        return json_result
        
        
def test(request):
    spot = Spotify_API()
    spot.authorize()
    spot.get_user_top_items()

# # artist_id = spot.search_for("artist", "IU", 1)[0]["id"]
# # print(artist_id)
# # #print(artist_id)
# # songs = spot.get_songs_by_artist("3HqSLMAZ3g3d5poNaI7GOU")

# # for idx, song in enumerate(songs):
# #     print(str(idx) + ". " + song["name"])
# spot.get_user_top_items("artists")
