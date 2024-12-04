import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupProvider extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> signup() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validate inputs
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _errorMessage = "All fields are required.";
      notifyListeners();
      return false;
    }

    if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email)) {
      _errorMessage = "Invalid email format.";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      print('Sending request to server...');
      final response = await http.post(
        Uri.parse('http://3.111.72.98:8000/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        // Handle server errors
        final responseData = jsonDecode(response.body);
        _errorMessage = responseData['error'] ?? "Signup failed.";
        return false;
      }
    } catch (e) {
      _errorMessage = "Failed to connect to the server. Please try again.";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
