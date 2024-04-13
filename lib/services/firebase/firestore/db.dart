import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbla2024/main.dart';
import 'package:flutter/cupertino.dart';
FirebaseFirestore db = FirebaseFirestore.instance;

const Source source = Source.server;

class UserData {
  int dob = 0;
  String firstName = "";
  String lastName = "";
  String email = "";
  int gradYear = 0;
  double grade = 0.0;
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
    int gradeAsInt = (data?['grade']);
    return UserData(
      dob: data?['dob'],
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      email: data?['email'],
      gradYear: data?['gradYear'],
      grade: gradeAsInt.toDouble(),
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
  List<CommentData> comments = [];

  void Function() like = () => {};
  void Function() unLike = () => {};

  void addComment(String postID, String content) async{
    final ref = db.collection("posts").doc(postID).collection("comments").doc();
    comments.add(CommentData(uid: currentUser.uid, content: content, likes: [], id: ref.id, replies: []));
    await ref.set({
      "content": content,
      "likes": [],
      "uid": currentUser.uid,
    });
  }

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

  PostData.empty();

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
      CommentData? comment = await CommentData.fromId(id, querySnapshot.docs[i].id);
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

class CommentData{
  String uid = "";
  String content = "";
  List<String> likes = [];
  String id = "";
  List<ReplyData> replies = [];

  void like () async {
    await docRef?.update({ 'likes': FieldValue.arrayUnion([currentUser.uid]) });
    //likes.add(currentUser.uid);
  }

  void unLike () async {
    await docRef?.update({ 'likes': FieldValue.arrayRemove([currentUser.uid]) });
    //likes.remove(currentUser.uid);
  }

  void delete() async {
    await docRef?.delete();
  }

  DocumentReference? docRef;

  CommentData({
    required this.uid,
    required this.content,
    required this.likes,
    required this.id,
    required this.replies,
  });

  CommentData.empty();

  factory CommentData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();

    return CommentData(
      uid: data?['uid'],
      content: data?['content'],
      likes: List.from(data?['likes']),
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

  static Future<CommentData?> fromId(String postID, String commentID) async{
    final ref = db.collection("posts").doc(postID).collection("comments").doc(commentID).withConverter(
      fromFirestore: CommentData.fromFirestore,
      toFirestore: (CommentData comment, _) => comment.toFirestore(),
    );
    var docSnap = await ref.get(GetOptions(source: source));
    final comment = docSnap.data(); // Convert to User object

    QuerySnapshot querySnapshot = await ref.collection("replies").get(GetOptions(source: source));

    for(var i = 0; i < querySnapshot.docs.length; i++){
      ReplyData? reply = await ReplyData.fromId(postID, commentID, querySnapshot.docs[i].id);
      if(reply != null){
        comment?.replies.add(reply);
      }
    }

    comment?.docRef = ref;

    return comment;
  }

  void addReply(String postID, String commentID, String content) async{
    final ref = db.collection("posts").doc(postID).collection("comments").doc(commentID).collection("replies").doc();
    replies.add(ReplyData(uid: currentUser.uid, content: content, id: ref.id));
    await ref.set({
      "content": content,
      "uid": currentUser.uid,
    });
  }
}

class ReplyData{
  String uid = "";
  String content = "";
  String id = "";

  void delete() async {
    await docRef?.delete();
  }

  DocumentReference? docRef;

  ReplyData({
    required this.uid,
    required this.content,
    required this.id,
  });

  factory ReplyData.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return ReplyData(
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

  static Future<ReplyData?> fromId(String postID, String commentID, String replyID) async{
    final ref = db.collection("posts").doc(postID).collection("comments").doc(commentID).collection("replies").doc(replyID).withConverter(
      fromFirestore: ReplyData.fromFirestore,
      toFirestore: (ReplyData comment, _) => comment.toFirestore(),
    );
    var docSnap = await ref.get(GetOptions(source: source));
    final reply = docSnap.data(); // Convert to User object
    reply?.docRef = ref;
    return reply;
  }
}

class ClassData{
  String id = "";
  String name = "";
  bool isAp = false;
  bool isHonors = false;
  double grade = 0;
  double score = 0;
  int sem = 1;

  void delete() async {
    db.collection("users").doc(currentUser.uid).collection("classes").doc(id).delete();
  }

  DocumentReference? docRef;

  ClassData({
    required this.id,
    required this.name,
    required this.isAp,
    required this.isHonors,
    required this.grade,
    required this.score,
    required this.sem,
  });

  ClassData.empty();

  static Future<ClassData?> fromId(String uid, String id) async{
    final publicData = await (await db.collection("classes").doc(id).get(GetOptions(source: source))).data();
    final privateData = await (await db.collection("users").doc(uid).collection("classes").doc(id).get(GetOptions(source: source))).data();

    ClassData classdata = ClassData(
        id: id,
        name: publicData?["name"],
        isAp: publicData?["isAp"],
        isHonors: privateData?["isHonors"],
        grade: privateData?["grade"].toDouble(),
        score: privateData?["score"],
        sem: privateData?["sem"],
    );

    return classdata;
  }
}

class FirestoreService{
  static Future<List<String>> getUserPostIDs(String uid) async{
    final querySnap = await db.collection("posts").where("uid", isEqualTo: uid).get(GetOptions(source: source));
    return querySnap.docs.map((e) => e.id).toList();
  }

  static Future<List<ClassData>> getUserClasses(String uid) async{
    List<ClassData> classes = [];

    final classDocs = await db.collection("users").doc(uid).collection("classes").get();

    for(int i = 0; i < classDocs.docs.length; i++){
      final classData = await ClassData.fromId(uid, classDocs.docs[i].id);
      if(classData != null){
        classes.add(classData);
      }
    }

    return classes;
  }

  static Future<List<ClassData>> getPublicClasses() async {
    List<ClassData> classes = [];

    final classDocs = await db.collection("classes").get(GetOptions(source: source));

    for(int i = 0; i < classDocs.docs.length; i++){
      final classData = ClassData.empty();

      final data = classDocs.docs[i].data();

      classData.id = classDocs.docs[i].id;
      classData.name = data["name"];
      classData.isAp = data["isAp"];

      classes.add(classData);
    }

    return classes;
  }

  static void addClass(ClassData classData){
    db.collection("users").doc(currentUser.uid).collection("classes").doc(classData.id).set({
      "isHonors": classData.isHonors,
      "score": classData.score,
      "grade": classData.grade,
      "sem": classData.sem,
    });
  }

  static String addPublicClass(ClassData classData){
    final docRef = db.collection("classes").doc();
    classData.id = docRef.id;
    docRef.set({
      "isAp" : classData.isAp,
      "name": classData.name,
    });

    return docRef.id;
  }
}