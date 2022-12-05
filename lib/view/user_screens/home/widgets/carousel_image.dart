import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../constants/color_and_images.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.23,
      width: width,
      child: CarouselSlider(
        items: GlobalVariables.carouselImages.map((i) {
          return Builder(
            builder: (context) {
              return Image.network(
                i,
                fit: BoxFit.cover,
                height: height * 0.15,
                width: width,
              );
            },
          );
        }).toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: height * 0.23,
          autoPlay: true,
        ),
      ),
    );
  }
}
