// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fbla2024/components/loading.dart';
import 'package:fbla2024/main.dart';
import 'package:fbla2024/pages/add_class.dart';
import 'package:fbla2024/pages/class_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../services/firebase/auth_service.dart';
import '../services/firebase/firestore/db.dart';

class Academics extends StatelessWidget {
  const Academics({super.key, required this.user});
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
                "Your Academics",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GridElement(title: "Pre-ACT", value: user.preact),
                      GridElement(title: "Grade", value: user.grade.toInt()),
                      GridElement(title: "ACT", value: user.act),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GridElement(title: "Pre-SAT", value: user.psat),
                      GridElement(title: "GPA", value: 3.8),
                      GridElement(title: "SAT", value: user.sat),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("All Classes", style: Theme.of(context).textTheme.titleLarge,),
            ),
            FutureBuilder<List<ClassData>>(
              future: FirestoreService.getUserClasses(user.uid),
              builder: (BuildContext context, AsyncSnapshot<List<ClassData>> snapshot){
                final data =  snapshot.data;



                if(data == null){
                  return Loading("Classes");
                }

                return Column(
                  children: Utils.grades.map((e) =>
                      ClassesElement(
                        grade: e,
                        classes: data.where((element) => element.grade == e).toList(),
                        user: user,
                      )
                  ).toList(),
                );
              }
            ),
            SizedBox(height: 48,)
          ],
        ),
      ),
    );
  }
}

class GridElement extends StatelessWidget {
  const GridElement({super.key, required this.title, required this.value});
  final String title;
  final value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 82,
        width: 82,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(64),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value == -1? "N/A" : (value is int? value.toInt().toString() : value.toString()), style: Theme.of(context).textTheme.titleLarge,),
            Text(title, style: Theme.of(context).textTheme.titleSmall,)
          ],
        ),
      ),
    );
  }
}

class ClassesElement extends StatefulWidget {
  const ClassesElement({super.key, required this.grade, required this.classes, required this.user});
  final double grade;
  final List<ClassData> classes;
  final UserData user;

  @override
  State<ClassesElement> createState() => _ClassesElementState();
}

class _ClassesElementState extends State<ClassesElement> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(.25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        Text(Utils.gradeToStringUpper(widget.grade), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.secondary),),
                        Spacer(),
                        GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddClass(grade: widget.grade))
                            )
                          },
                            child: Icon(Icons.add, color: Theme.of(context).colorScheme.secondary,)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _isExpanded? widget.classes.map((e) => ClassChip(
                  data: e,
                  user: widget.user,
                  delete: (String s){
                    widget.classes.removeWhere((element) => element.id == s);
                    print(widget.classes);
                    setState(() {});
                  },
                )).toList() : [],
              )
            ],
          ),
        )
      ],
    );
  }
}

class ClassChip extends StatelessWidget {
  const ClassChip({super.key, required this.data, required this.user, required this.delete});
  final ClassData data;
  final UserData user;
  final Function(String s) delete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ClassDetails(data: data, user: user,))
        )
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(data.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    delete(data.id);
                    data.delete();
                  },
                    child: Icon(Icons.delete, size: 18, color: Theme.of(context).colorScheme.secondary,)
                ),
                // SizedBox(width: 8,),
                // Icon(Icons.chevron_right, size: 18, color: Theme.of(context).colorScheme.secondary,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
