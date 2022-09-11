import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_calcs/models/favorites.dart';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Map<String, dynamic> bookmarks = {};

  Future<void> deleteUser(String documentId) async {
    await _db.collection('user-favorites').doc(documentId).delete();
  }

  Future<void> checkUserData(String email) async {
    final userChecks = await _db.collection('user-favorites').doc(email).get();
    if (userChecks.exists) {
      await getItemsLogin(email);
    } else {
      await getItems(email);
    }
  }

  Future<void> getItems(String email) async {
    await _db
        .collection("calculators")
        .get()
        .then((QuerySnapshot querySnapshot) {
      int index = 0;

      for (var element in querySnapshot.docs) {
        // print(element['id']);
        int id = element['id'];
        final name = element["name"].toString();
        final subtitle = element['subtitle'].toString();
        final route = element['route'].toString();
        bookmarks[element['name'].toString()] = {
          'id': id,
          "name": name,
          "isFavorite": false,
          'subtitle': subtitle,
          'route': route
        };
      }
    });
    await _db
        .collection('user-favorites')
        .doc(email)
        .set({"email": email, "bookmarks": bookmarks});
  }

  Future<void> getItemsLogin(String email) async {
    await _db
        .collection('user-favorites')
        .where("email", isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        bookmarks = Map.from(element["bookmarks"]);
      }
    });
  }

  Future<void> update(String email, String item) async {
    Map<String, dynamic> bookmark = {};

    await _db
        .collection("user-favorites")
        .where("email", isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        bookmark = Map.from(element["bookmarks"]);
        // print("db_bookmark: $bookmark");
      }
    });
    for (var element in bookmark.values) {
      final name = element['name'].toString();
      if (name == item) {
        // print("upadted");
        element['isFavorite'] = element['isFavorite']! ? false : true;
      }
    }
    await _db
        .collection("user-favorites")
        .where("email", isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnaphot) {
      for (var element in querySnaphot.docs) {
        element.reference.update({"bookmarks": bookmark});
      }
    });

    await getItemsLogin(email);
  }
}
