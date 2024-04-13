// ignore_for_file: prefer_const_constructors

import 'package:fbla2024/components/loading.dart';
import 'package:fbla2024/services/firebase/firestore/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import '../main.dart';

class AddClass extends StatefulWidget {
  const AddClass({super.key, required this.grade});
  final double grade;

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  String _search = "";

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
                "Add Class",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(80)
                ),
                child: GestureDetector(
                  onTap: (){
                    ClassData classData = ClassData.empty();

                    void isApPopup(){
                      showDialog(context: context, builder: (context) => AlertDialog(
                        title: Text("Add Class", style: Theme.of(context).textTheme.titleMedium,),
                        content: Text("Is ${classData.name} an Advanced Placement (AP) course?", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14),),
                        actions: [
                          TextButton(onPressed: () {
                            classData.isAp = true;
                            FirestoreService.addPublicClass(classData);
                            Navigator.pop(context);
                            setState(() {});
                          }, child: Text("Yes", style: Theme.of(context).textTheme.titleMedium,),),
                          TextButton(onPressed: () {
                            classData.isAp = false;
                            FirestoreService.addPublicClass(classData);
                            Navigator.pop(context);
                            setState(() {});
                          }, child: Text("No", style: Theme.of(context).textTheme.titleMedium,),),
                          TextButton(onPressed: () => {
                            Navigator.pop(context)
                          }, child: Text("Cancel", style: Theme.of(context).textTheme.titleMedium,),),
                        ],
                      ));
                    }

                    showDialog(context: context, builder: (context) => AlertDialog(
                      title: Text("Enter New Class Name", style: Theme.of(context).textTheme.titleMedium,),
                      content: TextField(
                        onChanged: (e) => classData.name = e,
                        onSubmitted: (e) => {
                          Navigator.pop(context),
                          isApPopup()
                        },
                      ),
                      actions: [
                        TextButton(onPressed: () => {Navigator.pop(context)}, child: Text("Cancel", style: Theme.of(context).textTheme.titleMedium,),),
                        TextButton(onPressed: () {
                          isApPopup();
                        }, child: Text("Confirm", style: Theme.of(context).textTheme.titleMedium,),),
                      ],
                    ));
                  },
                    child: Icon(Icons.add, size: 28, color: Theme.of(context).colorScheme.secondary,)
                ),
              )
            ],
          ),
        ),
        toolbarHeight: 40,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: FutureBuilder<List<ClassData>>(
        future: FirestoreService.getPublicClasses(),
        builder: (BuildContext context, AsyncSnapshot<List<ClassData>> snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16,),
                SizedBox(
                  height: 40,
                  child: TextField(
                    onChanged: (value){
                      setState(() {
                        _search = value;
                      });
                    },
                    cursorColor: Theme
                        .of(context)
                        .colorScheme
                        .secondary,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(height: 1),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none
                      ),
                      filled: true,
                      hintStyle: GoogleFonts.quicksand(
                          color: Theme
                              .of(context)
                              .colorScheme
                              .secondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 16

                      ),
                      hintText: "Search",
                      fillColor: Theme
                          .of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.2),
                    ),
                  )
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Column(
                        children: _search.isEmpty? [
                          Text("Start typing to find a class or add a new one with the button in the top right!",
                              style: Theme.of(context).textTheme.titleSmall)
                        ] : snapshot.data?.where((element) => element.name.toLowerCase().contains(_search.toLowerCase())).toList().map((e) => GestureDetector(
                          onTap: (){
                            ClassData classData = ClassData.empty();
                            classData.id = e.id;
                            classData.name = e.name;
                            classData.isAp = e.isAp;
                            classData.grade = widget.grade;

                            void classGradePopup(){
                              showDialog(context: context, builder: (context) => AlertDialog(
                                title: Text("Enter Class Grade", style: Theme.of(context).textTheme.titleMedium,),
                                content: TextField(
                                  keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp("^([0-9]{0,3})([\\.]{1}[0-9]{0,2})?")),
                                  ],
                                  onChanged: (e) => classData.score = double.parse(e),
                                ),
                                actions: [
                                  TextButton(onPressed: () => {Navigator.pop(context)}, child: Text("Cancel", style: Theme.of(context).textTheme.titleMedium,),),
                                  TextButton(onPressed: () {
                                    FirestoreService.addClass(classData);
                                    Navigator.pop(context);
                                  }, child: Text("Confirm", style: Theme.of(context).textTheme.titleMedium,),),
                                ],
                              ));
                            }

                            void isHonorsPopup(){
                              showDialog(context: context, builder: (context) => AlertDialog(
                                title: Text("Add Class", style: Theme.of(context).textTheme.titleMedium,),
                                content: Text("Is ${e.name} an honors class at ${currentUser.school}?", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14),),
                                actions: [
                                  TextButton(onPressed: () {
                                    classData.isHonors = true;
                                    Navigator.pop(context);
                                    classGradePopup();
                                  }, child: Text("Yes", style: Theme.of(context).textTheme.titleMedium,),),
                                  TextButton(onPressed: () {
                                    classData.isHonors = false;
                                    Navigator.pop(context);
                                    classGradePopup();
                                  }, child: Text("No", style: Theme.of(context).textTheme.titleMedium,),),
                                  TextButton(onPressed: () => {
                                    Navigator.pop(context)
                                  }, child: Text("Cancel", style: Theme.of(context).textTheme.titleMedium,),),
                                ],
                              ));
                            }

                            classData.grade % 1 == 0? showDialog(context: context, builder: (context) => AlertDialog(
                              title: Text("Add Class", style: Theme.of(context).textTheme.titleMedium,),
                              content: Text("Which semester did you take ${e.name}?", style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14),),
                              actions: [
                                TextButton(onPressed: (){
                                  classData.sem = 1;
                                  Navigator.pop(context);
                                  isHonorsPopup();
                                }, child: Text("Sem 1", style: Theme.of(context).textTheme.titleMedium,)),
                                TextButton(onPressed: (){
                                  classData.sem = 2;
                                  Navigator.pop(context);
                                  isHonorsPopup();
                                }, child: Text("Sem 2", style: Theme.of(context).textTheme.titleMedium,)),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("Cancel", style: Theme.of(context).textTheme.titleMedium,)),
                              ],
                            )) : isHonorsPopup();
                          },
                          child: Container(
                            color: Theme.of(context).colorScheme.background,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    e.name,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                                  ),
                                  Spacer(),
                                  Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.secondary)
                                ],
                              ),
                            ),
                          ),
                        )).toList()?? [
                          Loading("Classes")
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
          // Padding(
        }
        ),
      ),
    );
  }
}
