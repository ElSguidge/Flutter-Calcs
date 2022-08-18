import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/models/favorite_list_model.dart';
import 'package:flutter_calcs/models/favorite_page_model.dart';
// import 'package:flutter_calcs/provider/favorites_provider.dart';
import 'package:flutter_calcs/router.dart' as router;
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      Provider(create: (context) => FavoriteListModel()),
      ChangeNotifierProxyProvider<FavoriteListModel, FavoritePageModel>(
          create: (context) => FavoritePageModel(),
          update: (context, favoriteList, favoritePage) {
            if (favoritePage == null) {
              throw ArgumentError.notNull('favoritePage');
            }
            favoritePage.favoriteList = favoriteList;
            return favoritePage;
          },
      ),
    ],

    // return ChangeNotifierProvider(
    //     create: (_) => FavoritesProvider(),
    //     child: Builder(builder: (context) {
    child: const MaterialApp(
    debugShowCheckedModeBanner: false,
    onGenerateRoute: router.generateRoute,
    initialRoute: homeRoute,
  ),

    );
  }
}
