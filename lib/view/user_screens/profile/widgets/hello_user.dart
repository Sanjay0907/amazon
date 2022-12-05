import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/color_and_images.dart';
import '../../../../controller/provider/user_data_provider.dart';
import '../../../../model/user_model.dart';
import '../../../../utils/colors.dart';

class HelloUser extends StatelessWidget {
  const HelloUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    UserModel currentUserData =
        Provider.of<UserDataProvider>(context).userModel;
    return Container(
      height: height * 0.05,
      width: width,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: 'Hello, ',
            style: textTheme.headline3!.copyWith(color: black)),
        TextSpan(
            text: currentUserData.name.split(' ')[0],
            style: textTheme.headline3!.copyWith(
              color: black,
              fontWeight: FontWeight.bold,
            )),
      ])),
    );
  }
}
