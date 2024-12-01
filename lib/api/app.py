from flask import Flask, request, jsonify, send_file

from flask_sqlalchemy import SQLAlchemy 

import os
import pandas as pd
import hashlib
import tempfile
import secrets
import shutil

from static.utils.HashUtils import HashUtils
from models import db, Item
from interactor import itemScanner
from static.utils.BarcodeScanner import BarcodeScanner

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///database.db"
db.init_app(app)

with app.app_context():
    db.create_all()

hashes = dict()

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
def file():
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



if __name__ == "__main__":
    app.run(debug=True, port=47308)