// ignore_for_file: use_build_context_synchronously

import 'package:amazon/constants/common_functions.dart';
import 'package:amazon/controller/provider/user_data_provider.dart';
import 'package:amazon/controller/services/product_details_services.dart';
import 'package:amazon/model/product_model.dart';
import 'package:amazon/view/auth/auth_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_and_images.dart';
import '../../../controller/provider/search_provider.dart';
import '../../../utils/colors.dart';
import '../../widgets/stars_rating.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.model});
  final ProductModel model;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  TextEditingController searchController = TextEditingController();

  search(String searchQuery) async {
    await context.read<SearchProvider>().setToDefault();
    await context.read<SearchProvider>().fetchSearchProduct(searchQuery);
  }

  final oCcy = NumberFormat("#,##0.00", "en_US");
  double avgRating = 0;
  double myRating = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.model.rating!.length; i++) {
      totalRating += widget.model.rating![i].rating;
      if (widget.model.rating![i].userId ==
          context.read<UserDataProvider>().userModel.id) {
        myRating = widget.model.rating![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.model.rating!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
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
                onFieldSubmitted: search,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    onPressed: () {
                      // navigateToSearchScreen(searchController.text.trim());
                      search(searchController.text.trim());
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
      body: Container(
        height: height,
        width: width,
        child: ListView(
          children: [
            Container(
              height: height * 0.05,
              width: width,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.model.id!,
                    style: textTheme.headline6,
                  ),
                  StarRating(
                    rating: avgRating,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Text(
                widget.model.name,
                maxLines: 2,
                style: textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: height * 0.25,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: CarouselSlider(
                items: widget.model.images.map((i) {
                  return Builder(
                    builder: (context) {
                      return Image.network(
                        i,
                        fit: BoxFit.contain,
                        height: height * 0.25,
                        width: width,
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: height * 0.23,
                  autoPlay: true,
                ),
              ),
            ),
            CommonFunctions.blankSpaces(
              context,
              0.01,
              0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'M.R.P : ',
                      style: textTheme.headline6!
                          .copyWith(fontWeight: FontWeight.bold, color: grey),
                    ),
                    TextSpan(
                      text: '₹ ${oCcy.format(widget.model.price)}',
                      style: textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            CommonFunctions.blankSpaces(context, 0.01, 0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: CommonButton(
                width: width,
                height: height,
                textTheme: textTheme,
                onPressed: () {},
                text: 'Buy',
              ),
            ),
            CommonFunctions.blankSpaces(context, 0.01, 0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: ElevatedButton(
                onPressed: () {
                  ProductDetailsServices.addToCart(
                    context: context,
                    model: widget.model,
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: white,
                    minimumSize: Size(width, height * 0.06)),
                child: Text(
                  'Add to Cart',
                  style: textTheme.headline5!
                      .copyWith(color: black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Product Details :-',
                style: textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Text(
                widget.model.description,
                style: textTheme.headline6,
              ),
            ),
            CommonFunctions.blankSpaces(
              context,
              0.02,
              0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Text(
                'Rate the product',
                style: textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: RatingBar.builder(
                initialRating: myRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) => const Icon(Icons.star,
                    color: GlobalVariables.secondaryColor),
                onRatingUpdate: (rating) {
                  ProductDetailsServices.rateProduct(
                    context: context,
                    model: widget.model,
                    rating: rating,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
