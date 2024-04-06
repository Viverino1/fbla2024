// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:fbla2024/components/user_image.dart';
import 'package:fbla2024/pages/comment_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'carousel.dart';

class Post extends StatelessWidget {
  final List<String> urls;
  const Post({super.key, required this.urls});
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
                UserImage(uid: ""),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Title(),
                      Text(
                        "Competition",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                )
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
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentSection(postID: "examplePostID",),
                        ),
                      );
                    },
                    child: Icon(Icons.add_comment_outlined)
                ),
                SizedBox(width: 12),
                Icon(Icons.share),
                //SizedBox(width: 10),
              ],
            ),
          ),
          Description(),
        ],
      ),
    );
  }
}

class Description extends StatefulWidget {
  const Description({super.key});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        setState(() {
          _isExpanded = !_isExpanded;
        })
      },
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: _isExpanded? 9999999 : 2,
              text: TextSpan(
                  style: Theme.of(context).textTheme.titleSmall,
                  children: <TextSpan>[
                    TextSpan(text: "Vivek Maddineni", style: Theme.of(context).textTheme.titleMedium),
                    TextSpan(text: " ", style: Theme.of(context).textTheme.titleMedium),
                    TextSpan(text: "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.")
                  ]
              ),
            ),
          )
      ),
    );
  }
}

class Title extends StatefulWidget {
  const Title({super.key});

  @override
  State<Title> createState() => _TitleState();
}

class _TitleState extends State<Title> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        setState(() {
          _isExpanded = !_isExpanded;
        })
      },
      child: Text(
        "Missouri-Kansas First Tech Challenge Championship",
        maxLines: _isExpanded? 9999999999 : 1,
        style: Theme.of(context).textTheme.titleMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
