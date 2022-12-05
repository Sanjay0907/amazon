import 'package:amazon/constants/common_functions.dart';
import 'package:amazon/utils/colors.dart';
import 'package:amazon/view/user_screens/profile/widgets/top_buttons.dart';
import 'package:amazon/view/user_screens/profile/widgets/hello_user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants/color_and_images.dart';
import 'widgets/your_orders_heading.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Container(
              alignment: Alignment.topLeft,
              child: Image(
                  image: const AssetImage(
                    'assets/images/amazon_in.png',
                  ),
                  width: 120,
                  height: 40,
                  color: black),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.bell),
              ),
              IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
              ),
            ],
          ),
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: ListView(
            children: [
              const HelloUser(),
              CommonFunctions.blankSpaces(context, 0.01, 0),
              const TopButton(),
              CommonFunctions.blankSpaces(context, 0.02, 0),
              const YourOrdersHeading(),
              CommonFunctions.blankSpaces(context, 0.01, 0),
              const Orders()
            ],
          ),
        ));
  }
}

class Orders extends StatelessWidget {
  const Orders({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List myOrders = [
      'https://images.unsplash.com/photo-1531297484001-80022131f5a1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=820&q=80',
      'https://images.unsplash.com/photo-1531297484001-80022131f5a1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=820&q=80',
      'https://images.unsplash.com/photo-1531297484001-80022131f5a1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=820&q=80',
      'https://images.unsplash.com/photo-1531297484001-80022131f5a1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=820&q=80',
      'https://images.unsplash.com/photo-1531297484001-80022131f5a1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=820&q=80',
      'https://images.unsplash.com/photo-1531297484001-80022131f5a1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=820&q=80',
    ];
    return SizedBox(
      height: height * 0.2,
      width: width,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: myOrders.length,
          itemBuilder: (context, index) {
            return Container(
              height: height * 0.2,
              width: height * 0.2,
              padding: const EdgeInsets.all(5),
              margin: index == 0
                  ? EdgeInsets.only(left: width * 0.03, right: width * 0.01)
                  : (index == (myOrders.length - 1))
                      ? EdgeInsets.only(right: width * 0.03, left: width * 0.01)
                      : EdgeInsets.symmetric(horizontal: width * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: GlobalVariables.greyBackgroundCOlor,
                  width: 2,
                ),
              ),
              child: Image.network(
                myOrders[index],
              ),
            );
          }),
    );
  }
}
