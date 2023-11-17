from requests import get
import json


# ----------------------------------------------------------------------------
# Searches for artist, track, or album
# type is the item_type of the item ("artist", "track", "album")
# name is the name of the item you are searching for
# limit is how many of the item you want
# ----------------------------------------------------------------------------
def search_for(auth_header: dict, item_type: str, name: str, limit: int):
    url = "https://api.spotify.com/v1/search"
    headers = auth_header
    query = f"?q={name}&type={item_type}&limit={limit}"

    query_url = url + query
    result = get(query_url, headers=headers)

    loaded_content = json.loads(result.content)

    if "error" in loaded_content:
        print("ERROR:", result)
    else:
        json_result = loaded_content[f"{item_type}s"]["items"]

        if len(json_result) == 0:
            return None

        return json_result


# TODO: songs have a preview url
# ----------------------------------------------------------------------------
# Search for the top tracks by an artist in the US
# ----------------------------------------------------------------------------
def get_songs_by_artist(auth_header: dict, artist_id: str):
    url = f"https://api.spotify.com/v1/artists/{artist_id}/top-tracks?country=US"
    headers = auth_header
    result = get(url, headers=headers)
    loaded_content = json.loads(result.content)

    if "error" in loaded_content:
        print("ERROR:", result)
    else:
        json_result = loaded_content["tracks"]
        return json_result


# ----------------------------------------------------------------------------
# Retrieve the top artists and songs of the current user
# type is ("artists" or "tracks")
# ----------------------------------------------------------------------------
def get_user_top_items(auth_header: dict, type: str, limit: int):
    url = f"https://api.spotify.com/v1/me/top/{type}?limit={limit}"
    headers = auth_header
    result = get(url, headers=headers)
    loaded_content = json.loads(result.content)

    if "error" in loaded_content:
        print("ERROR:", result)
    else:
        json_result = loaded_content["items"]
        return json_result
