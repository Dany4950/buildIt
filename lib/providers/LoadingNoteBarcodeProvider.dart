import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BarcodeProvider extends ChangeNotifier {
  bool isBarcodeVerified = false;
  String? scannedBarcode;
  String errorMessage = "";

  /// Verify Barcode against the Loading Note
  Future<void> verifyBarcode(String loadingNote, String barcode) async {
    final url = Uri.parse('http://3.111.72.98:8000/verifyBarcodeLN'); // Update your server URL
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "itemBarcodeDataSent": barcode,
          "loadingNote": loadingNote,
        }),
      );

      if (response.statusCode == 200) {
        isBarcodeVerified = true;
        scannedBarcode = barcode;
        errorMessage = "";
      } else {
        isBarcodeVerified = false;
        scannedBarcode = barcode;
        errorMessage = "Barcode not found for this loading note.";
      }
    } catch (e) {
      errorMessage = "An error occurred: $e";
      isBarcodeVerified = false;
    }
    notifyListeners();
  }
}
