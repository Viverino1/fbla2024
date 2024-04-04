// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:fbla2024/components/project_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/Carousel.dart';
import '../components/nav_bar.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

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
          toolbarHeight: 40,
          title: Row(
            children: [
              SizedBox(width: 8,),
              Text(
                'Portfoliator',
                style: GoogleFonts.dmSerifDisplay(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: 60,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     //color: Colors.red.withOpacity(0.5)
            //   ),
            // ),
            ProjectPost(
                urls: [
                  "https://t3.ftcdn.net/jpg/03/15/34/90/360_F_315349043_6ohfFyx37AFusCKZtGQtJR0jqUxhb25Y.jpg",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8fFYdAr0gsHFnjVe6zxn8tZDjCY8mKGw78ttP2NYmUvmL-mP5-0C8nVu0pwprLZ037eo&usqp=CAU",
                  "https://burst.shopifycdn.com/photos/hiker-looks-up-at-vertical-mountain-peaks.jpg?width=1000&format=pjpg&exif=0&iptc=0"
                ]
            ),
            ProjectPost(
                urls: [
                  "https://t3.ftcdn.net/jpg/03/15/34/90/360_F_315349043_6ohfFyx37AFusCKZtGQtJR0jqUxhb25Y.jpg",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8fFYdAr0gsHFnjVe6zxn8tZDjCY8mKGw78ttP2NYmUvmL-mP5-0C8nVu0pwprLZ037eo&usqp=CAU",
                  "https://burst.shopifycdn.com/photos/hiker-looks-up-at-vertical-mountain-peaks.jpg?width=1000&format=pjpg&exif=0&iptc=0"
                ]
            ),
            ProjectPost(
                urls: [
                  "https://t3.ftcdn.net/jpg/03/15/34/90/360_F_315349043_6ohfFyx37AFusCKZtGQtJR0jqUxhb25Y.jpg",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8fFYdAr0gsHFnjVe6zxn8tZDjCY8mKGw78ttP2NYmUvmL-mP5-0C8nVu0pwprLZ037eo&usqp=CAU",
                  "https://burst.shopifycdn.com/photos/hiker-looks-up-at-vertical-mountain-peaks.jpg?width=1000&format=pjpg&exif=0&iptc=0"
                ]
            )
          ],
        ),
      )
    );
  }
}
