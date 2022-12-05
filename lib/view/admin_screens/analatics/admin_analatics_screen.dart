import 'package:flutter/material.dart';

import '../../../constants/color_and_images.dart';
import '../../../utils/colors.dart';

class AdminAnalaticsScreen extends StatelessWidget {
  const AdminAnalaticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Admin',
                style: textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Text('Admin Analatics screen'),
      ),
    );
  }
}
