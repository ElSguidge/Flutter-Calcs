import 'package:flutter/material.dart';
import 'package:flutter_calcs/models/favorite_list_model.dart';
import 'package:flutter/foundation.dart';
//
// class Favorites {
//   late final int? id;
//   final String? calcName;
//   final String? category;
//   final String? route;
//   // bool isFav = false;
//
//   Favorites(
//       {required this.route, required this.id,  this.calcName, required this.category});
//
// Favorites.fromMap(Map<dynamic, dynamic> data)
//       : id = data['id'],
//         calcName = data['calcName'],
//         category = data['category'],
//         route = data['route'];
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'calcName': calcName,
//       'category': category,
//       'route': route,
//     };
//   }
// }

class FavoritePageModel extends ChangeNotifier {

  late FavoriteListModel _favoriteList;

  // Stores the ids of each item
  final List<int> _itemIds = [];

  // The current favorite list. Used to construct items from numeric ids
  FavoriteListModel get favoriteList => _favoriteList;

  set favoriteList(FavoriteListModel newList) {
    _favoriteList = newList;
    //Notify listeners in case list changes
    notifyListeners();
  }

  //List of items in the favorites page

  List<Item> get items =>
      _itemIds.map((id) => _favoriteList.getById(id)).toList();

  //Adds items to favorite page

  void add(Item item) {
    _itemIds.add(item.id);
    notifyListeners();
  }
  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }
}