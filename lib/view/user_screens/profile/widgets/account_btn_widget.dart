import 'package:flutter/material.dart';

import '../../../../constants/color_and_images.dart';
import '../../../../utils/colors.dart';

class AccountButtonWidget extends StatelessWidget {
  const AccountButtonWidget(
      {Key? key, required this.buttonText, required this.onTap})
      : super(key: key);

  final VoidCallback onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: GlobalVariables.greyBackgroundCOlor,
            border:
                Border.all(color: Colors.black12.withOpacity(0.03), width: 2),
          ),
          child: Text(
            buttonText,
            style: textTheme.headline5!.copyWith(color: black),
          ),
        ),
      ),
    );
  }
}
