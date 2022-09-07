// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/router.dart' as router;
// import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final FirebaseServices firebaseServices = FirebaseServices();
    // return StreamProvider(
    //   create: (BuildContext context) => firebaseServices.getCalcs(),
    //   // ChangeNotifierProxyProvider<FavoriteListModel, FavoritePageModel>(
    //   //   create: (context) => FavoritePageModel(),
    //   //   update: (context, favoriteList, favoritePage) {
    //   //     if (favoritePage == null) {
    //   //       throw ArgumentError.notNull('favoritePage');
    //   //     }
    //   //     favoritePage.favoriteList = favoriteList;
    //   //     return favoritePage;
    //   //   },
    //   // ),
    //   initialData: const [],
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      initialRoute: openingView,
    );
  }
}
