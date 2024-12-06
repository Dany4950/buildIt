
import 'package:buildittt/providers/scanProvider.dart';
import 'package:buildittt/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayScannedDataPage extends StatelessWidget {
  final String locationHash; // Location hash to display

  const DisplayScannedDataPage({
    super.key,
    required this.locationHash,
  });

  @override
  Widget build(BuildContext context) {
    // Accessing the provider
    final scannedDataProvider = Provider.of<scanLocationBarcode>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainNavigationScreenn()),
            );
          },
          icon: const Icon(Icons.home),
        ),
        title: const Text("Scanned Data "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("for Data Query location number in the home page  ")
            // Display location barcode
            // Text(
            //   "Location Barcode: ${scannedDataProvider.Locationbarcodes.isNotEmpty ? scannedDataProvider.Locationbarcodes.first.barcode : 'No location barcode scanned'}",
            //   style: const TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 20),

            // // Display scanned items under the location
            // const Text(
            //   "Scanned Items:",
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 10),

            // // List of items
            // Expanded(
            //   child: scannedDataProvider.itemBarcodes.isNotEmpty
            //       ? ListView.builder(
            //           itemCount: scannedDataProvider.itemBarcodes.length,
            //           itemBuilder: (context, index) {
            //             final item = scannedDataProvider.itemBarcodes[index];
            //             return Card(
            //               margin: const EdgeInsets.symmetric(vertical: 5),
            //               child: ListTile(
            //                 leading: const Icon(Icons.qr_code),
            //                 title: Text(
            //                   "Item ${index + 1}",
            //                   style: const TextStyle(
            //                     color: Colors.deepOrange,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //                 subtitle: Text(
            //                   "Product Barcode: ${item.barcode}",
            //                   style: const TextStyle(
            //                     color: Colors.black,
            //                     fontWeight: FontWeight.normal,
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //         )
            //       : const Center(
            //           child: Text(
            //             "No items scanned yet!",
            //             style: TextStyle(fontSize: 16, color: Colors.grey),
            //           ),
            //         ),
            // ),

            // // Button to trigger further actions
            // ElevatedButton(
            //   onPressed: () {
            //     // Add functionality for the button here
            //     print("Get File Button Pressed!");
            //   },
            //   child: const Text("Get File"),
            // ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:convert';

// import 'package:buildittt/providers/scanProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class DisplayScannedDataPage extends StatelessWidget {
//   final String locationHash;

//   const DisplayScannedDataPage({
//     super.key,
//     required this.locationHash,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final scannedDataProvider = Provider.of<scanLocationBarcode>(context);

//     // Example response body (replace this with your actual response parsing)
//     final  responseBody = scannedDataProvider.sendItemsToServer().toString();
//     // Parse the JSON response
//     final responseMap = jsonDecode(responseBody);
//     final itemData = responseMap['item'];

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: const Text("Scanned Data Table"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Location Barcode
//             Text(
//               "Location Barcode: ${itemData['locationBarcodeData']}",
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Table Header
//             const Text(
//               "Scanned Item Details:",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 10),

//             // Table to display the scanned item data
//             DataTable(
//               columns: const [
//                 DataColumn(
//                   label: Text(
//                     'Property',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 DataColumn(
//                   label: Text(
//                     'Value',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//               rows: [
//                 DataRow(cells: [
//                   const DataCell(Text('Item Barcode')),
//                   DataCell(Text(itemData['itemBarcodeData'])),
//                 ]),
//                 DataRow(cells: [
//                   const DataCell(Text('Location Barcode')),
//                   DataCell(Text(itemData['locationBarcodeData'])),
//                 ]),
//                 DataRow(cells: [
//                   const DataCell(Text('Quantity')),
//                   DataCell(Text(itemData['quantity'].toString())),
//                 ]),
//                 DataRow(cells: [
//                   const DataCell(Text('Sequence')),
//                   DataCell(Text(itemData['sequence'].toString())),
//                 ]),
//               ],
//             ),
//             const SizedBox(height: 20),

//             // Confirmation message
//             Text(
//               responseMap['message'],
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class DisplayScannedDataPage extends StatefulWidget {
//   final String locationHash;

//   const DisplayScannedDataPage({
//     super.key,
//     required this.locationHash,
//   });

//   @override
//   State<DisplayScannedDataPage> createState() => _DisplayScannedDataPageState();
// }

// class _DisplayScannedDataPageState extends State<DisplayScannedDataPage> {
//   Map<String, dynamic>? responseData; // To store the server response
//   bool isLoading = true; // Loading indicator
//   bool hasError = false; // Error flag

//   @override
//   void initState() {
//     super.initState();
//     sendItemToServer(); // Call the server on initialization
//   }

//   Future<void> sendItemToServer() async {
//     const apiUrl = 'http://3.111.72.98:8000/itemsData'; // Replace with your API URL
//     final itemData = {
//       "itemBarcodeData": "(Location-4)",
//       "locationBarcodeData": widget.locationHash,
//       "quantity": 2,
//       "sequence": 7,
//     };

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({"item": itemData}),
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           responseData = jsonDecode(response.body); // Parse the server response
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           hasError = true;
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         hasError = true;
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Scanned Data Table"),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back),
//         ),
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : hasError
//               ? const Center(
//                   child: Text(
//                     "Failed to fetch data from the server.",
//                     style: TextStyle(color: Colors.red, fontSize: 16),
//                   ),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Display the Location Barcode
//                       Text(
//                         "Location Barcode: ${responseData!['item']['locationBarcodeData']}",
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 20),

//                       // Table Header
//                       const Text(
//                         "Scanned Item Details:",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 10),

//                       // Display DataTable
//                       DataTable(
//                         columns: const [
//                           DataColumn(
//                             label: Text(
//                               'Property',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           DataColumn(
//                             label: Text(
//                               'Value',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                         rows: [
//                           DataRow(cells: [
//                             const DataCell(Text('Item Barcode')),
//                             DataCell(Text(
//                                 responseData!['item']['itemBarcodeData'])),
//                           ]),
//                           DataRow(cells: [
//                             const DataCell(Text('Location Barcode')),
//                             DataCell(Text(responseData!['item']
//                                 ['locationBarcodeData'])),
//                           ]),
//                           DataRow(cells: [
//                             const DataCell(Text('Quantity')),
//                             DataCell(Text(responseData!['item']['quantity']
//                                 .toString())),
//                           ]),
//                           DataRow(cells: [
//                             const DataCell(Text('Sequence')),
//                             DataCell(Text(responseData!['item']['sequence']
//                                 .toString())),
//                           ]),
//                         ],
//                       ),
//                       const SizedBox(height: 20),

//                       // Confirmation Message
//                       Text(
//                         responseData!['message'],
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//     );
//   }
// }
