import 'package:buildittt/providers/scanProvider.dart';
import 'package:buildittt/screens/location_scanning/resultLocationBarcode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Scanlbarcode extends StatefulWidget {
  const Scanlbarcode({super.key});

  @override
  State<Scanlbarcode> createState() => ScanlbarcodeState();
}

class ScanlbarcodeState extends State<Scanlbarcode> {
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child:  Consumer<scanLocationBarcode>(
                  builder: (context, scanProvider, child) {
                return ElevatedButton(
                  onPressed: () async {
                    await scanProvider.scanBarcode();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScanLocationItemsResult()),
                    );
                  },
                  child: Center(child: Text('Scan Barcode')),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
