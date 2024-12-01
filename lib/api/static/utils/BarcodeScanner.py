from pyzbar.pyzbar import decode
from PIL import Image

class BarcodeScanner:

    def __init__(self, imagePath: str) -> None:
        try:
            self.image = Image.open(imagePath)
        except Exception as ConstructorError:
            print(f"Program Failed. Error: {ConstructorError}.")
            exit(1)

    def decode(self) -> dict:
        try:
            decoded = decode(self.image)

            if not decoded:
                return {"error": "No barcodes were found", "status": "failed"}
            else:
                if len(decoded) > 1:
                    return {"error": "The image has more that 1 barcode.", "status": "failed"}
                for obj in decoded:
                    return {
                        "type": f"{obj.type}",
                        "data": f"{obj.data.decode("utf-8")}",
                        "status": "success",
                    }
        except FileNotFoundError:
            return {"error": "File path does not exist.", "status": "failed"}
        except Exception as DecodeError:
            return {"error": f"{DecodeError}", "status": "failed"}

def main():
    scanner = BarcodeScanner(imagePath="../location/Location-1.png")
    print(scanner.decode())


if __name__ == "__main__":
    main()