from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Item(db.Model):
    itemId = db.Column(db.Integer, primary_key=True)
    locationBarcodeData = db.Column(db.String(100), nullable=False)
    itemBarcodeData = db.Column(db.String(100), nullable=False)
    sequence = db.Column(db.Integer, nullable=False)
    quantity = db.Column(db.Integer, nullable=True)
    hashKey = db.Column(db.String(100), nullable=False)