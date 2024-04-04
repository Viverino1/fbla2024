import 'package:fbla2024/app_colors.dart';
import 'package:fbla2024/pages/feed_page.dart';
import 'package:fbla2024/pages/home_page.dart';
import 'package:fbla2024/pages/portfolio_page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.ios,
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
        '/home': (context) => const FeedPage(),
        '/portfolio': (context) => const PortfolioPage()
      },
    );
  }
}
