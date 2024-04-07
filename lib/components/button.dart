import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  final double? iconSize;
  const Button({super.key, required this.icon, required this.text, this.onTap, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 130,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: iconSize?? 16, color: Theme.of(context).colorScheme.background,),
            SizedBox(width: 8,),
            Text(text, style: GoogleFonts.quicksand(fontSize: 14, color: Theme.of(context).colorScheme.background, fontWeight: FontWeight.w700), softWrap: true,),
          ],
        ),
      ),
    );
  }
}
