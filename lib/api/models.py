from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Item(db.Model):
    itemId = db.Column(db.Integer, primary_key=True)
    locationBarcodeData = db.Column(db.String(100), nullable=False)
    itemBarcodeData = db.Column(db.String(100), nullable=False)
    sequence = db.Column(db.Integer, nullable=False)
    quantity = db.Column(db.Integer, nullable=True)
    hashKey = db.Column(db.String(100), nullable=False)

class LoadingNote(db.Model):
    loadingNoteId = db.Column(db.Integer, primary_key=True)
    loadingNote = db.Column(db.String(100), nullable=True)
    itemBarcodeData = db.Column(db.String(100), nullable=True)
    locationBarcodeData = db.Column(db.String(100), nullable=False)
    present = db.Column(db.Boolean, nullable=False)

class User(db.Model):
    __tablename__ = "users"
    userId = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=True)
    password = db.Column(db.String(120), nullable=False)
