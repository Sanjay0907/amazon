import 'package:amazon/utils/colors.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.obscureText,
    required this.textInputType,
    this.maxLines = 1,
  });
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final bool obscureText;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: textInputType,
      controller: textEditingController,
      maxLines: maxLines,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter $hintText';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: grey,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
