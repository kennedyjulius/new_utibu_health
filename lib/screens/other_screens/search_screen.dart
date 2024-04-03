// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<Map<String, dynamic>> _searchResults = [];

//   void _search(String query) {
//     // Replace 'your_collection' with the name of your Firebase collection
//     FirebaseFirestore.instance
//         .collection('your_collection')
//         .where('field_to_search', isEqualTo: query)
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       setState(() {
//         _searchResults = querySnapshot.docs.map((doc) => doc.data()).toList();
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: _searchController,
//           decoration: InputDecoration(
//             hintText: 'Search...',
//             suffixIcon: IconButton(
//               onPressed: () {
//                 _search(_searchController.text);
//               },
//               icon: Icon(Icons.search),
//             ),
//           ),
//         ),
//       ),
//       body: _searchResults.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset('assets/not_found_image.png'),
//                   Text('Results not found'),
//                 ],
//               ),
//             )
//           : ListView.builder(
//               itemCount: _searchResults.length,
//               itemBuilder: (context, index) {
//                 // Replace 'title' and 'description' with the fields you want to display
//                 return ListTile(
//                   title: Text(_searchResults[index]['title']),
//                   subtitle: Text(_searchResults[index]['description']),
//                 );
//               },
//             ),
//     );
//   }
// }
