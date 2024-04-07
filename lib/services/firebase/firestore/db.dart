import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbla2024/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

const Source source = Source.cache;

class UserData {
  int dob = 0;
  String firstName = "";
  String lastName = "";
  String email = "";
  int gradYear = 0;
  int grade = 0;
  String photoUrl = "";
  int preact = 0;
  int act = 0;
  int psat = 0;
  int sat = 0;
  String uid = "";
  String school = "";
  String fullName = "";
  List<String> following = [];
  //List<String> followers = [];

  UserData({
    required this.dob,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gradYear,
    required this.grade,
    required this.photoUrl,
    required this.preact,
    required this.act,
    required this.psat,
    required this.sat,
    required this.uid,
    required this.school,
    required this.following,
    required this.fullName,
    //required this.followers,
  });

  UserData.empty();

  factory UserData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return UserData(
      dob: data?['dob'],
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      email: data?['email'],
      gradYear: data?['gradYear'],
      grade: data?['grade'],
      photoUrl: data?['photoUrl'],
      preact: data?['preact'],
      act: data?['act'],
      sat: data?['sat'],
      psat: data?['psat'],
      uid: snapshot.id,
      school: data?['school'],
      fullName: data?['firstName'] + " " + data?['lastName'],
      following: List.from(data?['following']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "dob": dob,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "gradYear": gradYear,
      "grade": grade,
      "photoUrl": photoUrl,
      "preact": preact,
      "act": act,
      "sat": sat,
      "psat": psat,
      "school": school,
      "following": following,
    };
  }

  static Future<UserData?> fromId(String uid) async{
    final ref = db.collection("users").doc(uid).withConverter(
      fromFirestore: UserData.fromFirestore,
      toFirestore: (UserData user, _) => user.toFirestore(),
    );
    var docSnap = await ref.get(GetOptions(source: source));
    final user = docSnap.data(); // Convert to User object
    return user;
  }
}

class PostData{
  String id = "";
  String description = "";
  List<String> likes = [];
  int postTime = 0;
  String title = "";
  String uid = "";
  String type = "";
  UserData user = UserData.empty();
  List<String> urls = [];
  List<Comment> comments = [];

  void Function() like;
  void Function() unLike;

  PostData({
    required this.description,
    required this.postTime,
    required this.title,
    required this.type,
    required this.urls,
    required this.likes,
    required this.id,
    required this.comments,
    required this.uid,
    required this.user,
    required this.like,
    required this.unLike,
  });

  factory PostData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return PostData(
      description: data?['description'],
      likes: List.from(data?['likes']),
      postTime: data?['postTime'],
      title: data?['title'],
      type: data?['type'],
      uid: data?['uid'],
      urls: List.from(data?['urls']),
      id: snapshot.id,
      comments: [],
      user: UserData.empty(),
      like: () => {},
        unLike: () => {}
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "description": description,
      "likes": likes,
      "postTime": postTime,
      "title": title,
      "type": type,
      "urls": urls,
      "uid": uid,
    };
  }

  static Future<PostData?> fromId(String id) async{
    final ref = db.collection("posts").doc(id).withConverter(
      fromFirestore: PostData.fromFirestore,
      toFirestore: (PostData post, _) => post.toFirestore(),
    );
    var docSnap = await ref.get(GetOptions(source: source));
    final post = docSnap.data(); // Convert to User object

    QuerySnapshot querySnapshot = await ref.collection("comments").get(GetOptions(source: source));

    for(var i = 0; i < querySnapshot.docs.length; i++){
      Comment? comment = await Comment.fromId(id, querySnapshot.docs[i].id);
      if(comment != null){
        post?.comments.add(comment);
      }
    }

    post?.user = (await UserData.fromId(post.uid))!;

    post?.like = () async {
      await ref.update({ 'likes': FieldValue.arrayUnion([currentUser.uid]) });
    };

    post?.unLike = () async {
      await ref.update({ 'likes': FieldValue.arrayRemove([currentUser.uid]) });
    };

    return post;
  }
}

class Comment{
  String uid = "";
  String content = "";
  int likes = 0;
  String id = "";
  List<Reply> replies;

  Comment({
    required this.uid,
    required this.content,
    required this.likes,
    required this.id,
    required this.replies,
  });

  factory Comment.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();

    return Comment(
      uid: data?['uid'],
      content: data?['content'],
      likes: data?['likes'],
      id: snapshot.id,
      replies: [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "content": content,
      "likes": likes,
    };
  }

  static Future<Comment?> fromId(String postID, String commentID) async{
    final ref = db.collection("posts").doc(postID).collection("comments").doc(commentID).withConverter(
      fromFirestore: Comment.fromFirestore,
      toFirestore: (Comment comment, _) => comment.toFirestore(),
    );
    var docSnap = await ref.get(GetOptions(source: source));
    final comment = docSnap.data(); // Convert to User object

    QuerySnapshot querySnapshot = await ref.collection("replies").get(GetOptions(source: source));

    for(var i = 0; i < querySnapshot.docs.length; i++){
      Reply? reply = await Reply.fromId(postID, commentID, querySnapshot.docs[i].id);
      if(reply != null){
        comment?.replies.add(reply);
      }
    }

    return comment;
  }
}

class Reply{
  String uid = "";
  String content = "";
  String id = "";

  Reply({
    required this.uid,
    required this.content,
    required this.id,
  });

  factory Reply.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Reply(
      uid: data?['uid'],
      content: data?['content'],
      id: snapshot.id,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "content": content,
    };
  }

  static Future<Reply?> fromId(String postID, String commentID, String replyID) async{
    final ref = db.collection("posts").doc(postID).collection("comments").doc(commentID).collection("replies").doc(replyID).withConverter(
      fromFirestore: Reply.fromFirestore,
      toFirestore: (Reply comment, _) => comment.toFirestore(),
    );
    var docSnap = await ref.get(GetOptions(source: source));
    final reply = docSnap.data(); // Convert to User object
    return reply;
  }
}

class FirestoreService{
  static Future<List<String>> getUserPostIDs(String uid) async{
    final querySnap = await db.collection("posts").where("uid", isEqualTo: uid).get(GetOptions(source: source));
    return querySnap.docs.map((e) => e.id).toList();
  }
}