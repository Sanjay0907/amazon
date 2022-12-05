// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:amazon/constants/color_and_images.dart';
import 'package:amazon/constants/common_functions.dart';
import 'package:amazon/controller/provider/product_provider.dart';
import 'package:amazon/controller/provider/search_provider.dart';
import 'package:amazon/utils/colors.dart';
import 'package:amazon/view/user_screens/home/widgets/deal_of_the_day.dart';
import 'package:amazon/view/user_screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'widgets/address_bar.dart';
import 'widgets/carousel_image.dart';
import 'widgets/top_categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  navigateToSearchScreen(String searchQuery) async {
    await context.read<SearchProvider>().setToDefault();
    await context.read<SearchProvider>().fetchSearchProduct(searchQuery);
    Navigator.push(
      context,
      PageTransition(
        child: SearchScreen(searchCategory: searchQuery),
        type: PageTransitionType.rightToLeft,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    Future.delayed(Duration.zero, () {
      log('in Home');
    });
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.075),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: SizedBox(
            height: height * 0.055,
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(7),
              child: TextFormField(
                controller: searchController,
                onFieldSubmitted: navigateToSearchScreen,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {
                      navigateToSearchScreen(searchController.text.trim());
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 23,
                      color: black,
                    ),
                  ),
                  filled: true,
                  fillColor: white,
                  contentPadding: const EdgeInsets.only(top: 10),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                      borderSide: BorderSide.none),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black38,
                      width: 1,
                    ),
                  ),
                  hintText: 'Search Amazon.in',
                  hintStyle: textTheme.headline5!
                      .copyWith(fontWeight: FontWeight.w500, color: grey),
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.microphone))
          ],
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: ListView(
          children: [
            const AddressBar(),
            CommonFunctions.blankSpaces(context, 0.01, 0),
            const TopCategories(),
            const HomeCarousel(),
            CommonFunctions.blankSpaces(context, 0.01, 0),
            const DealOfTheDay(),
          ],
        ),
      ),
    );
  }
}
