import 'package:fbla2024/app_colors.dart';
import 'package:fbla2024/pages/home_page.dart';
import 'package:fbla2024/pages/portfolio_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
        '/portfolio': (context) => const PortfolioPage()
      },
    );
  }
}
