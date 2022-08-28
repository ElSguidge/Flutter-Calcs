// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_calcs/models/bookmark_test.dart';

// class FirestoreService {
//   FirebaseFirestore _db = FirebaseFirestore.instance;

//   Future<void> saveFavorite(BookmarkTest calc){}

//   Stream<List<BookmarkTest>> getProducts() {
//     return _db.collection('users').snapshots().map((snapshot) => snapshot
//         .docs
//         .map((document) => BookmarkTest.fromFirestore(document.data()))
//         .toList());
//   }
// }
