import 'package:buildittt/providers/authProvider/loginScreenProvider.dart';
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
        title: Text('Profile'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<LoginScreenProvider>(
            builder: (context, myType, child) {
              final userName = myType.emailController.text.trim();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${userName ?? 'User'}!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(height: 16),
                  // Text('Email: ${userData['email'] ?? 'Not provided'}',
                  //     style: TextStyle(fontSize: 18)),
                  // Add more details as needed
                ],
              );
            },
          )),
    );
  }
}
