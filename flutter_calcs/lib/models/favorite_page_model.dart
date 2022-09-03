import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_calcs/models/favorite_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePageModel extends ChangeNotifier {
  late FavoriteListModel _favoriteList;
  SharedPreferences? prefs;
  // Stores the ids of each item
  List<int> _itemIds = [];
  final List<int> _tempItems = [];

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

  void add(Item item) async {
    // change this to new String array and change to string for sharedpref
    if (!_tempItems.contains(item.id)) {
      _tempItems.add(item.id);

      List<String> _stringList = _tempItems.map((i) => i.toString()).toList();
      prefs = await SharedPreferences.getInstance();
      prefs?.setStringList("bookmarks", _stringList);
      final List<String>? savedStrList = prefs!.getStringList('bookmarks');
      _itemIds = savedStrList!.map((i) => int.parse(i)).toList();
      print("provider items: ${_itemIds.toString()}");
      notifyListeners();
    } else {
      print("this item is already saved!");
      // print("${savedStrList.toString()}");
    }
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }
}
