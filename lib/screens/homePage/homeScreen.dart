import 'package:buildittt/providers/homeToSearch.dart';
import 'package:buildittt/screens/homePage/searchScreen.dart';

import 'package:buildittt/widgets/homeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

      body: SearchScreen(),
      // body: Column(
        
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     SizedBox(height: screenHeight*0.04,),
          
      //     // Builder(
      //     //   builder: (context) {
      //     //     //searchbar to search using locations
      //     //     final Hometosearch homeToSearch =
      //     //         Provider.of<Hometosearch>(context, listen: false);
      //     //     return Row(
      //     //       children: [
      //     //         SizedBox(
      //     //           width: screenWidth * 0.15,
      //     //         ),
      //     //         ElevatedButton(
      //     //             onPressed: () {
      //     //               homeToSearch.onTapONSearch(context);
      //     //             },
      //     //             child: Container(
      //     //               width: screenWidth * 0.56,
      //     //               child: const Center(
      //     //                 child: Text("Search Order "),
      //     //               ),
      //     //             )),
      //     //       ],
      //     //     );
      //     //   },
      //     // ),


          
      //   ],
      // ),
    );
  }
}
