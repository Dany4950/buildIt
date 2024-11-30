

import 'package:buildittt/models/barcodeModel.dart';
import 'package:buildittt/providers/scanProvider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ScanLocationItemsResult extends StatelessWidget {
  const ScanLocationItemsResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Results"),
      ),
      body: Consumer<scanLocationBarcode>(
        builder: (context, scanLocationBarcode, child) {
          // Access the barcodes list
          final List<ScanModel> barcodes = scanLocationBarcode.barcodes;

          if (barcodes.isEmpty) {
            return const Center(
              child: Text("No barcodes found."),
            );
          }

          return ListView.builder(
            itemCount: scanLocationBarcode.barcodes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(scanLocationBarcode.scannedBarcodes[index].barcode), // Wrap the string in Text widget
              );
            },
          );
        },
      ),
    );
  }
}
