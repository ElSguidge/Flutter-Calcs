class FavoriteListModel {
  static List<String> itemNames = [
    'Duct Area',
    'Total Pressure',
  ];

  static List<String> itemSubtitle = [
    'Find the area of a rectangle, round or flat oval',
    'Find the total air pressure'
  ];

  static List<String> itemPath = [
    'ductArea',
    'totalPressure',
  ];

  // Get item by [id]
  Item getById(int id) => Item(
        id,
        itemNames[id % itemNames.length],
        itemSubtitle[id % itemSubtitle.length],
        itemPath[id % itemPath.length],
      );
  //Get items by its position in the List
  Item getByPosition(int position) {
    return getById(position);
  }
}

class Item {
  final int id;
  final String name;
  final String subtitle;
  final String route;

  const Item(this.id, this.name, this.subtitle, this.route);

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
