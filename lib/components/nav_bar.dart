import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GNav(
        gap: 8,
        onTabChange: (index){

        },
        padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        tabBackgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.search,
            text: 'Search',
          ),
          GButton(
            icon: Icons.add,
            text: 'New',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
          //GButton(icon: Icons.settings),
        ],
      ),
    );
  }
}
