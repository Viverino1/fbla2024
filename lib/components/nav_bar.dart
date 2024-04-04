import 'package:fbla2024/main.dart';
import 'package:fbla2024/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NavBar extends StatelessWidget {
  final void Function(int index)? onTabChange;
  const NavBar({super.key, this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 10),
      child: GNav(
        gap: 8,
        onTabChange: onTabChange,
        padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        tabBackgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        tabs: const [
          GButton(
            icon: Icons.home_outlined,
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
