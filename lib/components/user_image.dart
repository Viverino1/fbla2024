import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/firebase/firestore/db.dart';

class UserImage extends StatelessWidget {
  final String uid;
  const UserImage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {

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
          child: FutureBuilder(
            future: UserData.fromId(uid),
            builder: (BuildContext context, AsyncSnapshot<UserData?> snapshot){
              return Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.center,
                      image: NetworkImage(snapshot.data?.photoUrl?? ""),
                    )
                ),
              );
            },
          )
        ),
      ),
    );
  }
}
