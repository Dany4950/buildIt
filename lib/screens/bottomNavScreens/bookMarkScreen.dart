import 'package:buildittt/providers/loadingNoteProvider.dart';
import 'package:buildittt/screens/scanBarcodeLN.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class VerifyLoadingNoteScreen extends StatelessWidget {
  final TextEditingController _loadingNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loadingNoteProvider = Provider.of<LoadingNoteProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Verify Loading Note")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
               style: TextStyle(color: Colors.white),
              controller: _loadingNoteController,
              decoration: InputDecoration(
                labelText: "Enter Loading Note",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await loadingNoteProvider.verifyLoadingNote(
                  _loadingNoteController.text,
                );
                if (loadingNoteProvider.isLoadingNoteVerified) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Loading Note Verified!")),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(loadingNoteProvider.errorMessage)),
                  );
                }
              },
              child: Text("Verify Loading Note"),
            ),
            SizedBox(height: 16),
            if (loadingNoteProvider.isLoadingNoteVerified)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ScanBarcodePage(
                        loadingNote: loadingNoteProvider.currentLoadingNote!,
                      ),
                    ),
                  );
                },
                child: Text("Scan Barcode"),
              ),
          ],
        ),
      ),
    );
  }
}
