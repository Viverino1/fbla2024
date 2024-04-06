import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbla2024/app_colors.dart';
import 'package:fbla2024/pages/comment_section.dart';
import 'package:fbla2024/pages/home_page.dart';
import 'package:fbla2024/services/firebase/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

const backgroundColor = Color.fromARGB(255, 34, 34, 34);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/home': (context) => const HomePage(),
        '/view-profile': (context) => const Scaffold(),
        '/comment-section': (context) => const CommentSection(postID: ""),
      },
    );
  }
}