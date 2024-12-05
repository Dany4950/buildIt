import 'package:buildittt/providers/LoadingNoteBarcodeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ScanBarcodePage extends StatelessWidget {
  final String loadingNote;

  ScanBarcodePage({required this.loadingNote});

  Future<String?> scanBarcode() async {
    // Simulate barcode scanning (use a package like `barcode_scan` in real implementation)
    return Future.value("exampleBarcode123");
  }

  @override
  Widget build(BuildContext context) {
    final barcodeProvider = Provider.of<BarcodeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Scan Barcode")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () async {
                final scannedBarcode = await scanBarcode();
                if (scannedBarcode != null) {
                  await barcodeProvider.verifyBarcode(
                    loadingNote,
                    scannedBarcode,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        barcodeProvider.isBarcodeVerified
                            ? "Barcode Verified: ${barcodeProvider.scannedBarcode}"
                            : barcodeProvider.errorMessage,
                      ),
                    ),
                  );
                }
              },
              child: Text("Scan Barcode"),
            ),
          ],
        ),
      ),
    );
  }
}
