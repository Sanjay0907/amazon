// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:amazon/view/admin_screens/admin_screen.dart';
import 'package:amazon/view/user_screens/user_app_screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../controller/provider/user_data_provider.dart';
import '../controller/services/auth_services.dart';
import 'auth/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      updateUserProvider();
    });
  }

  updateUserProvider() async {
    var response = await AuthServices.getUserData(context);

    if (response != null) {
      Provider.of<UserDataProvider>(context, listen: false)
          .updateUserModel(response);
    }
    (response != null)
        ? (Provider.of<UserDataProvider>(context, listen: false)
                    .userModel
                    .type ==
                'User')
            ? Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: const UserAppScreens(),
                    type: PageTransitionType.rightToLeft),
                (route) => false)
            : Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: const AdminAppScreens(),
                    type: PageTransitionType.rightToLeft),
                (route) => false)
        : Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const AuthScreen(),
                type: PageTransitionType.rightToLeft),
            (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: height * 0.1,
          width: width * 0.9,
          child:
              const Image(image: AssetImage('assets/images/amazon_logo.jpg')),
        ),
      ),
    );
  }
}
