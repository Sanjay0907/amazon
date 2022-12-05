import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../constants/common_functions.dart';
import 'account_btn_widget.dart';

class TopButton extends StatelessWidget {
  const TopButton({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: height * 0.053,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Row(
            children: [
              AccountButtonWidget(
                onTap: () {
                  log('Pressed');
                },
                buttonText: 'My Orders',
              ),
              CommonFunctions.blankSpaces(context, 0, 0.03),
              AccountButtonWidget(
                onTap: () {
                  log('Pressed');
                },
                buttonText: 'Turn Seller',
              ),
            ],
          ),
        ),
        CommonFunctions.blankSpaces(context, 0.01, 0),
        Container(
          height: height * 0.053,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Row(
            children: [
              AccountButtonWidget(
                onTap: () {
                  log('Pressed');
                },
                buttonText: 'Log Out',
              ),
              CommonFunctions.blankSpaces(context, 0, 0.03),
              AccountButtonWidget(
                onTap: () {
                  log('Pressed');
                },
                buttonText: 'Your Wish List',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
