// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hint,
    required this.controller,
    required this.requiredheight,
    required this.requiredwidth,
    required this.borderColor,
    required this.borderWidth,
    required this.obscureText,
    this.suffixIcon = const SizedBox(
      height: 0,
      width: 0,
    ),
  }) : super(key: key);
  final TextEditingController controller;
  final String hint;
  final double requiredheight;
  final double requiredwidth;
  final Color borderColor;
  final double borderWidth;
  final Widget suffixIcon;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: requiredheight,
      width: requiredwidth,
      alignment: Alignment.center,
      // margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          )),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        onChanged: (v) {},
        textAlign: TextAlign.left,
        // controller: emailPasswordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: obscureText,
        cursorColor: black,
        style: Theme.of(context).textTheme.headline5!.copyWith(color: black),
        decoration: InputDecoration(
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
          suffixIcon: suffixIcon,
          hintText: hint,
          hintStyle: TextStyle(
            color: grey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
