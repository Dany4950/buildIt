import 'package:buildittt/providers/scanProvider.dart';
import 'package:buildittt/screens/location_scanning/resultLocationBarcode.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Createscreen extends StatelessWidget {
  const Createscreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Builder(
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Consumer<scanLocationBarcode>(
                builder: (context, scanProvider, child) {
              return Container(
                width: screenWidth * 0.4,
                child: ElevatedButton(
                  onPressed: () async {
                    await scanProvider.scanBarcode();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScanLocationItemsResult()),
                    );
                  },
                  child: Center(child: Text('Scan Barcode')),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
