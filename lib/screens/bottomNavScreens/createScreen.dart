import 'package:buildittt/providers/scanProvider.dart';
import 'package:buildittt/screens/homePage/homeScreen.dart';
import 'package:buildittt/screens/location_scanning/resultLocationBarcode.dart';
import 'package:buildittt/screens/location_scanning/scanLBarcode.dart';
import 'package:buildittt/screens/location_scanning/scanLocationBarcode.dart';
import 'package:buildittt/screens/scanBarcodeLN.dart';
import 'package:buildittt/utils/appTheme.dart';
import 'package:buildittt/widgets/elevatedButton.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Createscreen extends StatelessWidget {
  const Createscreen({super.key});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Apptheme.appBackgroundColor,
        title: Text(
          "Create Order",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Order name"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Search an Order",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(" Create Order"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Apptheme.appBackgroundColor.withOpacity(0.5)),
                  child: Center(
                    child: Consumer<scanLocationBarcode>(
                        builder: (context, scanProvider, child) {
                      return Container(
                          width: screenWidth * 0.4,
                          child: ElevatedButton(
                            onPressed: () async {
                              // await scanProvider.();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScanLocationPage()));
                            },
                            child: Icon(Icons.upload),
                          ));
                    }),
                  ),
                ),
              ),

              //item container
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: Text("Image"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Apptheme.appBackgroundColor.withOpacity(0.5)),
                  child: Center(
                    child: Consumer<scanLocationBarcode>(
                        builder: (context, scanProvider, child) {
                      return Container(
                          width: screenWidth * 0.47,
                          child: ElevatedButton(
                            onPressed: () async {
                              await scanProvider.scanBarcode();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ScanLocationItemsResult()),
                              );
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.upload),
                                Text("Choose a file "),
                              ],
                            ),
                          ));
                    }),
                  ),
                ),
              ),

              // quantity

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text("Quantity Order "),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                   controller: Provider.of<scanLocationBarcode>(context).quantityContoller, // Attach the controller here
    keyboardType: TextInputType.number, 
                  decoration: InputDecoration(
                    labelText: "Quantity of Your  Order",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Center(
              //       child: ElevatedButton(
              //     onPressed: () {
              //       Navigator.pushReplacement(context,
              //           MaterialPageRoute(builder: (context) => HOMESCREEN()));
              //     },
              //     child: Container(
              //       width: 250,
              //       height: 50,
              //       color: Apptheme.buttonColorYellow,
              //       alignment: Alignment.center,
              //       child: Text(
              //         "Place Order ",
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: Colors.black,
              //             fontSize: 20),
              //       ),
              //     ),
              //   )),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
