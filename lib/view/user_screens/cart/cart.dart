// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:amazon/constants/common_functions.dart';
import 'package:amazon/view/auth/auth_screen.dart';
import 'package:amazon/view/user_screens/cart/widgets/cart_product.dart';
import 'package:amazon/view/user_screens/cart/widgets/cart_subtotal.dart';
import 'package:amazon/view/user_screens/home/widgets/address_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_and_images.dart';
import '../../../controller/provider/search_provider.dart';
import '../../../controller/provider/user_data_provider.dart';
import '../../../model/product_model.dart';
import '../../../utils/colors.dart';
import '../address/address_screen.dart';
import '../product_details/product_details_screen.dart';
import '../search/search_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
  navigateToAddressScreen() {
    Navigator.push(
      context,
      PageTransition(
        child: const AddressScreen(),
        type: PageTransitionType.rightToLeft,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserDataProvider>().userModel;
    int quantity = 0;
    user.cart.map((e) => quantity += e['quantity'] as int).toList();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    log(user.cart.toString());
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AddressBar(),
              const CartSubtotal(),
              CommonFunctions.blankSpaces(context, 0.02, 0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: CommonButton(
                    width: width,
                    height: height,
                    textTheme: textTheme,
                    onPressed: () {
                      navigateToAddressScreen();
                    },
                    text: 'Proceed to Buy ($quantity items)'),
              ),
              CommonFunctions.blankSpaces(context, 0.03, 0),
              const Divider(
                thickness: 2,
              ),
              const CartProduct()
            ],
          ),
        ));
  }
}
