
// import 'package:buildittt/providers/bottomNavBarProvider.dart';
// import 'package:buildittt/screens/bottomNavScreens/bookMarkScreen.dart';
// import 'package:buildittt/screens/bottomNavScreens/createScreen.dart';
// import 'package:buildittt/screens/bottomNavScreens/profileScreen.dart';
// import 'package:buildittt/screens/homeScreen.dart';
// import 'package:buildittt/utils/appTheme.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// class MainNavigationScreen extends StatelessWidget {
//   final List<NavigationDestination> destinations = [
//     NavigationDestination(
//       icon: Icon(Icons.home_outlined),
//       selectedIcon: Icon(Icons.home, color: Colors.red),
//       label: 'Home',
//     ),
//     NavigationDestination(
//       icon: Icon(Icons.bookmark_border),
//       selectedIcon: Icon(Icons.bookmark, color: Colors.blue),
//       label: 'Bookmarks',
//     ),
//     NavigationDestination(
//       icon: Icon(Icons.add_circle_outline),
//       selectedIcon: Icon(Icons.add_circle, color: Colors.blue),
//       label: 'Create',
//     ),
//     NavigationDestination(
//       icon: Icon(Icons.person_outline),
//       selectedIcon: Icon(Icons.person, color: Colors.blue),
//       label: 'Profile',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BottomNavProvider>(
//       builder: (context, provider, child) {
//         return Scaffold(
//           body: IndexedStack(
//             index: provider.currentIndex,
//             children: [
//               HOMESCREEN(),
//               Bookmarkscreen(),
//               Createscreen(),
//               Profilescreen(),
//             ],
//           ),
//           bottomNavigationBar: NavigationBar(
//             shadowColor: Colors.deepOrange,
//             backgroundColor: Apptheme.appBackgroundColor,
//             surfaceTintColor: Apptheme.appBackgroundColor,
//             selectedIndex: provider.currentIndex,
//             onDestinationSelected: (index) {
//               provider.setIndex(index);
//             },
//             destinations: destinations,
//             animationDuration: Duration(milliseconds: 300),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:buildittt/screens/bottomNavScreens/bookMarkScreen.dart';
import 'package:buildittt/screens/bottomNavScreens/createScreen.dart';
import 'package:buildittt/screens/bottomNavScreens/profileScreen.dart';
import 'package:buildittt/screens/homeScreen.dart';
import 'package:buildittt/utils/appTheme.dart';
import 'package:buildittt/widgets/homeAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bottomNavBarProvider.dart';

class MainNavigationScreenn extends StatelessWidget {
  final List<NavigationDestination> destinations = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home, color: Colors.blue),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.bookmark_border),
      selectedIcon: Icon(Icons.bookmark, color: Colors.blue),
      label: 'Bookmarks',
    ),
    NavigationDestination(
      icon: Icon(Icons.add_circle_outline),
      selectedIcon: Icon(Icons.add_circle, color: Colors.blue),
      label: 'Create',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person, color: Colors.blue),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, provider, child) {
        return NavigationScaffold(
          body: IndexedStack(
            index: provider.currentIndex,
            children: const [
              HOMESCREEN(),
              Bookmarkscreen(),
              Createscreen(),
              Profilescreen(),
            ],
          ),
          currentIndex: provider.currentIndex,
          onDestinationSelected: (index) {
            provider.setIndex(index);
          },
          destinations: destinations,
        );
      },
    );
  }
}

class NavigationScaffold extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final void Function(int) onDestinationSelected;
  final List<NavigationDestination> destinations;

  const NavigationScaffold({
    Key? key,
    required this.body,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.destinations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: body,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Apptheme.appBackgroundColor,
        selectedIndex: currentIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: destinations,
        animationDuration: Duration(milliseconds: 300),
      ),
    );
  }
}