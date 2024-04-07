// ignore_for_file: prefer_const_constructors

import 'package:fbla2024/components/user_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../components/button.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({super.key, required this.postID});

  final String postID;

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
                'Comments',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        toolbarHeight: 40,
      ),
      body: Column(
        children: [
          Comment(
            replies: [
              Reply(),
              Reply()
            ],
          ),
        ],
      ),
    );
  }
}

class Comment extends StatefulWidget {
  final List<Reply> replies;
  const Comment({super.key, required this.replies});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserImage(uid: "",),
          SizedBox(width: 8,),
          Flexible(
            child: GestureDetector(
              onTap: () => {
                setState(() {
                  _isExpanded = !_isExpanded;
                })
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vivek Maddineni",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: _isExpanded? 9999999999 : 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  SizedBox(height: 4,),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.favorite, color: Theme.of(context).colorScheme.secondary, size: 16,),
                          SizedBox(width: 4,),
                          Text("127 likes", style: Theme.of(context).textTheme.titleSmall,),
                        ],
                      ),
                      SizedBox(width: 8,),
                      Row(
                        children: [
                          Icon(Icons.reply, color: Theme.of(context).colorScheme.secondary, size: 16,),
                          SizedBox(width: 4,),
                          Text("2 replies", style: Theme.of(context).textTheme.titleSmall,),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  Column(
                    children: widget.replies,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Reply extends StatefulWidget {
  const Reply({super.key});

  @override
  State<Reply> createState() => _ReplyState();
}

class _ReplyState extends State<Reply> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserImage(uid: "",),
        SizedBox(width: 8,),
        Flexible(
          child: GestureDetector(
            onTap: () => {
              setState(() {
                _isExpanded = !_isExpanded;
              })
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Vivek Maddineni",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: _isExpanded? 9999999999 : 3,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                SizedBox(height: 8,),
              ],
            ),
          ),
        )
      ],
    );
  }
}
