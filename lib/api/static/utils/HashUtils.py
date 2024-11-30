import hashlib
import base64

class HashUtils:

    def __init__(self, algorithm: str = "sha256") -> None:
        self.algo = algorithm

    def generateHash(self, data: bytes) -> bytes:
        hasher = hashlib.new(self.algo)
        hasher.update(data)
        return hasher.digest()

    def encodeHash(self, digest: bytes) -> bytes:
        return base64.b64encode(digest)

    def decodeHash(self, encodedHash: bytes) -> bytes:
        return base64.b64decode(encodedHash)

    def verify(self, original: bytes, encoded: bytes) -> bool:
        originalHash = self.generateHash(original)
        decodedHash = self.decodeHash(encoded)
        return originalHash == decodedHash

def main():
    hashUtilsObj = HashUtils()
    data = b"Hello, World!"
    digest = hashUtilsObj.generateHash(data)
    encoded = hashUtilsObj.encodeHash(digest=digest)
    print(hashUtilsObj.verify(data, encoded))

if __name__ == "__main__":
    main()