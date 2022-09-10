import 'dart:convert';

class Favorites {
  final String? email;
  final List<Bookmarks>? bookmarks;

  Favorites({this.email, this.bookmarks});

  Favorites copyWith({
    String? email,
    List<Bookmarks>? bookmarks,
  }) {
    return Favorites(
      email: email ?? this.email,
      bookmarks: bookmarks ?? this.bookmarks,
    );
  }

  Map<String, dynamic> toMap() => {'email': email, 'bookmarks': bookmarks};

  factory Favorites.fromMap(Map<String, dynamic> data) {
    return Favorites(
      email: data['email'],
      bookmarks: List<Bookmarks>.from(
          data['bookmarks']?.data((x) => Bookmarks.fromMap(x))),
    );
  }
  String toJson() => json.encode(toMap());
  factory Favorites.fromJson(String source) =>
      Favorites.fromMap(json.decode(source));

  @override
  String toString() => 'Testt(name: $email, bookmarks: $bookmarks)';
}

class Bookmarks {
  final String? name;
  final String? subtitle;
  final String? route;
  bool? isFavorite;

  Bookmarks({this.name, this.subtitle, this.route, this.isFavorite});

  Bookmarks copyWith(
      {String? name, String? subtitle, String? route, bool? isFavorite}) {
    return Bookmarks(
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      route: route ?? this.route,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'subtitle': subtitle,
      'route': route,
      'isFavorite': isFavorite
    };
  }

  factory Bookmarks.fromMap(Map<String, dynamic> data) {
    return Bookmarks(
        name: data['name'],
        subtitle: data['subtitle'],
        route: data['route'],
        isFavorite: data['isFavorite']);
  }
  String toJson() => json.encode(toMap());

  factory Bookmarks.fromJson(String source) =>
      Bookmarks.fromMap(json.decode(source));

  @override
  String toString() =>
      'Bookmarks(name: $name, subtitle: $subtitle, route: $route, isFavorite: $isFavorite)';
}
