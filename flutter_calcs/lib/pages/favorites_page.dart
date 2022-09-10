import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          backgroundColor: Colors.black,
        ),
        drawer: const CustomDrawer(),
        body: Container(
          color: Colors.black,
          child: Column(
            children: const [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: FavoritePageList(),
              ))
            ],
          ),
        ));
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
              // get course document
              var userFavoriteDoc = snapshot.data as DocumentSnapshot;

              // get sections from the document
              var sections = userFavoriteDoc['bookmarks'];
              print(sections);
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
                }
              }
              if (bookmarks == []) {
                return const Text('You have no favorites!');
              }
              return ListView.builder(
                itemCount: bookmarks.length,
                itemBuilder: (_, int index) {
                  // print(bookmarks.length);
                  return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Material(
                        color: const Color(0xFFf97316),
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, bookmarks[index]['route']);
                            },
                            title: Text(
                              bookmarks[index]['name'],
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                // firebaseServices.remove(favoritePage.items[index]);
                              },
                            ),
                            subtitle: Text(
                              bookmarks[index]['subtitle'],
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.white),
                            ),
                          ),
                        ),
                      ));
                },
              );
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}