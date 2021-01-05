import requests
import json

def api_post_import_whiteList(header, file_dir, url):
    if file_dir == None:
        r = requests.post(url, None, headers=header)
    else:
        files = {'file': open(file_dir, 'rb')}
        r = requests.post(url, files=files, headers=header)
        print('RRRR:'+r.text)
    return r

