// import 'package:buildittt/providers/authProvider/loginScreenProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Consumer<LoginScreenProvider>(
//             builder: (context, myType, child) {
//               final userName = myType.emailController.text.trim();
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Welcome, ${userName ?? 'User'}!',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   // SizedBox(height: 16),
//                   // Text('Email: ${userData['email'] ?? 'Not provided'}',
//                   //     style: TextStyle(fontSize: 18)),
//                   // Add more details as needed
//                 ],
//               );
//             },
//           )),
//     );
//   }
// }


import 'package:buildittt/providers/authProvider/loginScreenProvider.dart';
import 'package:buildittt/utils/appTheme.dart';
import 'package:buildittt/widgets/hamBurgerMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Open the drawer using the context of the Builder
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text('Profile'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<LoginScreenProvider>(
          builder: (context, myType, child) {
            final userName = myType.emailController.text.trim();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome message
                Text(
                  'Welcome, ${userName.isEmpty ? 'User' : userName}!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 16),

                // No orders found message
                Text(
                  'No orders found on this profile.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 40),

                // Elevated button to go back to the explore page
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the explore page (adjust the route as necessary)
                      Navigator.pop(context); // or replace with your desired navigation logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Apptheme.appBackgroundColor, // Set button color
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Back to Explore',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
