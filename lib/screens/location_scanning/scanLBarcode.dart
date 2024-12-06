

// import 'package:buildittt/providers/scanProvider.dart';
// import 'package:buildittt/screens/location_scanning/scanItems.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class ScanLocationPage extends StatelessWidget {
//   const ScanLocationPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Scan Location")),
//       body: Consumer<scanLocationBarcode>(
//         builder: (context, scanProvider, child) {
//           return Center(
//             child: scanProvider.locationHash == null
//                 ? ElevatedButton(
//                     onPressed: () async {
//                       await scanProvider.scanBarcode();
//                     },
//                     child: const Text("Scan Location Barcode"),
//                   )
//                 : Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("Location Hash: ${scanProvider.locationHash}"),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           ElevatedButton(
//                             onPressed: () async {
//                               await scanProvider.scanBarcode();
//                             },
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.red),
//                             child: const Text("Rescan"),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         const ItemScanningPage()),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green),
//                             child: const Text("Proceed to Item Scanning"),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:buildittt/screens/location_scanning/scanItems.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buildittt/providers/scanProvider.dart';


class ScanLocationnPage extends StatelessWidget {
  const ScanLocationnPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Location")),
      body: Consumer<scanLocationBarcode>(
        builder: (context, scanProvider, child) {
          return Center(
            child: scanProvider.locationHash == null
                ? ElevatedButton(
                    onPressed: () async {
                      await scanProvider.scanBarcode(); // Scan location barcode
                    },
                    child: const Text("Scan Location Barcode"),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Location Hash: ${scanProvider.locationHash}"),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ItemScanningPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: const Text("Proceed to Item Scanning"),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
