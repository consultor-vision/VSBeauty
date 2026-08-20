import os
import json
import requests

url = os.environ.get("VITE_SUPABASE_URL")
key = os.environ.get("VITE_SUPABASE_ANON_KEY")

if not url or not key:
    print("Missing environment variables")
    exit(1)

# Try to get tables info via PostgREST OpenAPI
response = requests.get(f"{url}/rest/v1/", headers={"apikey": key})
if response.status_code == 200:
    print(json.dumps(response.json(), indent=2))
else:
    print(f"Error: {response.status_code}")
    print(response.text)
