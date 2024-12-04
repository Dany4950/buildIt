// import 'package:buildittt/utils/appTheme.dart';
// import 'package:flutter/material.dart';

// class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const HomeAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       toolbarHeight: 70, // Adjust the height of the AppBar
//       centerTitle: false,
//       title: Text("Welcome back "),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(
//             'assets/images/appLogo.png',
//             height: 80,
//           ),
//         ),
//       ],
//     );
//   }

//   // Implement the PreferredSizeWidget interface
//   @override
//   Size get preferredSize => const Size.fromHeight(50); // Match toolbarHeight
// }

import 'package:buildittt/utils/appTheme.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          AppBar(
            automaticallyImplyLeading: false, // Remove the back arrow
            backgroundColor: Apptheme.appBackgroundColor,
          
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
              children: [
                Text(
                  "Welcome back",
                  style: TextStyle(
                    color: Colors.white, // Adjust text color for visibility
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4), // Space between the two texts
                Text(
                  "BarCode Scanner",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Slightly lighter color for subtitle
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/appLogo.png',
                  height: 80,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80); // Match toolbarHeight
}
