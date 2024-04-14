// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:fbla2024/components/user_image.dart';
import 'package:fbla2024/pages/comment_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../services/firebase/firestore/db.dart';
import '../services/share.dart';
import 'carousel.dart';
import 'loading.dart';

class Post extends StatefulWidget {
  final String id;
  final void Function() onDelete;
  const Post({super.key, required this.id, required this.onDelete});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PostData.fromId(widget.id),
      builder: (BuildContext context, AsyncSnapshot<PostData?> snapshot){
        PostData? possiblyNull = snapshot.data;
        if(snapshot.hasData && possiblyNull != null){
          PostData data = possiblyNull;
          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(data.postTime * 1000).toLocal();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    UserImage(uid: data.user.uid),
                    SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Title(text: data.title,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data.type,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              SizedBox(width: 8,),
                              Container(
                                height: 4,
                                width: 4,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                              SizedBox(width: 8,),
                              Text(
                                dateTime.month.toString() + "/" + dateTime.day.toString() + "/" + dateTime.year.toString(),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Carousel(
                urls: data.urls,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Likes(
                      likes: data.likes,
                      like: data.like,
                      unLike: data.unLike,
                      isLiked: data.likes.contains(currentUser.uid),
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentSection(comments: data.comments, postData: data,),
                            ),
                          );
                        },
                        child: Icon(Icons.add_comment_outlined)
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: (){
                        Share.share();
                      },
                      child: Icon(Icons.share),
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: (){
                        data.delete();
                        widget.onDelete();
                      },
                        child: Icon(Icons.delete_outline)
                    ),
                    //SizedBox(width: 10),
                  ],
                ),
              ),
              Description(user: data.user.fullName, content: data.description),
              SizedBox(height: 12,),
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
            ],
          );
        }else{
          return Loading("Post");
        }
      }
    );
  }
}

class Description extends StatefulWidget {
  const Description({super.key, required this.content, required this.user});
  final String content;
  final String user;

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
                    TextSpan(text: widget.user, style: Theme.of(context).textTheme.titleMedium),
                    TextSpan(text: " ", style: Theme.of(context).textTheme.titleMedium),
                    TextSpan(text: widget.content)
                  ]
              ),
            ),
          )
      ),
    );
  }
}

class Title extends StatefulWidget {
  const Title({super.key, required this.text});
  final String text;

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
        widget.text,
        maxLines: _isExpanded? 9999999999 : 1,
        style: Theme.of(context).textTheme.titleMedium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
class Likes extends StatefulWidget {
  Likes({super.key, required this.likes, required this.like, required this.unLike, required this.isLiked});

  final List<String> likes;
  final void Function() like;
  final void Function() unLike;
  final bool isLiked;

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        (_count % 2 == 0? widget.isLiked : !widget.isLiked)? widget.unLike() : widget.like();

        setState(() {_count++;});
      },
      child: Row(
        children: [
          Icon(
            (_count % 2 == 0? widget.isLiked : !widget.isLiked)? Icons.favorite : Icons.favorite_border,
             color: (_count % 2 == 0? widget.isLiked : !widget.isLiked)? Colors.red : Colors.white,
          ),
          SizedBox(width: 8),
          Text(
            (widget.likes.length + (widget.isLiked? -(_count % 2) : (_count % 2))).toString() + " Likes",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}