import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/database/db.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';

FirebaseServices firebaseServices = FirebaseServices();
final FirebaseFirestore _db = FirebaseFirestore.instance;
final email = firebaseServices.auth.currentUser!.email.toString();

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Favourites',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: ColorConstants.darkScaffoldBackgroundColor,
      ),
      drawer: CustomDrawer(),
      body: const FavoritePageList(),
    );
  }
}

class FavoritePageList extends StatefulWidget {
  const FavoritePageList({Key? key}) : super(key: key);

  @override
  State<FavoritePageList> createState() => _FavoritePageListState();
}

class _FavoritePageListState extends State<FavoritePageList> {
  List bookmarks = [];
  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _usersFavorites =
        _db.collection('user-favorites').doc(email).snapshots();

    return Material(
      child: StreamBuilder<DocumentSnapshot>(
          stream: _usersFavorites,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              bookmarks = [];
              var userFavoriteDoc = snapshot.data as DocumentSnapshot;

              // get sections from the document
              var sections = userFavoriteDoc['bookmarks'];

              // print(sections);
              for (final i in sections.entries) {
                // final key = i.key;
                final value = i.value;
                // print('Key: $key, Value: $value');
                if (value['isFavorite'] == true) {
                  var favoriteMap = {
                    'name': value['name'],
                    'subtitle': value['subtitle'],
                    'route': value['route']
                  };
                  bookmarks.add(favoriteMap);
                  if (bookmarks.isEmpty) {
                    Container(
                      color: ColorConstants.darkScaffoldBackgroundColor,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Center(
                            child: Text(
                          'You have no favorites!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 17),
                        )),
                      ),
                    );
                  }
                }
              }
              // print(bookmarks);

              return Container(
                color: ColorConstants.darkScaffoldBackgroundColor,
                child: ListView.builder(
                    itemCount: bookmarks.length,
                    itemBuilder: (BuildContext context, int index) {
                      // print(bookmarks.length);
                      // if (bookmarks.isEmpty) {
                      //   return const Align(
                      //     alignment: Alignment.center,
                      //     child: Center(
                      //         child: Text(
                      //       'You have no favorites!',
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(color: Colors.white),
                      //     )),
                      //   );
                      // } else {
                      // print(bookmarks.length);
                      return Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                          child: Material(
                            color: ColorConstants.textBoxColor,
                            borderRadius: BorderRadius.circular(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, bookmarks[index]['route']);
                                },
                                title: Text(
                                  bookmarks[index]['name'],
                                  style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white70,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    await firebaseServices.update(
                                        email, bookmarks[index]['name']);
                                    setState(() {
                                      if (bookmarks.isNotEmpty) {
                                        bookmarks.removeAt(index);
                                      }
                                    });
                                  },
                                ),
                                subtitle: Text(
                                  bookmarks[index]['subtitle'],
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.white60),
                                ),
                              ),
                            ),
                          ));
                      // }
                    }),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
