// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/database/db.dart';
import 'package:flutter_calcs/models/favorites.dart';
import 'package:flutter_calcs/router.dart' as router;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth auth = FirebaseAuth.instance;
    // FirebaseServices firebaseServices = FirebaseServices();

    // return MultiProvider(
    //     providers: [
    //       StreamProvider<List<Favorites?>>.value(
    //           value: firebaseServices
    //               .getFavorites(auth.currentUser!.email.toString()),
    //           initialData: const [])
    //     ],
    // child:
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      initialRoute: openingView,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   scaffoldBackgroundColor: Colors.black,
      // ),
    );
  }
}
