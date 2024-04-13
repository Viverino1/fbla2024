// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:fbla2024/services/firebase/firestore/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_input/image_input.dart';
import 'package:image_input/widget/image_input.dart';

class NewPost extends StatelessWidget {
  NewPost({super.key});

  List<XFile> images = [];
  final PostData postData = PostData.empty();

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
                "New Post",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Spacer(),
              GestureDetector(
                onTap: () => FirestoreService.createPost(postData),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(80)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    child: Text("Publish", style: Theme.of(context).textTheme.titleMedium,),
                  )
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 40,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16,),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      onChanged: (e) => postData.title = e,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none
                        ),
                        filled: true,
                        hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),
                        hintText: "Title",
                        fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DropDown(onChange: (e) => postData.type = e,),
                  ),
                  SizedBox(height: 16,),
                  ImagePicker(onChange: (e) => postData.urls = e,),
                  SizedBox(height: 16,),
                  SizedBox(
                    height: 256,
                    child: TextField(
                      onChanged: (e) => postData.description = e,
                      maxLines: 9999999,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none
                        ),
                        filled: true,
                        hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16),
                        hintText: "Description",
                        fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImagePicker extends StatefulWidget {
  const ImagePicker({super.key, required this.onChange});
  final void Function(List<String> urls) onChange;

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  final List<XFile> _images = [];

  @override
  Widget build(BuildContext context) {
    return ImageInput(
      allowEdit: true,
      allowMaxImage: 5,
      initialImages: _images,
      imageContainerDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
        borderRadius: BorderRadius.circular(10),
      ),
      addImageContainerDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
        borderRadius: BorderRadius.circular(10),
      ),

      onImageSelected: (image, index) {
        setState(() {
          _images.add(image);
          widget.onChange(_images.map((e) => e.path).toList());
        });
      },
      onImageRemoved: (image, index) {
        setState(() {
          _images.removeAt(index);
          widget.onChange(_images.map((e) => e.path).toList());
        });
      },
    );
  }
}

class DropDown extends StatelessWidget {
  const DropDown({super.key, required this.onChange});
  final void Function(String s) onChange;

  @override
  Widget build(BuildContext context) {
    FocusNode searchFocusNode = FocusNode();
    FocusNode textFieldFocusNode = FocusNode();

    return DropDownTextField(
      clearOption: false,
      textFieldFocusNode: textFieldFocusNode,
      searchFocusNode: searchFocusNode,
      // searchAutofocus: true,
      dropDownItemCount: 3,
      dropdownColor: Theme.of(context).colorScheme.background,
      searchShowCursor: false,
      enableSearch: true,
      searchKeyboardType: TextInputType.text,
      dropDownList: const [
        DropDownValueModel(name: 'Competition', value: "Competition"),
        DropDownValueModel(name: 'Athletic', value: "Athletic"),
        DropDownValueModel(name: 'Extracurricular', value: "Extracurricular"),
        DropDownValueModel(name: 'Volunteer', value: "Volunteer"),
        DropDownValueModel(name: 'Performing Arts', value: "Performing Arts"),
      ],
      onChanged: (val) {
        DropDownValueModel val2 =  val;
        onChange(val2.value);
      },
    );
  }
}
