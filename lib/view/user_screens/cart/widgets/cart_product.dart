import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../controller/provider/user_data_provider.dart';
import '../../../../controller/services/product_details_services.dart';
import '../../../../model/product_model.dart';
import '../../../../utils/colors.dart';
import '../../product_details/product_details_screen.dart';

class CartProduct extends StatefulWidget {
  const CartProduct({super.key});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final oCcy = NumberFormat("#,##0.00", "en_US");
  navigateToProductDetailsScreen(ProductModel selectedProduct) {
    Navigator.push(
      context,
      PageTransition(
        child: ProductDetailsScreen(
          model: selectedProduct,
        ),
        type: PageTransitionType.rightToLeft,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserDataProvider>().userModel;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return ListView.builder(
        itemCount: user.cart.length,
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          ProductModel currentProduct =
              ProductModel.fromMap(user.cart[index]['product']);

          return InkWell(
            onTap: () => navigateToProductDetailsScreen(currentProduct),
            child: Container(
              height: height * 0.2,
              width: width,
              margin: EdgeInsets.symmetric(
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.15,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: Image(
                              image: NetworkImage(
                                currentProduct.images[0],
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentProduct.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.headline5!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                // StarRating(rating: avgRating),
                                Text(
                                  '₹ ${oCcy.format(currentProduct.price)}',
                                  style: textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Builder(
                                  builder: (context) {
                                    if (currentProduct.price < 499) {
                                      return Text(
                                        'Free shopping onwards ₹ 499',
                                        style: textTheme.headline6,
                                      );
                                    } else {
                                      return Text(
                                        'Eligible for FREE Shipping',
                                        style: textTheme.headline6,
                                      );
                                    }
                                  },
                                ),
                                Text(
                                  'In Stock',
                                  style: textTheme.headline6!.copyWith(
                                    color: teal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: red,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: Colors.black12, width: 1.5)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            ProductDetailsServices.removeFromCart(
                                context: context, model: currentProduct);
                          },
                          child: Container(
                            height: height * 0.03,
                            width: height * 0.03,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: grey400),
                            alignment: Alignment.center,
                            child: const Icon(Icons.remove),
                          ),
                        ),
                        Container(
                            height: height * 0.03,
                            width: width * 0.1,
                            alignment: Alignment.center,
                            child: Text(user.cart[index]['quantity'].toString(),
                                style: textTheme.headline5!
                                    .copyWith(fontWeight: FontWeight.bold))),
                        InkWell(
                          onTap: () {
                            ProductDetailsServices.addToCart(
                              context: context,
                              model: ProductModel.fromMap(
                                user.cart[index]['product'],
                              ),
                            );
                          },
                          child: Container(
                            height: height * 0.03,
                            width: height * 0.03,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: grey400),
                            alignment: Alignment.center,
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
