// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'package:amazon/constants/constants.dart';
import 'package:amazon/view/admin_screens/home/admin_home_screen.dart';
import 'package:amazon/view/user_screens/cart/cart.dart';
import 'package:amazon/view/user_screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../controller/provider/user_data_provider.dart';
import '../../utils/colors.dart';
import 'analatics/admin_analatics_screen.dart';
import 'orders/admin_order_screen.dart';

PersistentTabController controller = PersistentTabController(initialIndex: 0);

class AdminAppScreens extends StatefulWidget {
  static const String routeName = '/Admin-Screens';
  const AdminAppScreens({super.key});

  @override
  State<AdminAppScreens> createState() => _AdminAppScreensState();
}

class _AdminAppScreensState extends State<AdminAppScreens> {
  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens() {
      return [AdminHomeScreen(), AdminAnalaticsScreen(), AdminOrderScreen()];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const FaIcon(FontAwesomeIcons.house),
          activeColorPrimary: greenShade,
          inactiveColorPrimary: black,
        ),
        PersistentBottomNavBarItem(
          icon: const FaIcon(FontAwesomeIcons.chartColumn),
          activeColorPrimary: greenShade,
          inactiveColorPrimary: black,
        ),
        PersistentBottomNavBarItem(
          icon: const FaIcon(FontAwesomeIcons.cartShopping),
          activeColorPrimary: greenShade,
          inactiveColorPrimary: black,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      onItemSelected: (value) {
        log(value.toString());
      },
      navBarHeight: 45,
      backgroundColor: white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
          border: Border(top: BorderSide(color: grey, width: 1))),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.once,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3,
    );
  }
}
