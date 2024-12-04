// import 'dart:convert';
// import 'package:buildittt/screens/homePage/homeScreen.dart';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class LoginScreenProvider extends ChangeNotifier {
//   // Controllers for text fields
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool _isLoading = false; // Indicates if a request is in progress
//   String? _errorMessage; // Stores error messages

//   // Getters for state
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;

//   BuildContext get context => context;

//   Future<bool> onLoginTap() async {
//     // Validate input
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       _errorMessage = "Please fill in all fields.";
//       notifyListeners();
//       return false;
//     }

//     _isLoading = true; // Start loading
//     _errorMessage = null; // Reset error message
//     notifyListeners();

//     try {
//       final response = await http.post(
//         Uri.parse('http://10.0.2.2:5000/login'), // Flask API endpoint
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'email': email, 'password': password}),
//       );

//       if (response.statusCode == 200) {
//         print("Login Successfull");
//         final userData = jsonDecode(response.body);
//         print("User data: $userData");

//         return true;
//       } else {
//         // Handle API error response
//         final errorData = jsonDecode(response.body);
//         _errorMessage = errorData['error'] ?? "Invalid credentials.";
//         return false;
//       }
//     } catch (e) {
//       _errorMessage = "Failed to connect to the server. Please try again.";
//       print("Error: $e");
//       return false;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreenProvider extends ChangeNotifier {
  // Controllers for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController =
      TextEditingController(); // For signup

  bool _isLoading = false; // Indicates if a request is in progress
  String? _errorMessage; // Stores error messages

  // Getters for state
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  BuildContext get context => context;

  // Login function
  Future<bool> onLoginTap() async {
    // Validate input
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _errorMessage = "Please fill in all fields.";
      notifyListeners();
      return false;
    }

    _isLoading = true; // Start loading
    _errorMessage = null; // Reset error message
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('http://3.111.72.98:8000/login'), // Flask API endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        print("Login Successful");
        final userData = jsonDecode(response.body);
        print("User data: $userData");

        // Handle login success (e.g., navigate to home screen)
        // Navigator.pushReplacementNamed(context, '/home');
        return true;
      } else {
        // Handle API error response
        final errorData = jsonDecode(response.body);
        _errorMessage = errorData['error'] ?? "Invalid credentials.";
        return false;
      }
    } catch (e) {
      _errorMessage = "Failed to connect to the server. Please try again.";
      print("Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Signup function
  Future<bool> onSignupTap() async {
    // Validate input
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _errorMessage = "Please fill in all fields.";
      notifyListeners();
      return false;
    }

    _isLoading = true; // Start loading
    _errorMessage = null; // Reset error message
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('http://3.111.72.98:8000/signup'), // Flask API endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        print("Signup Successful");
        final userData = jsonDecode(response.body);
        print("User data: $userData");

        // Handle signup success (e.g., navigate to login screen)
        // Navigator.pushReplacementNamed(context, '/login');
        return true;
      } else {
        // Handle API error response
        final errorData = jsonDecode(response.body);
        _errorMessage = errorData['error'] ?? "Signup failed.";
        return false;
      }
    } catch (e) {
      _errorMessage = "Failed to connect to the server. Please try again.";
      print("Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
