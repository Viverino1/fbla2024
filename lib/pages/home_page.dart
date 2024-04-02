import 'package:carousel_slider/carousel_slider.dart';
import 'package:fbla2024/components/project_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/Carousel.dart';
import '../components/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60),
            ProjectPost(
                urls: [
                  "https://t3.ftcdn.net/jpg/03/15/34/90/360_F_315349043_6ohfFyx37AFusCKZtGQtJR0jqUxhb25Y.jpg",
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8fFYdAr0gsHFnjVe6zxn8tZDjCY8mKGw78ttP2NYmUvmL-mP5-0C8nVu0pwprLZ037eo&usqp=CAU",
                  "https://burst.shopifycdn.com/photos/hiker-looks-up-at-vertical-mountain-peaks.jpg?width=1000&format=pjpg&exif=0&iptc=0"
                ]
            )
          ],
        ),
      )
    );
  }
}
