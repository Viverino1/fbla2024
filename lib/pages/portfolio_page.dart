// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fbla2024/components/project_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary.withOpacity(.5),
                          width: 4
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              alignment: FractionalOffset.center,
                              image: NetworkImage(FirebaseAuth.instance.currentUser?.photoURL?? ""),
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Vivek Maddineni", style: Theme.of(context).textTheme.titleMedium, softWrap: true,),
                      Text("Lafayette High School", style: Theme.of(context).textTheme.titleSmall, softWrap: true,),
                      Text("Sophomore", style: Theme.of(context).textTheme.titleSmall, softWrap: true,),
                      SizedBox(height: 8,),

                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //     color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      //   ),
                      //   child: Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      //       child: Row(
                      //         children: [
                      //           Icon(Icons.hub, color: Theme.of(context).colorScheme.background, size: 16,),
                      //           SizedBox(width: 8,),
                      //           Text("Network", style: GoogleFonts.quicksand(
                      //               fontSize: 14,
                      //               color: Theme.of(context).colorScheme.background,
                      //               fontWeight: FontWeight.w700
                      //           )),
                      //         ],
                      //       )
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
