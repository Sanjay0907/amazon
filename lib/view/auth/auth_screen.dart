import 'dart:developer';
import 'package:amazon/constants/color_and_images.dart';
import 'package:amazon/constants/common_functions.dart';
import 'package:amazon/controller/services/auth_services.dart';
import 'package:amazon/utils/colors.dart';
import 'package:amazon/view/widgets/common_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../constants/enum.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = 'auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final signUpFormKey = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    mailController.dispose();
    passwordController.dispose();
  }

  void signupUser() {
    AuthServices.signup(
      context: context,
      email: mailController.text,
      password: passwordController.text,
      name: nameController.text,
    );
  }

  void signInUser() {
    AuthServices.signin(
      context: context,
      email: mailController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'welcome',
              style: textTheme.headline3!.copyWith(
                color: black,
              ),
            ),
            ListTile(
              tileColor: _auth == Auth.signup ? white : transparent,
              leading: Radio(
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
                activeColor: GlobalVariables.secondaryColor,
              ),
              title: Text(
                'Create Account',
                style: textTheme.headline5!
                    .copyWith(color: black, fontWeight: FontWeight.bold),
              ),
            ),
            if (_auth == Auth.signup)
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02, vertical: height * 0.01),
                decoration: BoxDecoration(
                  color: white,
                ),
                child: Form(
                  key: signUpFormKey,
                  child: Column(
                    children: [
                      CommonTextField(
                        textEditingController: nameController,
                        hintText: 'Name',
                        obscureText: false,
                        textInputType: TextInputType.name,
                      ),
                      CommonFunctions.blankSpaces(context, 0.01, 0),
                      CommonTextField(
                        textEditingController: mailController,
                        hintText: 'Email',
                        obscureText: false,
                        textInputType: TextInputType.emailAddress,
                      ),
                      CommonFunctions.blankSpaces(context, 0.01, 0),
                      CommonTextField(
                        textEditingController: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        textInputType: TextInputType.visiblePassword,
                      ),
                      CommonFunctions.blankSpaces(context, 0.03, 0),
                      CommonButton(
                        width: width,
                        height: height,
                        textTheme: textTheme,
                        text: 'Sign up',
                        onPressed: () {
                          if (signUpFormKey.currentState!.validate()) {
                            signupUser();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ListTile(
              tileColor: _auth == Auth.signin ? white : transparent,
              leading: Radio(
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
                activeColor: GlobalVariables.secondaryColor,
              ),
              title: Text(
                'Sign in',
                style: textTheme.headline5!
                    .copyWith(color: black, fontWeight: FontWeight.bold),
              ),
            ),
            if (_auth == Auth.signin)
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02, vertical: height * 0.01),
                decoration: BoxDecoration(
                  color: white,
                ),
                child: Form(
                  key: signInFormKey,
                  child: Column(
                    children: [
                      CommonTextField(
                        textEditingController: mailController,
                        hintText: 'Email',
                        obscureText: false,
                        textInputType: TextInputType.emailAddress,
                      ),
                      CommonFunctions.blankSpaces(context, 0.01, 0),
                      CommonTextField(
                        textEditingController: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        textInputType: TextInputType.visiblePassword,
                      ),
                      CommonFunctions.blankSpaces(context, 0.03, 0),
                      CommonButton(
                        width: width,
                        height: height,
                        textTheme: textTheme,
                        text: 'Sign in',
                        onPressed: () {
                          log('pressed');
                          if (signInFormKey.currentState!.validate()) {
                            signInUser();
                            log('inside');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.width,
    required this.height,
    required this.textTheme,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final double width;
  final double height;
  final TextTheme textTheme;
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(minimumSize: Size(width, height * 0.07)),
      child: Text(
        text,
        style: textTheme.headline5!
            .copyWith(color: white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
