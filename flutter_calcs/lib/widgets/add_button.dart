import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/models/favorite_list_model.dart';
import 'package:flutter_calcs/models/favorite_page_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_calcs/firestore/functions.dart';

// Functions func = Functions();

// class AddButton extends StatefulWidget {
//   final Item item;

//   const AddButton({required this.item, Key? key}) : super(key: key);

//   @override
//   State<AddButton> createState() => _AddButtonState();
// }

// class _AddButtonState extends State<AddButton> {
//   List<bool> bookmark = [];
//   List<String> items = [];

//   @override
//   void initState() {
//     Map<String, bool> book = func.bookmarks;
//     items = book.keys.toList();
//     bookmark = book.values.toList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var isInFavoritePage = context.select<FavoritePageModel, bool>(
//     //   (favoritePage) => favoritePage.items.contains(item),
//     // );

//     return IconButton(
//       onPressed: () async {
//         await func.update(
//           func.auth.currentUser!.email.toString(),
//         );
//         setState(() {
//           bookmark[index] = !bookmark[index];
//           print(bookmark[index]);
//         });
//       },
//       icon: bookmark[index]
//           ? Icon(Icons.bookmark)
//           : Icon(Icons.bookmark_border_outlined),
//     );
//   }
// }

class AddButton extends StatelessWidget {
  final Item item;

  const AddButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //The context.select() method will let you listen to changes to a part
    //you're interested in, and the provider package will not rebuild this widget unless that
    //that particular part f the model changes

    var isInFavoritePage = context.select<FavoritePageModel, bool>(
      (favoritePage) => favoritePage.items.contains(item),
    );

    return IconButton(
      icon: isInFavoritePage
          ? const Icon(Icons.favorite, color: Color(0xFF4ade80))
          : const Icon(Icons.favorite_border, color: Color(0xFF4ade80)),
      onPressed:
          // async {

          //             await func.update(
          //                 func.auth.currentUser!.email.toString(), item.name);
          isInFavoritePage
              ? () {
                  var favouritePage = context.read<FavoritePageModel>();
                  favouritePage.remove(item);
                }
              : () {
                  var favouritePage = context.read<FavoritePageModel>();
                  favouritePage.add(item);
                },
    );
  }
}
