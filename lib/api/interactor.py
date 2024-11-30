import os
import json

from static.utils.BarcodeScanner import BarcodeScanner
from static.utils.HashUtils import HashUtils

def itemScanner(filePath: str) -> list[str]:
    allItems = os.listdir(filePath)
    images = [os.path.abspath(os.path.join(filePath, item)) for item in allItems if os.path.isfile(os.path.join(filePath, item))]

    scanned = []
    for path in images:
        codeScanner = BarcodeScanner(path)
        answer = codeScanner.decode()
        if answer["status"] == "success":
            scanned.append(answer["data"])

    return scanned