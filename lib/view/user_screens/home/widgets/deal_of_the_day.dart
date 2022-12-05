import 'package:amazon/constants/common_functions.dart';
import 'package:amazon/controller/provider/deal_of_the_day_provider.dart';
import 'package:amazon/model/product_model.dart';
import 'package:amazon/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../product_details/product_details_screen.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  final oCcy = NumberFormat("#,##0.00", "en_US");
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getCarouselImages();
    });
  }

  getCarouselImages() async {
    deals = context.read<DealOfTheDayProvider>().deals;
    List<String> temp = [];
    for (int i = 0; i < deals.length; i++) {
      temp.add(deals[i].images[0]);
    }
    setState(() {
      dealsCarouselImages = temp;
    });
  }

  List<ProductModel> deals = [];
  List<String> dealsCarouselImages = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Expanded(child:
        Consumer<DealOfTheDayProvider>(builder: (context, dealoftheday, child) {
      if (dealoftheday.isLoading == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                left: width * 0.03,
                right: width * 0.03,
                top: height * 0.01,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Deal of the day',
                    style: textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'See all deals',
                    style: textTheme.headline6!.copyWith(color: cayn800),
                  ),
                ],
              ),
            ),
            CommonFunctions.blankSpaces(context, 0.005, 0),
            SizedBox(
              height: height * 0.25,
              width: width,
              child: CarouselSlider(
                items: dealoftheday.deals.map((i) {
                  return Builder(
                    builder: (context) {
                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          PageTransition(
                            child: ProductDetailsScreen(
                              model: i,
                            ),
                            type: PageTransitionType.rightToLeft,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                i.name,
                                style: textTheme.headline5,
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Image.network(
                                i.images[0],
                                fit: BoxFit.contain,
                                height: height * 0.15,
                                width: width,
                              ),
                            ),
                            const Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '₹ ${oCcy.format(
                                  i.price,
                                )}',
                                style: textTheme.headline5,
                              ),
                            ),
                          ],
                        ),
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
            CommonFunctions.blankSpaces(context, 0.01, 0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Row(
                children: [
                  Text(
                    'Deals for you :',
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.subtitle2!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            CommonFunctions.blankSpaces(context, 0.005, 0),
            SizedBox(
              // color: red,
              height: height * 0.12,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: dealoftheday.deals.length,
                itemBuilder: (context, index) {
                  ProductModel currentModel = dealoftheday.deals[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      PageTransition(
                        child: ProductDetailsScreen(
                          model: currentModel,
                        ),
                        type: PageTransitionType.rightToLeft,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: width * 0.03),
                          height: height * 0.1,
                          width: height * 0.1,
                          child: Image(
                            image: NetworkImage(
                              currentModel.images[0],
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            dealoftheday.deals[index].name,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }
    }));
  }
}
