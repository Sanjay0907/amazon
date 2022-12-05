import 'package:amazon/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class CommonFunctions {
  static blankSpaces(BuildContext context, double reqheight, double reqwidth) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * reqheight,
      width: width * reqwidth,
    );
  }

  static showToast({
    required BuildContext context,
    required String text,
    required String description,
    required double givenWidth,
    required double givenHeight,
    required Color toastColor,
  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MotionToast(
      icon: FontAwesomeIcons.check,
      primaryColor: toastColor,
      animationType: AnimationType.fromTop,
      position: MotionToastPosition.top,
      title: Text(
        text,
        style: Theme.of(context).textTheme.headline4!.copyWith(color: black),
      ),
      description: Text(description),
      width: width * givenWidth,
      height: height * givenHeight,
    ).show(context);
  }

  static successToast({
    required BuildContext context,
    required String description,
    required double givenWidth,
    required double givenHeight,
  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MotionToast.success(
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      title: Text(
        'SUCCESS',
        style: Theme.of(context).textTheme.headline4!.copyWith(color: black),
      ),
      description: Text(description),
      width: width * givenWidth,
      height: height * givenHeight,
    ).show(context);
  }

  static errorToast({
    required BuildContext context,
    required String description,
    required double givenWidth,
    required double givenHeight,
  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MotionToast.error(
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      title: Text(
        'Opps!',
        style: Theme.of(context).textTheme.headline4!.copyWith(color: black),
      ),
      description: Text(description),
      width: width * givenWidth,
      height: height * givenHeight,
    ).show(context);
  }

  static warningToast({
    required BuildContext context,
    required String description,
    required double givenWidth,
    required double givenHeight,
  }) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MotionToast.warning(
      animationType: AnimationType.fromLeft,
      position: MotionToastPosition.top,
      title: Text(
        'Warning',
        style: Theme.of(context).textTheme.headline4!.copyWith(color: black),
      ),
      description: Text(description),
      width: width * givenWidth,
      height: height * givenHeight,
    ).show(context);
  }
}
