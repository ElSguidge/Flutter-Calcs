class BookmarkTest {
  final String? userId;
  final String? name;
  final String? subtitle;

  BookmarkTest({this.userId, this.name, this.subtitle});

  Map<String, dynamic> toMap() {
    return {'calcId': userId, 'name': name, 'subtitle': subtitle};
  }

  BookmarkTest.fromFirestore(Map<String, dynamic> firestore)
      : userId = firestore['userId'],
        name = firestore['name'],
        subtitle = firestore['subtitle'];
}
