import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingNoteProvider extends ChangeNotifier {
  bool isLoadingNoteVerified = false;
  String? currentLoadingNote;
  String errorMessage = "";

  /// Verify the Loading Note
  Future<void> verifyLoadingNote(String loadingNote) async {
    final url = Uri.parse('http://3.111.72.98:8000/verifyLN'); // Update your server URL
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"loadingNote": loadingNote}),
      );

      if (response.statusCode == 200) {
        isLoadingNoteVerified = true;
        currentLoadingNote = loadingNote;
        errorMessage = "";
      } else {
        isLoadingNoteVerified = false;
        currentLoadingNote = null;
        errorMessage = "Loading note not found.";
      }
    } catch (e) {
      errorMessage = "An error occurred: $e";
      isLoadingNoteVerified = false;
    }
    notifyListeners();
  }
}
