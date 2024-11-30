import 'package:buildittt/screens/location_scanning/scanLBarcode.dart';
import 'package:buildittt/widgets/homeAppBar.dart';
import 'package:flutter/material.dart';

class HOMESCREEN extends StatefulWidget {
  const HOMESCREEN({super.key});

  @override
  State<HOMESCREEN> createState() => _HomescreenState();
}

class _HomescreenState extends State<HOMESCREEN> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: HomeAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Scanlbarcode()));
              },
              icon: const Icon(Icons.scanner))
        ],
      ),

    );
  }
}