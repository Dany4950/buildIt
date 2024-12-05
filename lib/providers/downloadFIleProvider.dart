// import 'package:buildittt/providers/scanProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';

// class Downloadfileprovider extends ChangeNotifier {
//   final ScanProvider = Provider.of<scanLocationBarcode>(context);

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


// }

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:buildittt/providers/scanProvider.dart';

class Downloadfileprovider extends ChangeNotifier {
  /// Downloads the CSV file from the server
  Future<void> downloadFile(BuildContext context) async {
    // Fetch location hash from ScanProvider
    final scanProvider = Provider.of<scanLocationBarcode>(context, listen: false);
    final locationHash = scanProvider.locationHash; // Assuming locationHash is a field in ScanLocationBarcode

    if (locationHash == null || locationHash.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location hash is missing or invalid')),
      );
      return;
    }

    final url = Uri.parse('http://3.111.72.98:8000/file'); // Replace with your server URL

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'LocationData': locationHash, // Send the location hash in the headers
          'HashKey': locationHash,      // Send the hash key
        },
      );

      if (response.statusCode == 200) {
        final fileUrl = response.body; // Get the file URL from the server response
        print("File URL: $fileUrl");

        // Start downloading the file using flutter_downloader
        final dir = await getApplicationDocumentsDirectory();
        final savePath = '${dir.path}/saved.csv';

        final taskId = await FlutterDownloader.enqueue(
          url: fileUrl,
          savedDir: dir.path,
          fileName: "saved.csv",
          showNotification: true,
          openFileFromNotification: true,
        );

        print("Download started with taskId: $taskId");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File downloaded successfully!')),
        );
      } else {
        print('Error: ${response.statusCode}, Body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download the file.')),
        );
      }
    } catch (e) {
      print('Error occurred while downloading: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred while downloading the file.')),
      );
    }
  }
}

