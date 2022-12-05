// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:amazon/constants/constants.dart';
import 'package:amazon/controller/provider/product_provider.dart';
import 'package:amazon/view/user_screens/categories/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../constants/color_and_images.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({
    Key? key,
  }) : super(key: key);

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.08,
      width: width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariables.categoryImages.length,
        itemExtent: 78,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              await context.read<ProductsProvider>().setToDefault();
              await context
                  .read<ProductsProvider>()
                  .fetchData(GlobalVariables.categoryImages[index]['title']!);
              Navigator.push(
                context,
                PageTransition(
                  child: CategoryScreen(
                      category: GlobalVariables.categoryImages[index]
                          ['title']!),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  GlobalVariables.categoryImages[index]['title']!,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
