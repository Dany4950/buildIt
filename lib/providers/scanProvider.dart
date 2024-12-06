// import 'dart:convert';
// import 'dart:math';
// import 'package:buildittt/models/barcodeModel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

// class scanLocationBarcode extends ChangeNotifier {
//   String? locationHash; // Stores the hash key for the location barcode
//   List<ScanModel> itemBarcodes = []; // Stores item barcodes

// TextEditingController quantityContoller = TextEditingController();

//   /// Scans a barcode for location
//   Future<void> scanBarcode() async {
//     String barcode = await FlutterBarcodeScanner.scanBarcode(
//       '#ff6666', // Scanner overlay color
//       'Cancel', // Cancel button text
//       true, // Show flash button
//       ScanMode.BARCODE, // Scan mode
//     );

//     try {
//       final response = await http.post(
//         Uri.parse('http://3.111.72.98:8000/locationData'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'locationData': barcode}),
//       );

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         locationHash = responseData['usageHash'];
//         notifyListeners();
//       } else {
//         throw Exception("Failed to fetch location hash");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   /// Scans item barcodes
//   Future<void> scanItemBarcode() async {
//     String barcode = await FlutterBarcodeScanner.scanBarcode(
//       '#ff6666',
//       'Cancel',
//       true,
//       ScanMode.BARCODE,
//     );

//     if (barcode != '-1') {
//       itemBarcodes.add(ScanModel(barcode: barcode));
//       notifyListeners();
//     }
//   }

//   /// Clears all item barcodes
//   void clearItemBarcodes() {
//     itemBarcodes.clear();
//     notifyListeners();
//   }

//   // /// Sends all item barcodes to the server
//   // Future<void> sendItemsToServer() async {
//   //   if (locationHash == null || itemBarcodes.isEmpty) {
//   //     print("Location hash or items are missing");
//   //     return;
//   //   }

//   //   try {
//   //     final response = await http.post(
//   //       Uri.parse('http://3.111.72.98:8000/updateItems'), // Update endpoint
//   //       headers: {'Content-Type': 'application/json'},
//   //       body: jsonEncode({
//   //         'locationHash': locationHash,
//   //         'items': itemBarcodes.map((e) => e.barcode).toList(),
//   //         if (quantityContoller.value != null) 'quantity': quantityContoller.value,
//   //       }),
//   //     );

//   //     if (response.statusCode == 200) {
//   //       print("Items successfully updated");
//   //     } else {
//   //       print("Failed to update items: ${response.statusCode}");
//   //     }
//   //   } catch (e) {
//   //     print("Error sending items: $e");
//   //   }
//   // }

//   // /// Sends all item barcodes to the server
// Future<void> sendItemsToServer() async {
//   if (locationHash == null || itemBarcodes.isEmpty) {
//     print("Location hash or items are missing");
//     return;
//   }

//   // Retrieve quantity from the TextField
//   String quantityText = quantityContoller.text;
//   int? itemQuantity;

//   // Validate and parse the quantity
//   if (quantityText.isNotEmpty) {
//     try {
//       itemQuantity = int.parse(quantityText);
//     } catch (e) {
//       print("Invalid quantity input");
//       return; // Exit the function if quantity is invalid
//     }
//   }

//   try {
//     final response = await http.post(
//       Uri.parse('http://3.111.72.98:8000/itemsData'), // Correct endpoint
//       headers: {
//         'Content-Type': 'application/json',
//         'Locationdata': locationHash!, // Include location hash as header
//         'Hashkey': locationHash!, // Include hash key as header
//       },
//       body: jsonEncode({
//         'itemBarcodeData': itemBarcodes.map((e) => e.barcode).toList(),
//         if (itemQuantity != null) 'quantity': itemQuantity, // Include quantity if available
//       }),
//     );

//     if (response.statusCode == 200) {
//       print("Items successfully updated");
//     } else {
//       print("Failed to update items: ${response.statusCode}");
//        print("Error sending items: $e");
//     }
//   } catch (e) {
//     print("Error sending items: $e");
//   }
// }

//   /// Downloads the CSV file from the server

//   /// Downloads the CSV file from the server
//   Future<void> downloadFile(String locationHash, BuildContext context) async {
//     if (locationHash.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Location hash is missing')),
//       );
//       return;
//     }

//     final url = Uri.parse(
//         'http://3.111.72.98:8000/file'); // Replace with your server URL

//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'LocationData': locationHash, // Send the location hash in the headers
//           'HashKey': locationHash, // Send the hash key
//         },
//       );

//       if (response.statusCode == 200) {
//         final fileUrl =
//             response.body; // Get the file URL from the server response
//         print("File URL: $fileUrl");

//         // Start downloading the file using flutter_downloader
//         final dir = await getApplicationDocumentsDirectory();
//         final savePath = '${dir.path}/saved.csv';

//         final taskId = await FlutterDownloader.enqueue(
//           url: fileUrl,
//           savedDir: dir.path,
//           fileName: "saved.csv",
//           showNotification: true,
//           openFileFromNotification: true,
//         );

//         print("Download started with taskId: $taskId");

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('File downloaded successfully!')),
//         );
//       } else {
//         print('Error: ${response.statusCode}, Body: ${response.body}');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to download the file.')),
//         );
//       }
//     } catch (e) {
//       print('Error occurred while downloading: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error occurred while downloading the file.')),
//       );
//     }
//   }

// import 'dart:convert';
// import 'dart:math';
// import 'package:buildittt/models/barcodeModel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

// class scanLocationBarcode extends ChangeNotifier {
//   String? locationHash; // Stores the hash key for the location barcode
//   List<ScanModel> itemBarcodes = []; // Stores item barcodes

//   TextEditingController quantityController = TextEditingController();

//   /// Scans a barcode for location
//   Future<void> scanBarcode() async {
//     String barcode = await FlutterBarcodeScanner.scanBarcode(
//       '#ff6666', // Scanner overlay color
//       'Cancel', // Cancel button text
//       true, // Show flash button
//       ScanMode.BARCODE, // Scan mode
//     );

//     try {
//       final response = await http.post(
//         Uri.parse('http://3.111.72.98:8000/locationData'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'locationData': barcode}),
//       );

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         locationHash = responseData['usageHash'];
//         notifyListeners();
//       } else {
//         throw Exception("Failed to fetch location hash");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

// /// Scans item barcodes
// Future<void> scanItemBarcode() async {
//   String barcode = await FlutterBarcodeScanner.scanBarcode(
//     '#ff6666',
//     'Cancel',
//     true,
//     ScanMode.BARCODE,
//   );

//   if (barcode != '-1') {
//     itemBarcodes.add(ScanModel(barcode: barcode));
//     notifyListeners();
//   }
// }

/// Clears all item barcodes

/// Sends all item barcodes to the server
// //
// Future<void> sendItemsToServer() async {
//   if (locationHash == null || itemBarcodes.isEmpty) {
//     print("Location hash or items are missing");
//     return;
//   }

//   try {
//     // Prepare request body
//     final requestBody = jsonEncode({
//       'itemBarcodeData': itemBarcodes.map((e) => e.barcode).toList(),
//     });

//     print("Request Body: $requestBody");

//     // Send HTTP POST request
//     final response = await http.post(
//       Uri.parse('http://3.111.72.98:8000/itemsData'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Locationdata': locationHash!, // Header for location data
//         'Hashkey': locationHash!, // Add hash key header
//       },
//       body: requestBody,
//     );

//     // Handle response
//     print('Location Hash: $locationHash');
//     print("Response Status: ${response.statusCode}");
//     print("Response Body: ${response.body}");

//     if (response.statusCode == 200) {
//       print("Items successfully updated");
//     } else {
//       print("Headers: Locationdata=$locationHash, Hashkey=$locationHash");
//       print("Failed to update items: ${response.statusCode}");
//       print("Response Body: ${response.body}");
//     }
//   } catch (e) {
//     print("Error sending items: $e");
//   }
// }
import 'dart:convert';
import 'package:buildittt/models/barcodeModel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class scanLocationBarcode extends ChangeNotifier {
  
  String? locationHash; // Stores the hash key for the location barcode
  List<ScanModel> itemBarcodes = []; // Stores item barcodes
  final List<ScanModel> Locationbarcodes = [];
  TextEditingController quantityContoller = TextEditingController();

  /// Scans a barcode for location
  Future<void> scanBarcode() async {
    String Locationbarcode = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    if (Locationbarcode != '-1') {
      Locationbarcodes.add(ScanModel(barcode: Locationbarcode));
      // Optionally, you can also add the barcode to a list

      notifyListeners();
    }

    try {
      final response = await http.post(
        Uri.parse('http://3.111.72.98:8000/locationData'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'locationData': Locationbarcode}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        locationHash = responseData['usageHash'];
        notifyListeners();
      } else {
        throw Exception("Failed to fetch location hash");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  /// Scans item barcodes
  Future<void> scanItemBarcode() async {
    String barcode = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.BARCODE,
    );

    if (barcode != '-1') {
      itemBarcodes.add(ScanModel(barcode: barcode));
      notifyListeners();
    }
  }

  /// Clears all item barcodes
  void clearItemBarcodes() {
    itemBarcodes.clear();
    notifyListeners();
  }

  /// Sends all item barcodes to the server
  Future<void> sendItemsToServer() async {
    if (locationHash == null || itemBarcodes.isEmpty) {
      print("Location hash or items are missing");
      return;
    }
// String locationBarcode = await scanBarcode();
    // Retrieve quantity from the TextField
    String quantityText = quantityContoller.text;
    int? itemQuantity;

    // Validate and parse the quantity
    if (quantityText.isNotEmpty) {
      try {
        itemQuantity = int.parse(quantityText);
      } catch (e) {
        print("Invalid quantity input");
        return; // Exit the function if quantity is invalid
      }
    }

    try {
      print("items");
      print(itemBarcodes);
      print(itemBarcodes.map((e) => e.barcode).toString());
      print(locationHash!);
      print(Locationbarcodes.isNotEmpty ? Locationbarcodes.first.barcode : '');
      final response = await http.post(
        Uri.parse('http://3.111.72.98:8000/itemsData'),
        headers: {
          'Content-Type': 'application/json',
          "Locationdata":
              Locationbarcodes.isNotEmpty ? Locationbarcodes.first.barcode : '',
          "Hashkey": locationHash!,
        },
        body: jsonEncode({
          'itemBarcodeData': itemBarcodes.map((e) => e.barcode).toString(),
          'quantity': itemQuantity,
        }),
      );
      final responsee = response.body;
      if (response.statusCode == 200) {
        print("Items successfully updated");
        print(response.body);
      } else {
        print(response.body);

        print("Failed to update items: ${response.statusCode}");
      }
    } catch (e) {
      print("Error sending items: $e");
    }
  }
}
