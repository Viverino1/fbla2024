// ignore_for_file: prefer_const_constructors

import 'package:fbla2024/components/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../services/firebase/firestore/db.dart';
import '../services/gemini/gemini.dart';

class ClassDetails extends StatelessWidget {
  const ClassDetails({super.key, required this.data, required this.user});
  final ClassData data;
  final UserData user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Text(
                "Class Details",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24,),
              Row(
                children: const [
                  Chip(text: "AP",),
                  Chip(text: "Weighted",),
                ],
              ),
              SizedBox(height: 8,),
              Text(data.name, style: Theme.of(context).textTheme.titleLarge,),
              SizedBox(height: 24,),
              Text("Details", style: Theme.of(context).textTheme.titleMedium,),
              Text(
                  "${user.fullName} took ${data.name} as a ${Utils.gradeToString(user.grade)} and earned a score of ${data.score}% in the class.",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14, height: 1.75),
              ),
              SizedBox(height: 24,),
              Row(
                children: [
                  Text("Course Description", style: Theme.of(context).textTheme.titleMedium,),
                  SizedBox(width: 8,),
                  Chip(text: "AI Generated")
                ],
              ),

              CourseDescriptionText(classData: data, userData: user,)
            ],
          ),
        ),
      ),
    );
  }
}

class Chip extends StatelessWidget {
  const Chip({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(text, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),),
          ),
        ),
        SizedBox(width: 8,),
      ],
    );
  }
}

class CourseDescriptionText extends StatelessWidget {
  const CourseDescriptionText({super.key, required this.classData, required this.userData});
  final ClassData classData;
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: Gemini.sendMessage("Please write me a 50 word description about the high school course " + classData.name + " at " + userData.school),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot){
          String? text = snapshot.data;
          if(text != null){
            return Text(text, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14, height: 1.75),);
          }else{
            return Loading("Response");
          }
        }
    );
  }
}

