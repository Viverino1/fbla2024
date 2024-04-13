// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fbla2024/components/loading.dart';
import 'package:fbla2024/components/post.dart';
import 'package:fbla2024/main.dart';
import 'package:fbla2024/pages/academics_page.dart';
import 'package:fbla2024/services/firebase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../components/button.dart';
import 'package:fbla2024/services/firebase/firestore/db.dart';

import '../services/gemini/gemini.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final Future<List<String>> _postIDs = FirestoreService.getUserPostIDs(currentUser.uid);

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
                "Your Profile",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Spacer(),
              Icon(Icons.share),
              SizedBox(width: 12,),
              GestureDetector(
                onTap: AuthService().signInWithGoogle,
                  child: Icon(Icons.settings)
              )
            ],
          ),
        ),
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                        color: Theme.of(context).colorScheme.primary.withOpacity(.5),
                        width: 4
                    ),
                    color: Theme.of(context).colorScheme.background.withOpacity(0.5),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(.5),
                        spreadRadius: 1,
                        blurRadius: 10,
                      ),
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: NetworkImage(FirebaseAuth.instance.currentUser?.photoURL?? ""),
                          fit: BoxFit.cover,
                          alignment: FractionalOffset.center,
                        )
                      ),
                    ),
                  ),
                ),
              ),
              Text(currentUser.fullName, style: Theme.of(context).textTheme.titleMedium, softWrap: true,),
              Text(currentUser.school, style: Theme.of(context).textTheme.titleSmall, softWrap: true,),
              Text("Class of " + currentUser.gradYear.toString(), style: Theme.of(context).textTheme.titleSmall, softWrap: true,),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                    icon: Icons.hub,
                    text: "Network",
                    onTap: () => {
                      Gemini.sendMessage("msg")
                    },
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Icon(
                      Icons.question_mark,
                      size: 20,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Button(
                    icon: Icons.school,
                    text: "Academics",
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Academics(user: currentUser))
                      )
                    },
                    iconSize: 18,
                  ),

                ],
              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  height: 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 12,),
              FutureBuilder<List<String>>(
                  future: _postIDs,
                  builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot){
                    List<Widget> children;
                    if(snapshot.hasData){
                      children = snapshot.data?.map((e) => Post(id: e, onDelete: (){
                        setState(() {
                          snapshot.data?.removeWhere((element) => element == e);
                        });
                      },)).toList()?? [];
                    }else{
                      children = <Widget>[
                        Loading("Posts"),
                      ];
                    }
                    return Column(
                      children: children,
                    );
                  }
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}
