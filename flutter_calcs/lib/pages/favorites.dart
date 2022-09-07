// import 'package:flutter/material.dart';
// import 'package:flutter_calcs/models/favorite_list_model.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_calcs/widgets/custom_drawer.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/favorite_page_model.dart';

// class FavoritePage extends StatelessWidget {
//   const FavoritePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Favourites',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 25,
//             ),
//           ),
//           backgroundColor: const Color(0xFF111827),
//         ),
//         drawer: const CustomDrawer(),
//         backgroundColor: const Color(0xFF111827),
//         body: Container(
//           color: const Color(0xFF111827),
//           child: Column(
//             children: const [
//               Expanded(
//                   child: Padding(
//                 padding: EdgeInsets.all(8),
//                 child: FavoritePageList(),
//               ))
//             ],
//           ),
//         ));
//   }
// }

// class FavoritePageList extends StatefulWidget {
//   const FavoritePageList({Key? key}) : super(key: key);

//   @override
//   State<FavoritePageList> createState() => _FavoritePageListState();
// }

// class _FavoritePageListState extends State<FavoritePageList> {
//   FavoriteListModel? get favoriteList => _favoriteList;

//   // FavoriteListModel? favoriteList;

//   List<String>? favoriteItemsId = [];
//   List<int> testing = [];

//   get _favoriteList => null;
//   @override
//   void initState() {
//     super.initState();
//     getFavs();
//   }

//   getFavs() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       //get the string list from shared pref
//       favoriteItemsId = prefs.getStringList("bookmarks");
//       // parse strings to ints
//       testing = favoriteItemsId!.map((i) => int.parse(i)).toList();

//       var favoritePage = Provider.of<FavoritePageModel>(context, listen: false);
//       if (favoritePage.items.isEmpty) {
//         testing.map((id) => _favoriteList?.getById(id)).toList();
//         print("shared favorites: ${testing.toString()}");
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var itemNameStyle = Theme.of(context).textTheme.headline6;

//     var favoritePage = context.watch<FavoritePageModel>();
//     // var sharedPrefs = context.watch<SharedPreferences?>();
//     // print("testing: ${sharedPrefs.toString()}");
//     // if (favoritePage.items.isEmpty) {
//     //   favoritePage = sharedPrefs as FavoritePageModel;
//     // }
//     //    var isInFavoritePage = context.select<FavoritePageModel, bool>(
//     //   (favoritePage) => favoritePage.items.contains(item),
//     // );

//     return ListView.builder(
//       itemCount: favoritePage.items.length,
//       itemBuilder: (context, index) => Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: Material(
//           color: const Color(0xFF3b82f6),
//           borderRadius: BorderRadius.circular(20),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListTile(
//               onTap: () {
//                 Navigator.pushNamed(context, favoritePage.items[index].route);
//               },
//               title: Text(
//                 favoritePage.items[index].name,
//                 style: const TextStyle(
//                     fontSize: 24,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600),
//               ),
//               trailing: IconButton(
//                 icon: const Icon(
//                   Icons.delete,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//                 onPressed: () {
//                   favoritePage.remove(favoritePage.items[index]);
//                 },
//               ),
//               subtitle: Text(
//                 favoritePage.items[index].subtitle,
//                 style: const TextStyle(fontSize: 13, color: Colors.white),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
