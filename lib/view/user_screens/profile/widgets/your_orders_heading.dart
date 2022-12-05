import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../constants/color_and_images.dart';
import '../../../../constants/common_functions.dart';

class YourOrdersHeading extends StatelessWidget {
  const YourOrdersHeading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Your Orders',
            style: textTheme.headline4!.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          InkWell(
            onTap: () {
              log('See all Orders');
            },
            child: Text(
              'See all',
              style: textTheme.headline5!.copyWith(
                fontWeight: FontWeight.normal,
                color: GlobalVariables.selectedNavBarColor,
              ),
            ),
          ),
          CommonFunctions.blankSpaces(context, 0, 0.01),
        ],
      ),
    );
  }
}
