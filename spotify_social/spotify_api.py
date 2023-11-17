from dotenv import load_dotenv
import os
import base64
from requests import post, get
import json

load_dotenv()

CLIENT_ID = os.getenv("SPOTIFY_CLIENT_ID")
CLIENT_SECRET = os.getenv("SPOTIFY_CLIENT_SECRET")
REDIRECT_URI = "http://127.0.0.1:8000/home"

# TODO: UNCOMMENT THIS WHEN PUSHING TO CLOUD
# REDIRECT_URI = "https://spotify-social-media.uk.r.appspot.com/home/"


class Spotify_API:
    def __init__(self):
        # self.auth_code = auth_code
        return

    # ----------------------------------------------------------------------------
    # create a new token
    # ----------------------------------------------------------------------------
    # def get_token(self):
    #     auth_string = CLIENT_ID + ":" + CLIENT_SECRET
    #     auth_bytes = auth_string.encode("utf-8")
    #     auth_base64 = str(base64.b64encode(auth_bytes), "utf-8")

    #     url = "https://accounts.spotify.com/api/token"
    #     headers = {
    #         "Authorization": "Basic " + auth_base64,
    #         "Content-Type": "application/x-www-form-urlencoded",
    #     }

    #     data = {
    #         "code": self.auth_code,
    #         "redirect_uri": REDIRECT_URI,
    #         "grant_type": "authorization_code",
    #     }
    #     result = post(url, headers=headers, data=data)
    #     json_result = json.loads(result.content)
    #     token = json_result["access_token"]

    #     auth_header = {"Authorization": "Bearer " + token}
    #     return auth_header

    # expired token for testing
    # self.auth_header = {"Authorization": "Bearer " + "BQC2BgR5IBrQ48qAk2liwhO7HbRRPfPq_0UwEboGbGnPQaQwzJ830FGdqT-dygrTdmaGsT4KhxssQB8zEXsO9VzcBpx5dnrnscke-6Dtm76ihGjj1CQ"}

    # ----------------------------------------------------------------------------
    # Searches for artist, track, or album
    # type is the item_type of the item ("artist", "track", "album")
    # name is the name of the item you are searching for
    # limit is how many of the item you want
    # ----------------------------------------------------------------------------
    def search_for(self, auth_header: dict, item_type: str, name: str, limit: int):
        url = "https://api.spotify.com/v1/search"
        headers = auth_header
        query = f"?q={name}&type={item_type}&limit={limit}"

        query_url = url + query
        result = get(query_url, headers=headers)

        loaded_content = json.loads(result.content)

        # if "error" in loaded_content and loaded_content["error"]["status"] == 401:
        #     self.get_token()
        #     return self.search_for(item_type, name, limit)
        # else:
        json_result = loaded_content[f"{item_type}s"]["items"]

        if len(json_result) == 0:
            return None

        return json_result

    # TODO: songs have a preview url
    # ----------------------------------------------------------------------------
    # Search for the top tracks by an artist in the US
    # ----------------------------------------------------------------------------
    def get_songs_by_artist(self, auth_header: dict, artist_id: str):
        url = f"https://api.spotify.com/v1/artists/{artist_id}/top-tracks?country=US"
        headers = auth_header
        result = get(url, headers=headers)
        loaded_content = json.loads(result.content)

        # if "error" in loaded_content and loaded_content["error"]["status"] == 401:
        #     self.get_token()
        #     return self.get_songs_by_artist(artist_id)
        # else:
        json_result = loaded_content["tracks"]
        return json_result

    # ----------------------------------------------------------------------------
    # Retrieve the top artists and songs of the current user
    # type is ("artists" or "tracks")
    # ----------------------------------------------------------------------------
    def get_user_top_items(self, auth_header: dict, type: str, limit: int):
        url = f"https://api.spotify.com/v1/me/top/{type}?limit={limit}"
        headers = auth_header
        result = get(url, headers=headers)
        loaded_content = json.loads(result.content)

        # if "error" in loaded_content and loaded_content["error"]["status"] == 401:
        #     self.get_token()
        #     return self.get_user_top_items(type)
        # else:
        json_result = loaded_content["items"]
        return json_result
