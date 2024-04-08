// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fbla2024/components/loading.dart';
import 'package:fbla2024/components/user_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../components/button.dart';
import '../services/firebase/firestore/db.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({super.key, required this.comments});

  final List<CommentData> comments;

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
        children: comments.map((e) => Comment(data: e,)).toList()
      ),
    );
  }
}

class Comment extends StatefulWidget {
  final CommentData data;
  const Comment({super.key, required this.data});

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
          UserImage(uid: widget.data.uid,),
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
                    widget.data.content,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: _isExpanded? 9999999999 : 3,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  SizedBox(height: 4,),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: Row(
                            children: [
                              Icon(Icons.favorite_border, color: Theme.of(context).colorScheme.secondary, size: 16,),
                              SizedBox(width: 4,),
                              Text(widget.data.likes.length.toString() + " Likes", style: Theme.of(context).textTheme.titleSmall,),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: Row(
                            children: [
                              Icon(Icons.reply, color: Theme.of(context).colorScheme.secondary, size: 16,),
                              SizedBox(width: 4,),
                              Text(widget.data.replies.length.toString() + " Replies", style: Theme.of(context).textTheme.titleSmall,),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Theme.of(context).colorScheme.secondary, size: 16,),
                              SizedBox(width: 4,),
                              Text("Delete", style: Theme.of(context).textTheme.titleSmall,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Column(
                    children: widget.data.replies.map((e) => Reply(data: e,)).toList(),
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
  const Reply({super.key, required this.data});
  final ReplyData data;

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
        UserImage(uid: widget.data.uid,),
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
                  widget.data.content,
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
