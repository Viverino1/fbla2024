// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Carousel.dart';

class ProjectPost extends StatelessWidget {
  final List<String> urls;
  const ProjectPost({super.key, required this.urls});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Container(
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
                SizedBox(width: 10),
                Text(
                  "Automatic Blinds Project",
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Carousel(
            urls: urls,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.favorite_border),
                SizedBox(width: 8),
                Text(
                  "821 Likes",
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                  ),
                ),
                Spacer(),
                Icon(Icons.add_comment_outlined),
                SizedBox(width: 12),
                Icon(Icons.share),
                //SizedBox(width: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
