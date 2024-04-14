import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbla2024/app_colors.dart';
import 'package:fbla2024/pages/academics_page.dart';
import 'package:fbla2024/pages/class_details.dart';
import 'package:fbla2024/pages/comment_section.dart';
import 'package:fbla2024/pages/hero_page.dart';
import 'package:fbla2024/pages/home_page.dart';
import 'package:fbla2024/pages/network.dart';
import 'package:fbla2024/pages/new_post.dart';
import 'package:fbla2024/pages/settings_page.dart';
import 'package:fbla2024/pages/user_details.dart';
import 'package:fbla2024/services/firebase/auth_service.dart';
import 'package:fbla2024/services/firebase/firestore/db.dart';
import 'package:fbla2024/services/gemini/gemini.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:snapkit/snapkit.dart';
import 'firebase_options.dart';

UserData currentUser = UserData.empty();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Gemini.init();

  final fbu = FirebaseAuth.instance.currentUser;
  if(fbu != null){
    currentUser = (await UserData.fromId(fbu.uid))!;
  }
}

const backgroundColor = Color.fromARGB(255, 34, 34, 34);

class MyApp extends StatelessWidget implements SnapchatAuthStateListener {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: true? HomePage() : HeroPage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/view-profile': (context) => const Scaffold(),
        '/comment-section': (context) => CommentSection(comments: [], postData: PostData.empty(),),
        '/academics': (context) => Academics(user: currentUser,),
        '/class-details': (context) => ClassDetails(data: ClassData.empty(), user: currentUser,),
        '/network': (context) => Network(uid: currentUser.uid),
        '/user-details': (context) => UserDetailsPage(userData: currentUser),
        '/settings': (context) => SettingsPage(),
      },
    );
  }

  @override
  void onLogin(SnapchatUser user) {

  }

  @override
  void onLogout() {

  }
}

class Utils{
  static List<double> grades = [8.5, 9.0, 9.5, 10.0, 10.5, 11.0, 11.5, 12.0];
  static String gradeToString(double grade){
    switch(grade){
      case 8.5: return "rising freshman";
      case 9: return "freshman";
      case 9.5: return "rising sophomore";
      case 10: return "sophomore";
      case 10.5: return "rising junior";
      case 11: return "junior";
      case 11.5: return "rising senior";
      case 12: return "senior";
      case > 12: return "graduate";
      default: return "N/A";
    }
  }
  static String gradeToStringUpper(double grade){
    switch(grade){
      case 8.5: return "Rising Freshman";
      case 9: return "Freshman";
      case 9.5: return "Rising Sophomore";
      case 10: return "Sophomore";
      case 10.5: return "Rising Junior";
      case 11: return "Junior";
      case 11.5: return "Rising Senior";
      case 12: return "Senior";
      case > 12: return "Graduate";
      default: return "N/A";
    }
  }
}