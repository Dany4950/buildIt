import 'package:buildittt/providers/scanProvider.dart';
import 'package:flutter/material.dart';


class DisplayScannedDataPage extends StatelessWidget {
  final String locationHash; // Location hash to display


  const DisplayScannedDataPage({
    super.key,
    required this.locationHash,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scanned Data")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display location barcode
            Text(
              "Location: $locationHash",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Display scanned items under the location
            const Text(
              "Scanned Items:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // List of items
            Expanded(
              child: ListView.builder(
                itemCount: scanLocationBarcode().itemBarcodes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: const Icon(Icons.qr_code),
                      title: Text(
                        "Item ${index + 1}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(""),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
