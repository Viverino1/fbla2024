// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
          Row(
            children: [
              Row(

              )
            ],
          ),
          SizedBox(height: 8,),
          Carousel(
            urls: urls,
          ),
        ],
      ),
    );
  }
}
