import 'package:amazon/view/admin_screens/admin_screen.dart';
import 'package:amazon/view/auth/auth_screen.dart';
import 'package:amazon/view/error_screen.dart';
import 'package:amazon/view/user_screens/user_app_screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return PageTransition(
        settings: routeSettings,
        child: const AuthScreen(),
        type: PageTransitionType.rightToLeft,
      );
    case UserAppScreens.routeName:
      return PageTransition(
        settings: routeSettings,
        child: const UserAppScreens(),
        type: PageTransitionType.rightToLeft,
      );
    case AdminAppScreens.routeName:
      return PageTransition(
        settings: routeSettings,
        child: const AdminAppScreens(),
        type: PageTransitionType.rightToLeft,
      );

    default:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const ErrorScreen());
  }
}
