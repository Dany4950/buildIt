import 'package:buildittt/providers/searchBarHome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Search API Example")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Enter a number",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                searchProvider.updateQuery(value);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                searchProvider.sendQueryToServer();
              },
              child: searchProvider.isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : const Text("Submit"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildResponseWidget(searchProvider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponseWidget(SearchProvider searchProvider) {
    if (searchProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (searchProvider.errorMessage != null) {
      return Center(child: Text(searchProvider.errorMessage!));
    }

    if (searchProvider.responseData == null) {
      return const Center(child: Text("No data to display."));
    }

    return ListView.builder(
      itemCount: searchProvider.responseData!.length,
      itemBuilder: (context, index) {
        final key = searchProvider.responseData!.keys.elementAt(index);
        final value = searchProvider.responseData![key];
        return ListTile(
          title: Text(key),
          subtitle: Text(value.toString()),
        );
      },
    );
  }
}
