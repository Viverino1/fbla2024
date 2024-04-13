// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbla2024/components/user_image.dart';
import 'package:fbla2024/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/firebase/firestore/db.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({super.key, required this.comments, required this.postData});

  final List<CommentData> comments;
  final PostData postData;

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  String _replyToId = "";
  String _replyToName = "";

  @override
  Widget build(BuildContext context) {
    final fieldText = TextEditingController();

    // FocusNode inputNode = FocusNode();
    // // to open keyboard call this function;
    // void openKeyboard(){
    //   FocusScope.of(context).requestFocus(inputNode);
    // }

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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: widget.comments.map((e) => Comment(
                  data: e,
                  onReply: (name){
                    setState(() {
                      _replyToId = e.id;
                      _replyToName = name;
                    });
                  },
                  onDelete: (){
                    setState(() {
                      widget.comments.removeWhere((element) => element.id == e.id);
                    });
                  },
                )).toList(),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        _replyToName != ""? "Replying to " + _replyToName : "",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => setState(() {
                          _replyToName = "";
                          _replyToId = "";
                        }),
                        child: Container(
                          height: 24,
                          width: 24,
                          child: Icon(
                              Icons.close,
                            size: 16,
                            color: Theme.of(context).colorScheme.background,
                          ),
                          decoration: BoxDecoration(
                            color: _replyToId == ""? Colors.transparent : Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      //focusNode: inputNode,
                      controller: fieldText,
                      onSubmitted: (text){
                        fieldText.clear();

                       if(text.isNotEmpty){
                         if(_replyToId == ""){
                           widget.postData.addComment(widget.postData.id, text);
                         }else{
                           widget.postData.comments[widget.postData.comments.indexWhere((element) => element.id == _replyToId)]
                               .addReply(widget.postData.id, _replyToId, text);
                         }
                       }

                        setState(() {
                          _replyToId = "";
                          _replyToName = "";
                        });
                      },
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      style: GoogleFonts.quicksand(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 1,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none
                        ),
                        filled: true,
                        hintStyle: GoogleFonts.quicksand(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w500,
                            fontSize: 16

                        ),
                        hintText: "Add a comment",
                        fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ]
        ),
      ),
    );
  }
}

class Comment extends StatefulWidget {
  final CommentData data;
  final void Function(String name) onReply;
  final void Function() onDelete;
  const Comment({super.key, required this.data, required this.onReply, required this.onDelete});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: UserData.fromId(widget.data.uid),
          builder: (BuildContext context, AsyncSnapshot<UserData?> snapshot){
            if(!snapshot.hasData){
              return Container();
            }
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
                        Row(
                          children: [
                            Text(
                              snapshot.data?.fullName?? "",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(width: 8,),
                            Row(
                              children: [
                                LikeButton(
                                  likes: widget.data.likes,
                                  like: widget.data.like,
                                  unLike: widget.data.unLike,
                                  isLiked: widget.data.likes.contains(currentUser.uid),
                                ),
                                SizedBox(width: 8,),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => {
                                      widget.onReply(snapshot.data?.fullName?? "")
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      child: Row(
                                        children: [
                                          Icon(Icons.reply, color: Theme.of(context).colorScheme.secondary, size: 16,),
                                          //SizedBox(width: 4,),
                                          //Text(widget.data.replies.length.toString() + " Replies", style: Theme.of(context).textTheme.titleSmall,),
                                          //Text("Reply", style: Theme.of(context).textTheme.titleSmall,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8,),
                                GestureDetector(
                                  onTap: (){
                                    widget.data.delete();
                                    widget.onDelete();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, color: Theme.of(context).colorScheme.secondary, size: 16,),
                                          // SizedBox(width: 4,),
                                          // Text("Delete", style: Theme.of(context).textTheme.titleSmall,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          widget.data.content,
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: _isExpanded? 9999999999 : 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                        SizedBox(height: 4,),
                        SizedBox(height: 8,),
                        Column(
                          children: widget.data.replies.map((e) => Reply(
                            data: e,
                            onDelete: (){
                              setState(() {
                                widget.data.replies.removeWhere((element) => element.id == e.id);
                              });
                            },
                          )).toList(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      );
  }
}

class Reply extends StatefulWidget {
  const Reply({super.key, required this.data, required this.onDelete});
  final ReplyData data;
  final Function() onDelete;

  @override
  State<Reply> createState() => _ReplyState();
}

class _ReplyState extends State<Reply> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserData.fromId(widget.data.uid),
        builder: (BuildContext context, AsyncSnapshot<UserData?> snapshot){
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserImage(uid: widget.data.uid),
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
                      Row(
                        children: [
                          Text(
                            snapshot.data?.fullName?? "",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(width: 8,),
                          GestureDetector(
                            onTap: (){
                              widget.data.delete();
                              widget.onDelete();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Theme.of(context).colorScheme.secondary, size: 16,),
                                    // SizedBox(width: 4,),
                                    // Text("Delete", style: Theme.of(context).textTheme.titleSmall,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
              ),
            ],
          );
      }
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton({super.key, required this.likes, required this.like, required this.unLike, required this.isLiked});

  @override
  State<LikeButton> createState() => _LikeButtonState();

  final List<String> likes;
  final void Function() like;
  final void Function() unLike;
  final bool isLiked;
}

class _LikeButtonState extends State<LikeButton> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(_count % 2 == 0? widget.isLiked : !widget.isLiked){
          widget.unLike();
          widget.likes.remove(currentUser.uid);
        }else{
          widget.like();
          widget.likes.add(currentUser.uid);
        }

        setState(() {_count++;});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Row(
            children: [
              Text(
                (widget.likes.length).toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(width: 4,),
              Icon(
                (_count % 2 == 0? widget.isLiked : !widget.isLiked)? Icons.favorite : Icons.favorite_border,
                color: (_count % 2 == 0? widget.isLiked : !widget.isLiked)? Colors.red : Colors.white,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
