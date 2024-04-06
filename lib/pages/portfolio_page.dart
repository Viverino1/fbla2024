// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fbla2024/components/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/button.dart';
import '../components/nav_bar.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

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
                'Vivek Maddineni',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Spacer(),
              Icon(Icons.share),
              SizedBox(width: 12,),
              Icon(Icons.settings)
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
              Text("Vivek Maddineni", style: Theme.of(context).textTheme.titleMedium, softWrap: true,),
              Text("Lafayette High School", style: Theme.of(context).textTheme.titleSmall, softWrap: true,),
              Text("Class of 2026", style: Theme.of(context).textTheme.titleSmall, softWrap: true,),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                    icon: Icons.hub,
                    text: "Network",
                    onTap: () => {},
                  ),
                  Button(
                    icon: Icons.school,
                    text: "Academics",
                    onTap: () => {},
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
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Post(urls: [
                "https://t3.ftcdn.net/jpg/03/15/34/90/360_F_315349043_6ohfFyx37AFusCKZtGQtJR0jqUxhb25Y.jpg",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8fFYdAr0gsHFnjVe6zxn8tZDjCY8mKGw78ttP2NYmUvmL-mP5-0C8nVu0pwprLZ037eo&usqp=CAU",
                "https://burst.shopifycdn.com/photos/hiker-looks-up-at-vertical-mountain-peaks.jpg?width=1000&format=pjpg&exif=0&iptc=0"
              ]),
              Post(urls: [
                "https://t3.ftcdn.net/jpg/03/15/34/90/360_F_315349043_6ohfFyx37AFusCKZtGQtJR0jqUxhb25Y.jpg",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8fFYdAr0gsHFnjVe6zxn8tZDjCY8mKGw78ttP2NYmUvmL-mP5-0C8nVu0pwprLZ037eo&usqp=CAU",
                "https://burst.shopifycdn.com/photos/hiker-looks-up-at-vertical-mountain-peaks.jpg?width=1000&format=pjpg&exif=0&iptc=0"
              ])
            ],
          ),
        ),
      ),
    );
  }
}
