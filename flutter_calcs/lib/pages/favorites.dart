// import 'package:flutter/material.dart';
// import 'package:flutter_calcs/constants/constants.dart';
// import 'package:flutter_calcs/models/favorite_page_model.dart';
// import 'package:provider/provider.dart';

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
//         drawer: Drawer(
//           child: Container(
//             color: Colors.white,
//             child: ListView(
//               children: [
//                 const DrawerHeader(
//                   child: Center(
//                     child: Image(
//                       image: AssetImage('lib/icons/cropped-AGC_Logo_2022.png'),
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.home),
//                   title: const Text('Home'),
//                   onTap: () {
//                     Navigator.pushNamed(context, homeRoute);
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.build),
//                   title: const Text('Install'),
//                   onTap: () {
//                     Navigator.pushNamed(context, installHome);
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.assignment_turned_in_sharp),
//                   title: const Text('Commissioning'),
//                   onTap: () {
//                     Navigator.pushNamed(context, commissioningHome);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
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

// class FavoritePageList extends StatelessWidget {
//   const FavoritePageList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // var itemNameStyle = Theme.of(context).textTheme.headline6;

//     // var favoritePage = context.watch<FavoritePageModel>();

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
// `              },
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
