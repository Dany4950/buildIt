import 'package:buildittt/screens/location_scanning/scanLBarcode.dart';
import 'package:flutter/material.dart';
import 'package:buildittt/screens/bottomNavScreens/bookMarkScreen.dart';
import 'package:buildittt/screens/bottomNavScreens/createScreen.dart';
import 'package:buildittt/screens/bottomNavScreens/profileScreen.dart';
import 'package:buildittt/screens/homePage/homeScreen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          // Navigation Options
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Open Scanning '),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ScanLocationnPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Open Scanning with Qty'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => VerifyLoadingNoteScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text('load Loading number '),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Createscreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Transaction'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
           ListTile(
            leading: Icon(Icons.person),
            title: Text('Send File '),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ScanLocationnPage()),
              );
            },
          ),
           ListTile(
            leading: Icon(Icons.person),
            title: Text('Scan Location '),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ScanLocationnPage()),

                
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Export Location File '),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ScanLocationnPage()),

                
              );
            },
          ),


          ListTile(
            leading: Icon(Icons.person),
            title: Text('SetUp'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ScanLocationnPage()),

                
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Clear Database'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ScanLocationnPage()),

                
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Check Service'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ScanLocationnPage()),

                
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Exit'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HOMESCREEN()),

                
              );
            },
          ),
        ],
      ),


    );
  }
}
