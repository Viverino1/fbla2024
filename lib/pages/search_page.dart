import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
                "Search",
                style: Theme.of(context).textTheme.titleLarge,
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
          child: Column(
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
            ],
          ),
        ),
      ),
    );
  }
}
