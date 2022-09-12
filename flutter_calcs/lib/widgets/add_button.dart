import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calcs/database/db.dart';

import '../constants/color_constants.dart';

class AddButton extends StatefulWidget {
  String title;

  AddButton({required this.title, Key? key}) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final FirebaseServices firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final email = firebaseServices.auth.currentUser!.email.toString();

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: db.collection('user-favorites').doc(email).snapshots(),
        builder: (context, snapshot) {
          Map? data = snapshot.data?.data();
          bool isFav = data?['bookmarks'][widget.title]['isFavorite'] ?? true;
          return Expanded(
            child: IconButton(
              onPressed: () async {
                await firebaseServices.update(email, widget.title);
                setState(() {});
              },
              icon: isFav
                  ? const Icon(Icons.bookmark_added,
                      color: ColorConstants.lightGreen)
                  : const Icon(
                      Icons.bookmark_outline,
                      color: Colors.white,
                    ),
            ),
          );
        });
  }
}
