import 'package:buildittt/utils/appTheme.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Apptheme.appBackgroundColor,
      toolbarHeight: 70, // Adjust the height of the AppBar
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14, // Adjust font size for "Welcome Back"
            ),
          ),
          Text(
            "BarcodeScanner",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18, // Adjust font size for "BarcodeScanner"
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/appLogo.png',
            height: 70,
          ),
        ),
      ],
    );
  }

  // Implement the PreferredSizeWidget interface
  @override
  Size get preferredSize => const Size.fromHeight(50); // Match toolbarHeight
}
