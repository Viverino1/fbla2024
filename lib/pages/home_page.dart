import 'package:fbla2024/pages/feed_page.dart';
import 'package:fbla2024/pages/portfolio_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  final pages = [
    const FeedPage(),
    const Scaffold(),
    const Scaffold(),
    const PortfolioPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: NavBar(
        onTabChange: (index) => setState(() {
          pageIndex = index;
        }),
      ),
    );
  }
}
