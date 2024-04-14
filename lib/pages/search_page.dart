import 'package:fbla2024/components/loading.dart';
import 'package:fbla2024/components/user_image.dart';
import 'package:fbla2024/services/firebase/firestore/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Text(
                "Search",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        toolbarHeight: 40,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 16,),
              SizedBox(
                  height: 40,
                  child: TextField(
                    onChanged: (value){
                      setState(() {
                        _search = value;
                      });
                    },
                    cursorColor: Theme
                        .of(context)
                        .colorScheme
                        .secondary,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(height: 1),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none
                      ),
                      filled: true,
                      hintStyle: GoogleFonts.quicksand(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .secondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 16
                      ),
                      hintText: "Search by name or school.",
                      fillColor: Theme
                          .of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.2),
                    ),
                  )
              ),
              SizedBox(height: 16,),
              FutureBuilder(
                future: FirestoreService.getAllUsers(),
                builder: (BuildContext context, AsyncSnapshot<List<UserData>> snapshot){
                  return Column(
                    children: snapshot.data?.map((e) => UserChip(user: e)).where((element) =>
                        element.user.fullName.toLowerCase().contains(_search.toLowerCase()) ||
                        element.user.school.toString().contains(_search.toLowerCase())
                    ).toList()?? [
                      Loading("users")
                    ],
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserChip extends StatelessWidget {
  const UserChip({super.key, required this.user});
  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            UserImage(uid: user.uid),
            SizedBox(width: 8,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.fullName, style: Theme.of(context).textTheme.titleMedium,),
                Text(user.school, style: Theme.of(context).textTheme.titleSmall,),
              ],
            ),
            Spacer(),
            IconButton(onPressed: () => {}, icon: Icon(Icons.add), tooltip: "Follow",)
          ],
        ),
      ),
    );
  }
}
