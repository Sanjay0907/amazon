import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  static const String routeName = 'error-screen';
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Opps! you ran into a error screen',
        ),
      ),
    );
  }
}
