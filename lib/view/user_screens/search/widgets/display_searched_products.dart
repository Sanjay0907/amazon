import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../controller/provider/search_provider.dart';
import '../../../../model/product_model.dart';
import '../../../../utils/colors.dart';
import '../../../widgets/stars_rating.dart';
import '../../product_details/product_details_screen.dart';

class DisplaySearchedProducts extends StatelessWidget {
  const DisplaySearchedProducts({
    Key? key,
    required this.searchCategory,
  }) : super(key: key);

  final String searchCategory;

  @override
  Widget build(BuildContext context) {
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

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    final oCcy = NumberFormat("#,##0.00", "en_US");

    return Builder(builder: (context) {
      context.read<SearchProvider>().fetchSearchProduct(searchCategory);
      var checkSearch = context.read<SearchProvider>();
      List<ProductModel> searchedProduct =
          context.read<SearchProvider>().products;

      if (checkSearch.isLoading == true) {
        return const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return ListView.builder(
            itemCount: searchedProduct.length,
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              ProductModel currentProduct = searchedProduct[index];
              double totalRating = 0;
              double avgRating = 0;
              for (int i = 0; i < currentProduct.rating!.length; i++) {
                totalRating += currentProduct.rating![i].rating;
              }
              if (totalRating != 0) {
                avgRating = totalRating / currentProduct.rating!.length;
              }
              return InkWell(
                onTap: () => navigateToProductDetailsScreen(currentProduct),
                child: Container(
                  height: height * 0.15,
                  width: width,
                  margin: EdgeInsets.symmetric(
                    vertical: height * 0.005,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
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
                              StarRating(rating: avgRating),
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
              );
            });
      }
    });
  }
}
