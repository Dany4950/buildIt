// import 'package:buildittt/providers/scanProvider.dart';
// import 'package:buildittt/screens/location_scanning/displayItems.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ItemScanningPage extends StatelessWidget {
//   const ItemScanningPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Item Scanning")),
//       body: Consumer<scanLocationBarcode>(
//         builder: (context, scanProvider, child) {
//           return Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: scanProvider.itemBarcodes.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text("Item: ${scanProvider.itemBarcodes[index].barcode}"),
//                     );
//                   },
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   await scanProvider.scanItemBarcode();
//                 },
//                 child: const Text("Scan Next Item"),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   await scanProvider.sendItemsToServer();
//                    Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DisplayScannedDataPage(
//           locationHash: scanProvider.locationHash!,
//           items: scanProvider.itemBarcodes,
//         ),
//       ),
//     );
//                   scanProvider.clearItemBarcodes();
//                   // Navigator.pop(context); // Go back to the previous page

//                 },
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                 child: const Text("End Scanning"),
//               ),

//   //   ElevatedButton(
//   // onPressed: () async {
//   //   await scanProvider.sendItemsToServer(); // Send items to the server

//     // Show the dialog for options after scanning is complete
//     showDialog(
//       context: context,
//       barrierDismissible: false, // Prevent closing the dialog by tapping outside
//       builder: (context) => AlertDialog(
//         title: const Text('Scanning Complete'),
//         content: const Text('Would you like to download the scanned file or return to the home screen?'),
//         actions: [
//           // Option to download the file
//           TextButton(
//             onPressed: () {
//               // Trigger the download logic
//               scanProvider.downloadFile(scanProvider.locationHash!, context);

//               // Close the dialog
//               Navigator.pop(context);
//             },
//             child: const Text('Download File'),
//           ),

//           // Option to return to home screen
//           TextButton(
//             onPressed: () {
//               // Close the dialog and go back to the home screen
//               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> homec )) // Pops the current screen to return to home
//             },
//             child: const Text('Go to Home'),
//           ),

//       ,

//     // Clear the item barcodes after the scan
//     scanProvider.clearItemBarcodes();
//   },
//   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//   child: const Text("End Scanning"),
// )

//     ]
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:buildittt/providers/scanProvider.dart';
// import 'package:buildittt/screens/homePage/homeScreen.dart';
// import 'package:buildittt/screens/location_scanning/displayItems.dart';
// import 'package:buildittt/widgets/bottomNavBar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ItemScanningPage extends StatelessWidget {
//   const ItemScanningPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Item Scanning")),
//       body: Consumer<scanLocationBarcode>(
//         builder: (context, scanProvider, child) {
//           return Column(
//             children: [
//               // ListView to display scanned items
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: scanProvider.itemBarcodes.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(
//                           "Item: ${scanProvider.itemBarcodes[index].barcode}"),
//                     );
//                   },
//                 ),
//               ),

//               // Button to scan the next item
//               ElevatedButton(
//                 onPressed: () async {
//                   await scanProvider.scanItemBarcode();


//                 },
//                 child: const Text("Scan Next Item"),
//               ),

//               // // End Scanning button
//               // ElevatedButton(
                
//               //   onPressed: () async {
//               //     await scanProvider
//               //         .sendItemsToServer(); // Send scanned data to server
//               //     showDialog(
//               //       context: context,
//               //       barrierDismissible:
//               //           false, // Prevent dismissal by tapping outside
//               //       builder: (context) {
//               //         return AlertDialog(
//               //           title: const Text('Scanning Complete'),
//               //           content: const Text(
//               //             'Would you like to download the scanned file or return to the home screen?',
//               //           ),
//               //           actions: [
//               //             // Download button
//               //             TextButton(
//               //               onPressed: () {
//               //                 // Trigger download logic
//               //                 scanProvider.downloadFile(
//               //                     scanProvider.locationHash!, context);
//               //                 Navigator.pop(context); // Close dialog
//               //               },
//               //               child: const Text('Download File'),
//               //             ),
//               //             // Return to home screen button
//               //             TextButton(
//               //               onPressed: () {
//               //                 Navigator.pushReplacement(
//               //                     context,
//               //                     MaterialPageRoute(
//               //                         builder: (context) => MainNavigationScreenn()));
//               //               },
//               //               child: const Text('Go to Home'),
//               //             ),
//               //           ],
//               //         );
//               //       },
//               //     );

//               //     // Navigate to display scanned data page
//               //     // Navigator.push(
//               //     //   context,
//               //     //   MaterialPageRoute(
//               //     //     builder: (context) => DisplayScannedDataPage(
//               //     //       locationHash: scanProvider.locationHash!,
//               //     //       items: scanProvider.itemBarcodes,
//               //     //     ),
//               //     //   ),
//               //     // );

//               //     // Clear scanned barcodes

//               //   },
//               //   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//               //   child: const Text("End Scanning"),
//               // ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:buildittt/screens/location_scanning/displayItems.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buildittt/providers/scanProvider.dart';

class ItemScanningPage extends StatelessWidget {
  const ItemScanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Item Scanning")),
      body: Consumer<scanLocationBarcode>(
        builder: (context, scanProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the location hash
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Text(
              //     "Location Hash: ${scanProvider.locationHash ?? 'Not Set'}",
              //     style: const TextStyle(fontSize: 18),
              //   ),
              // ),

              // ListView to display scanned items
              Expanded(
                child: ListView.builder(
                  itemCount: scanProvider.itemBarcodes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        style: TextStyle(color: Colors.black),
                        "Item: ${scanProvider.itemBarcodes[index].barcode}",
                      ),
                    );
                  },
                ),
              ),

              // Input for quantity
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: scanProvider.quantityContoller,
                  decoration: const InputDecoration(
                    labelText: "Enter Quantity",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              // Button to scan the next item
              ElevatedButton(
                onPressed: () async {
                  await scanProvider.scanItemBarcode(); // Scan an item
                },
                child: const Text("Scan Item"),
              ),

              // Button to complete scanning and submit all data
              ElevatedButton(
                onPressed: () async {
                  // Send data to the server
                  await scanProvider.sendItemsToServer();

                  // Navigate to the next page displaying scanned data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayScannedDataPage(
                        locationHash: scanProvider.locationHash ?? '',

                      ),
                    ),
                  );

                  // Clear scanned items after submission
                  scanProvider.clearItemBarcodes();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("End Scanning"),
              ),
            ],
          );
        },
      ),
    );
  }
}
