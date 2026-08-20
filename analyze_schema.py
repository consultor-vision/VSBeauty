import os
import requests
import json

url = os.environ.get("VITE_SUPABASE_URL")
key = os.environ.get("VITE_SUPABASE_ANON_KEY")

def query_postgrest(table):
    headers = {"apikey": key, "Authorization": f"Bearer {key}"}
    # Using a select statement that hopefully triggers a schema hint or returns metadata
    r = requests.get(f"{url}/rest/v1/{table}?limit=1", headers=headers)
    return r.json() if r.status_code == 200 else r.text

print("--- Planos Schema Sample ---")
print(query_postgrest("planos"))
print("\n--- Agendamento Schema Sample ---")
print(query_postgrest("agendamento"))
