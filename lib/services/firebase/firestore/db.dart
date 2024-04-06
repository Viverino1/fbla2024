// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../../main.dart';
//
// class User {
//   int dob = 0;
//   String firstName = "";
//   String lastName = "";
//   String email = "";
//   int gradYear = 0;
//   int grade = 0;
//   String photoUrl = "";
//   int preact = 0;
//   int act = 0;
//   int psat = 0;
//   int sat = 0;
//   String uid = "";
//   String school = "";
//
//   User({
//     required this.dob,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.gradYear,
//     required this.grade,
//     required this.photoUrl,
//     required this.preact,
//     required this.act,
//     required this.psat,
//     required this.sat,
//     required this.uid,
//     required this.school,
//   });
//
//   factory User.fromFirestore(
//       DocumentSnapshot<Map<String, dynamic>> snapshot,
//       SnapshotOptions? options,
//       ) {
//     final data = snapshot.data();
//     return User(
//       dob: data?['dob'],
//       firstName: data?['firstName'],
//       lastName: data?['lastName'],
//       email: data?['email'],
//       gradYear: data?['gradYear'],
//       grade: data?['grade'],
//       photoUrl: data?['photoUrl'],
//       preact: data?['preact'],
//       act: data?['act'],
//       sat: data?['sat'],
//       psat: data?['psat'],
//       uid: data?['uid'],
//       school: data?['school'],
//     );
//   }
//
//   Map<String, dynamic> toFirestore() {
//     return {
//       "dob": dob,
//       "firstName": firstName,
//       "lastName": lastName,
//       "email": email,
//       "gradYear": gradYear,
//       "grade": grade,
//       "photoUrl": photoUrl,
//       "preact": preact,
//       "act": act,
//       "sat": sat,
//       "psat": psat,
//       "uid": uid,
//       "school": school,
//     };
//   }
//
//   static Future<User?> fromId(String uid) async{
//     // final ref = db.collection("users").doc(uid).withConverter(
//     //   fromFirestore: User.fromFirestore,
//     //   toFirestore: (User user, _) => user.toFirestore(),
//     // );
//     // final docSnap = await ref.get();
//     // final user = docSnap.data(); // Convert to User object
//     // return this;
//     final docRef = await db.collection("users").doc(uid).get();
//     print(docRef.data());
//   }
// }