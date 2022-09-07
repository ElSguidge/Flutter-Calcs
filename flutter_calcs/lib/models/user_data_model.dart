class UserData {
  final String? id;
  final String? email;
  final String? displayName;
  List<dynamic> favorites;

  UserData({this.id, this.email, this.displayName, required this.favorites});

  Map<String, dynamic> toMap() =>
      {'displayName': displayName, 'email': email, 'favorites': favorites};
}

//   UserData.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
//       : id = doc.id,
//         email = doc.data()!['email'],
//         displayName = doc.data()!['displayName'],
//         favorites = Favorites.fromMap(doc.data()!['favorites']);
// }
