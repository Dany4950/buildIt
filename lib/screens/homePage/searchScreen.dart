// import 'package:buildittt/providers/searchBarHome.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SearchScreen extends StatelessWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final searchProvider = Provider.of<SearchProvider>(context);

//     return Scaffold(
//       // appBar: AppBar(title: const Text("Search API Example")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(20), // Curved border
//     ),
//     suffixIcon: const Icon(Icons.search),

//                 labelText: "Search an Order",

//               ),
//               keyboardType: TextInputType.emailAddress,
//               onChanged: (value) {
//                 searchProvider.updateQuery(value);
//               },
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 searchProvider.sendQueryToServer();
//               },
//               child: searchProvider.isLoading
//                   ? const CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     )
//                   : const Text("Submit"),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: _buildResponseWidget(searchProvider),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildResponseWidget(SearchProvider searchProvider) {
//     if (searchProvider.isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (searchProvider.errorMessage != null) {
//       return Center(child: Text(searchProvider.errorMessage!));
//     }

//     if (searchProvider.responseData == null) {
//       return const Center(child: Text("No data to display."));
//     }

//     return ListView.builder(
//       itemCount: searchProvider.responseData!.length,
//       itemBuilder: (context, index) {
//         final key = searchProvider.responseData!.keys.elementAt(index);
//         final value = searchProvider.responseData![key];
//         return ListTile(
//           title: Text(key),
//           subtitle: Text(value.toString()),
//         );
//       },
//     );
//   }
// }

import 'package:buildittt/providers/searchBarHomeProvider.dart';
import 'package:buildittt/utils/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            _buildSearchField(searchProvider),
            const SizedBox(height: 16),
            _buildSubmitButton(searchProvider),
            const SizedBox(height: 16),
            _buildResponseSection(searchProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(SearchProvider searchProvider) {
    return TextField(
      decoration: InputDecoration(
        labelText: "Search an Order",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: const Icon(Icons.search),
      ),
      onChanged: (value) => searchProvider.updateQuery(value),
    );
  }

  Widget _buildSubmitButton(SearchProvider searchProvider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => searchProvider.sendQueryToServer(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Apptheme.buttonColorYellow,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: searchProvider.isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Text(
                "Submit",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Widget _buildResponseSection(SearchProvider searchProvider) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Apptheme.appBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: _buildResponseWidget(searchProvider),
      ),
    );
  }

  Widget _buildResponseWidget(SearchProvider searchProvider) {
    if (searchProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (searchProvider.errorMessage != null) {
      // Handle specific error messages
      if (searchProvider.errorMessage ==
          "No items found for the provided locationBarcodeData.") {
        return Center(
          child: Text(
            "No items found for the provided location. Please check your input and try again.",
            style: const TextStyle(fontSize: 16, color: Colors.orange),
            textAlign: TextAlign.center,
          ),
        );
      }

      // Generic error message
      return Center(
        child: Text(
          "Error: ${searchProvider.errorMessage!}",
          style: const TextStyle(fontSize: 16, color: Colors.red),
        ),
      );
    }

    if (searchProvider.responseData == null ||
        searchProvider.responseData!['items'] == null ||
        searchProvider.responseData!['items'].isEmpty) {
      return const Center(
        child: Text(
          "No data available.",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    // Extract and display data
    final List<Map<String, dynamic>> items =
        List<Map<String, dynamic>>.from(searchProvider.responseData!['items']);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
      dataTextStyle: TextStyle(color: Colors.white),
        columns: const [
          DataColumn(label: Text("Item Barcode")),
          DataColumn(label: Text("Item ID")),
          DataColumn(label: Text("Location Barcode")),
          DataColumn(label: Text("Quantity")),
          DataColumn(label: Text("Sequence")),
        ],
        rows: items.map((item) {
          return DataRow(cells: [
            DataCell(Text(item['itemBarcodeData'] ?? 'N/A')),
            DataCell(Text(item['itemId']?.toString() ?? 'N/A')),
            DataCell(Text(item['locationBarcodeData'] ?? 'N/A')),
            DataCell(Text(item['quantity']?.toString() ?? 'N/A')),
            DataCell(Text(item['sequence']?.toString() ?? 'N/A')),
          ]);
        }).toList(),
      ),
    );
  }
}
