import os
from barcode import Code128
from barcode.writer import ImageWriter

OUTPUT_DIR = "location"
os.makedirs(OUTPUT_DIR, exist_ok=True)

class LocationBarcodeGenerator:

    def __init__(self, locations: int) -> None:
        self.locations = [f"Location-{i}" for i in range(1, locations + 1)]

    def generateBarcodes(self) -> None:
        for loc in self.locations:
            barcode = Code128(loc, writer=ImageWriter())
            file_path = os.path.join(OUTPUT_DIR, f"{loc}")
            barcode.save(file_path)
            print(f"Barcode saved: {file_path}")

def main():
    locationGen = LocationBarcodeGenerator(10)
    locationGen.generateBarcodes()

if __name__ == "__main__":
    main()