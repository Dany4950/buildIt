import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchProvider extends ChangeNotifier {
  String _query = '';
  Map<String, dynamic>? _responseData;
  bool _isLoading = false;
  String? _errorMessage;

  String get query => _query;
  Map<String, dynamic>? get responseData => _responseData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void updateQuery(String value) {
    _query = value;
    notifyListeners();
  }

  Future<void> sendQueryToServer() async {
    if (_query.isEmpty) {
      _errorMessage = "Please enter a valid number.";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final url =
          Uri.parse('http://10.0.2.2:5000/query'); // Use your machine's IP here
      print('Sending request with query: $_query');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'locationBarcodeData': _query}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        _responseData = jsonDecode(response.body);
      } else {
        _errorMessage =
            "Failed to fetch data. Server returned ${response.statusCode}.";
      }
    } catch (e) {
      _errorMessage = "An error occurred: $e";
      print(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}