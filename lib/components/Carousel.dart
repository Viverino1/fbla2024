import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  final List<String> urls;
  const Carousel({super.key, required this.urls});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: List.generate(urls.length, (index) => MyImage(url: urls[index])),
      options: CarouselOptions(
        autoPlay: false, // Enable auto-play
        enlargeCenterPage: true, // Increase the size of the center item
        enableInfiniteScroll: true, // Enable infinite scroll
        onPageChanged: (index, reason) {
          // Optional callback when the page changes
          // You can use it to update any additional UI components
        },
      ),
    );
  }
}

class MyImage extends StatelessWidget {
  final String url;
  const MyImage({super.key, required this.url});

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.5 / 1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: FractionalOffset.center,
                  image: NetworkImage(url),
                )
            ),
          ),
        ),
      ),
    );
  }
}
