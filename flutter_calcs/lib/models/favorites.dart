class Favorites {
  final String? name;
  final String? route;
  final String? subtitle;

  Favorites({this.name, this.route, this.subtitle});

  Map<String, dynamic> toJson() =>
      {'name': name, 'route': route, 'subtitle': subtitle};

  Favorites.fromMap(Map<String, dynamic> favoritesMap)
      : name = favoritesMap['name'],
        route = favoritesMap['route'],
        subtitle = favoritesMap['subtitle'];
}
