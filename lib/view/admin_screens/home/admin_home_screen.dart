import 'dart:developer';

import 'package:amazon/constants/common_functions.dart';
import 'package:amazon/controller/provider/admin_products_provider.dart';
import 'package:amazon/controller/provider/success_provider.dart';
import 'package:amazon/controller/services/admin_services.dart';
import 'package:amazon/model/product_model.dart';
import 'package:amazon/view/admin_screens/add_product_screen.dart';
import 'package:amazon/view/auth/auth_screen.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_and_images.dart';
import '../../../utils/colors.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({
    super.key,
  });

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    Future.delayed(const Duration(seconds: 3), () {
      context.read<AdminProductsProvider>().fetchData();
    });

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
        floatingActionButton: OpenContainer(
            transitionDuration: const Duration(milliseconds: 400),
            openBuilder: (context, _) => const AddProductScreen(),
            closedShape: const CircleBorder(),
            closedBuilder: (context, openContainer) => Container(
                  height: height * 0.08,
                  width: height * 0.08,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: blueShade,
                  ),
                  alignment: Alignment.center,
                  child: const FaIcon(FontAwesomeIcons.plus),
                )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.01,
          ),
          child: Builder(
            builder: (context) {
              final adminProductProvider =
                  Provider.of<AdminProductsProvider>(context);

              if (adminProductProvider.isLoading == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return GridView.builder(
                    shrinkWrap: true,
                    itemCount: adminProductProvider.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      ProductModel model = adminProductProvider.products[index];
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.01,
                          vertical: height * 0.005,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: grey,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: height * 0.12,
                              width: width,
                              child: Image.network(
                                model.images[0],
                                // fit: BoxFit.cover,
                              ),
                            ),
                            CommonFunctions.blankSpaces(context, 0.005, 0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    model.name,
                                    maxLines: 2,
                                    style: textTheme.headline5!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    AdminServices.deleteProduct(
                                        context, model.id!);
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.trash,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              }
            },
          ),
        ));
  }
}
