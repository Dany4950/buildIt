from flask import Flask, request, jsonify, send_file
from flask_sqlalchemy import SQLAlchemy
import os
import pandas as pd
import tempfile
import secrets
import shutil
import json

from static.utils.HashUtils import HashUtils
from models import db, Item, LoadingNote, User
from interactor import itemScanner
from static.utils.BarcodeScanner import BarcodeScanner
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///database.db"
db.init_app(app)

def createDummy():
    with app.app_context():
        db.drop_all()
        db.create_all()

        dummyData = [
            LoadingNote(loadingNote="LN001", itemBarcodeData="ITEM001", locationBarcodeData="LOC001", present=False),
            LoadingNote(loadingNote="LN001", itemBarcodeData="ITEM002", locationBarcodeData="LOC001", present=False),
            LoadingNote(loadingNote="LN002", itemBarcodeData="ITEM003", locationBarcodeData="LOC002", present=False),
            LoadingNote(loadingNote="LN003", itemBarcodeData="ITEM004", locationBarcodeData="LOC003", present=False),
        ]

        db.session.bulk_save_objects(dummyData)
        db.session.commit()
        print("Dummy data added.")

    
createDummy()

with app.app_context():
    db.create_all()

hashes = dict()


@app.route("/login", methods=["POST"])
def login():
    data = request.json
    required_fields = ["email", "password"]
    if not all(field in data for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400

    user = User.query.filter_by(email=data["email"]).first()
    if not user or not check_password_hash(user.password, data["password"]):
        return jsonify({"error": "Invalid email or password"}), 401

    return jsonify({"message": "Login Successful", "username": user.username}), 200

@app.route("/signup", methods=["POST"])
def signup():
    data = request.json
    required_fields = ["username", "email", "password"]
    if not all(field in data for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400
    
    existing_user = User.query.filter_by(email=data["email"]).first()
    if existing_user:
        return jsonify({"error": "User already exists."}), 400

    hashed_password = generate_password_hash(data["password"])
    
    new_user = User(
        username=data["username"],
        email=data["email"],
        password=hashed_password
    )
    db.session.add(new_user)
    db.session.commit()
    return jsonify({"message": "User created successfully"}), 201

@app.route("/location", methods=["POST"])
def location():
    if "barcodeImage" not in request.files:
        return jsonify({"error": "No barcode file was found"}), 400

    imageFile = request.files["barcodeImage"]
    locationBarcodeValues = itemScanner("static/images/location")

    with tempfile.NamedTemporaryFile(delete=False, suffix=".png") as TempFile:
        imageFile.save(TempFile.name)
        imagePath = TempFile.name

    barcodeScanner = BarcodeScanner(imagePath)
    result = barcodeScanner.decode()
    os.remove(imagePath)

    hashSecret = secrets.token_urlsafe(16)
    result["usageHash"] = hashSecret
    hashes[result["data"]] = hashSecret
    return jsonify(result)


@app.route("/items", methods=["POST"])
def items():
    recievedHeaders = dict(request.headers)
    requiredHeaders = ["Locationdata", "Hashkey"]
    for header in requiredHeaders:
        if header not in recievedHeaders:
            return jsonify({"error": "Missing headers"}), 400
    
    locationData = request.headers["locationData"]
    hashKey = request.headers["hashKey"]

    if locationData not in hashes or hashes[locationData] != hashKey:
        return jsonify({"error": "Invalid hash key or location data."}), 400

    if "itemBarcodeImage" not in request.files:
        return jsonify({"error": "Barcode image was not provided."}), 400

    itemBarcode = request.files["itemBarcodeImage"]
    with tempfile.NamedTemporaryFile(delete=False, suffix=".png") as BarcodeTemp:
        itemBarcode.save(BarcodeTemp.name)
        imagePath = BarcodeTemp.name

    barcodeScanner = BarcodeScanner(imagePath)
    result = barcodeScanner.decode()
    os.remove(imagePath)

    if not result or "data" not in result:
        return jsonify({"error": "Failed to decode image."}), 400

    itemBarcodeData = result["data"]

    itemQuantity = None
    if "quantity" in request.form:
        try:
            itemQuanity = int(request.form["quantity"])
        except ValueError:
            return jsonify({"error": "Quantity must be an integer"}), 400
    
    lastItem = Item.query.order_by(Item.sequence.desc()).first()
    sequence = lastItem.sequence + 1 if lastItem else 1

    all_items = Item.query.all()
    for item in all_items:
        print(f"ID: {item.itemId}, Location: {item.locationBarcodeData}, Item Barcode: {item.itemBarcodeData}, Sequence: {item.sequence}, Quantity: {item.quantity}, Hash Key: {item.hashKey}")

    newItem = Item(
        locationBarcodeData=locationData,
        itemBarcodeData=itemBarcodeData,
        sequence=sequence,
        quantity=itemQuantity,
        hashKey=hashKey
    )
    db.session.add(newItem)
    db.session.commit()

    return jsonify({
        "message": "Item successfully stored.",
        "item": {
            "locationBarcodeData": locationData,
            "itemBarcodeData": itemBarcodeData,
            "sequence": sequence,
            "quantity": itemQuantity
        }
    }), 201


@app.route("/file", methods=["POST"])
def files():
    recievedHeaders = dict(request.headers)
    requiredHeaders = ["Locationdata", "Hashkey"]
    for header in requiredHeaders:
        if header not in recievedHeaders:
            return jsonify({"error": "Missing headers"}), 400
    
    locationData = request.headers["locationData"]
    hashKey = request.headers["hashKey"]

    if locationData not in hashes or hashes[locationData] != hashKey:
        return jsonify({"error": "Invalid hash key or location data."}), 400

    hashes.pop(locationData)

    items = Item.query.all()
    df = pd.DataFrame(
        [(i.locationBarcodeData, i.itemBarcodeData, i.sequence, i.quantity) for i in items],
        columns=['locationBarcodeData', 'itemBarcodeData', 'sequence', 'quantity']
    )
    csvFile = "static/data/saved.csv"
    df.to_csv(csvFile, index=False)
    return send_file(csvFile, as_attachment=True)

@app.route("/locationData", methods=["POST"])
def locationData():
    if not request.is_json:
        return jsonify({"error": "Request must be json."}), 400
    data = request.get_json()
    if "locationData" not in data:
        return jsonify({"error": "No location data was found"}), 400

    locationData = data["locationData"]
    result = {
        "data": locationData,
        "status": "success",
    }

    hashSecret = secrets.token_urlsafe(16)
    result["usageHash"] = hashSecret
    hashes[result["data"]] = hashSecret
    return jsonify(result)

@app.route("/itemsData", methods=["POST"])
def itemsData():
    received_headers = dict(request.headers)
    required_headers = ["Locationdata", "Hashkey"]
    for header in required_headers:
        if header not in received_headers:
            return jsonify({"error": "Missing headers"}), 400

    location_data = request.headers["Locationdata"]
    hash_key = request.headers["Hashkey"]

    if location_data not in hashes or hashes[location_data] != hash_key:
        return jsonify({"error": "Invalid hash key or location data."}), 400

    if not request.is_json:
        return jsonify({"error": "Request must be JSON"}), 400

    data = request.get_json()

    if "itemBarcodeData" not in data:
        return jsonify({"error": "No item barcode data was found in the payload."}), 400

    item_barcode_data = data["itemBarcodeData"]

    item_quantity = None
    if "quantity" in data:
        try:
            item_quantity = int(data["quantity"])
        except ValueError:
            return jsonify({"error": "Quantity must be an integer"}), 400

    last_item = Item.query.order_by(Item.sequence.desc()).first()
    sequence = last_item.sequence + 1 if last_item else 1

    all_items = Item.query.all()
    for item in all_items:
        print(f"ID: {item.itemId}, Location: {item.locationBarcodeData}, Item Barcode: {item.itemBarcodeData}, Sequence: {item.sequence}, Quantity: {item.quantity}, Hash Key: {item.hashKey}")

    new_item = Item(
        locationBarcodeData=location_data,
        itemBarcodeData=item_barcode_data,
        sequence=sequence,
        quantity=item_quantity,
        hashKey=hash_key
    )
    db.session.add(new_item)
    db.session.commit()

    return jsonify({
        "message": "Item successfully stored.",
        "item": {
            "locationBarcodeData": location_data,
            "itemBarcodeData": item_barcode_data,
            "sequence": sequence,
            "quantity": item_quantity
        }
    }), 201

@app.route("/query", methods=["POST"])
def query() -> json:
    if not request.is_json:
        return jsonify({"error": "Request must a JSON."}), 400
    
    data = request.get_json()

    if "locationBarcodeData" not in data:
        return jsonify({"error": "No locationBarcodeData provided."}), 400

    locationBarcodeData = data["locationBarcodeData"]
    matchingItems = Item.query.filter_by(locationBarcodeData=locationBarcodeData).all()

    if not matchingItems:
        return jsonify({"message": "No items found for the provided locationBarcodeData."}), 404
    
    items_list = [
        {
            "itemId": item.itemId,
            "locationBarcodeData": item.locationBarcodeData,
            "itemBarcodeData": item.itemBarcodeData,
            "sequence": item.sequence,
            "quantity": item.quantity,
        }
        for item in matchingItems
    ]

    return jsonify({
        "message": "Query successful.",
        "items": items_list
    }), 200

@app.route("/verifyLN", methods=["POST"])
def verifyLoadingNote():
    data = request.get_json()
    if "loadingNote" not in data:
        return jsonify({"error": "Loading note is not present in the request."}), 400

    result = LoadingNote.query.filter(LoadingNote.loadingNote.contains(data["loadingNote"])).first()
    if result:
        return jsonify({"status": "verified"}), 200
    else:
        return jsonify({"status": "unverified"}), 404

@app.route("/verifyBarcodeLN", methods=["POST"])
def verifyBarcode():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Invalid or missing JSON in request."}), 400

    required = ["itemBarcodeDataSent", "loadingNote"]
    for item in required:
        if item not in data:
            return jsonify({"error": "Missing data."}), 400

    itemBarcodeDataSent = data["itemBarcodeDataSent"]
    loadingNote = data["loadingNote"]
    
    matching = LoadingNote.query.filter_by(loadingNote=loadingNote).all()
    if not matching:
        return jsonify({"error": "No matching rows for the provided loading note."}), 404 

    for row in matching:
        if row.itemBarcodeData == itemBarcodeDataSent:
            row.present = True
            db.session.commit()
            return jsonify({"status": "verified", "message": "Barcode data matched and updated"}), 200
    
    return jsonify({"status": "unverified", "message": "Item barcode not found in loading note."}), 404

    
if __name__ == "__main__":
    app.run(debug=True)