import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/firebase/firestore/db.dart';

class UserImage extends StatefulWidget {
  final String uid;
  const UserImage({super.key, required this.uid});

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        //User.fromId("UnYuiEEJtQVtq9I64oXXfMw1iIR2")
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(.5),
              width: 4
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: FractionalOffset.center,
                  image: NetworkImage("https://lh3.googleusercontent.com/-BAwkfezzhGg/AAAAAAAAAAI/AAAAAAAAAAA/ALKGfkn60m1utIJdMBBA7o4lazI1fGnHDQ/s128-c/photo.jpg"),
                )
            ),
          ),
        ),
      ),
    );
  }
}
