import 'dart:convert';
import 'package:flutter_calcs/firestore/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calcs/models/favorite_list_model.dart';
import 'package:flutter/foundation.dart';

class FavoritePageModel extends ChangeNotifier {
  // FirebaseAuth auth = FirebaseAuth.instance;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

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
