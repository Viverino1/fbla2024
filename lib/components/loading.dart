import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  String text = "";
  Loading(String s, {super.key}){
    text = s;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            LoadingAnimationWidget.threeRotatingDots(color: Theme.of(context).colorScheme.primary.withOpacity(0.5), size: 50,),
            SizedBox(height: 8,),
            Text("Loading " + text + "...", style: Theme.of(context).textTheme.titleMedium,)
          ],
        )
    );
  }
}
