import 'dart:developer';
import 'package:amazon/constants/common_functions.dart';
import 'package:amazon/controller/provider/product_provider.dart';
import 'package:amazon/model/product_model.dart';
import 'package:amazon/view/user_screens/user_app_screens.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_and_images.dart';
import '../../../utils/colors.dart';
import '../product_details/product_details_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.category});
  final String category;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void dispose() {
    super.dispose();
  }

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
          centerTitle: true,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Text(
            widget.category,
            style: textTheme.headline4!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.01),
        child: ListView(
          children: [
            Text(
              'Keep Shopping for ${widget.category}',
              style: textTheme.headline4,
            ),
            CommonFunctions.blankSpaces(context, 0.01, 0),
            SizedBox(
                height: height * 0.22,
                width: width * 0.94,
                child: Builder(builder: (context) {
                  context.read<ProductsProvider>().fetchData(widget.category);
                  final productCheck = context.read<ProductsProvider>();

                  if (productCheck.isLoading == true) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (productCheck.products.isEmpty) {
                    return const Center(
                      child: Text('No Item found'),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: productCheck.products.length,
                        itemBuilder: (context, index) {
                          // log(productsProvider.products.length.toString());
                          ProductModel currentProduct =
                              productCheck.products[index];
                          return InkWell(
                            onTap: () => Navigator.push(
                              context,
                              PageTransition(
                                child:
                                    ProductDetailsScreen(model: currentProduct),
                                type: PageTransitionType.rightToLeft,
                              ),
                            ),
                            child: Container(
                              width: width * 0.4,
                              margin: EdgeInsets.symmetric(
                                horizontal: width * 0.01,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: grey,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image(
                                        image: NetworkImage(
                                          currentProduct.images[0],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        currentProduct.name,
                                        textAlign: TextAlign.center,
                                        style: textTheme.headline6!.copyWith(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                })
                // child: Consumer<ProductsProvider>(
                //     builder: (context, productsProvider, child) {
                //   if (productsProvider.isLoading == true) {
                //     return const Center(
                //       child: CircularProgressIndicator(),
                //     );
                //   } else if (productsProvider.products.isEmpty) {
                //     return const Center(
                //       child: Text('No Items'),
                //     );
                //   } else {
                //     return ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         shrinkWrap: true,
                //         itemCount: productsProvider.products.length,
                //         itemBuilder: (context, index) {
                //           log(productsProvider.products.length.toString());
                //           return Container(
                //             width: width * 0.4,
                //             margin: EdgeInsets.symmetric(
                //               horizontal: width * 0.01,
                //             ),
                //             color: red,
                //           );
                //         });
                //   }
                // }),
                ),
          ],
        ),
      ),
    );
  }
}
