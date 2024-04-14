import 'package:fbla2024/components/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../services/firebase/auth_service.dart';
import '../services/firebase/firestore/db.dart';
import '../services/gemini/gemini.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({super.key, required this.userData});
  final UserData userData;

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
                "User Details",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        toolbarHeight: 40,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: FutureBuilder<String?>(
                      future: Gemini.sendMessage("Please give me two very small paragraphs of description about the following person using only the following information and don't talk about extracurriculars. Name: ${userData.fullName}. School: ${userData.school}. GPA: ${userData.gpa}. ACT: ${userData.act}. Pre-ACT: ${userData.preact}. SAT: ${userData.sat}. PSAT: ${userData.psat}. Grade: ${Utils.gradeToStringUpper(userData.grade)}. Graduation Year: ${userData.gradYear}."),
                      builder: (BuildContext context, AsyncSnapshot<String?> snapshot){
                        String? text = snapshot.data;
                        if(text != null){
                          return Text(text, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14, height: 1.75),);
                        }else{
                          return Loading("response from Gemini AI");
                        }
                      }
                  ),
                ),
              )
            ]
          ),
        )
      ),
    );
  }
}
