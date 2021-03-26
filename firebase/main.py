import firebase_admin
from firebase_admin import credentials, firestore

cred = credentials.Certificate("./env/serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

users_ref = db.collection("users")

for doc in db.collection("donors").stream():
    print(f"{doc.id} => {doc.to_dict()}")
