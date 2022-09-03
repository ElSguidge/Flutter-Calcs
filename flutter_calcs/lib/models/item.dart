class Item {
  final String name;
  final String subtitle;
  bool isFavorite = false;

  Item(this.name, this.subtitle, this.isFavorite);

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
  }
}
