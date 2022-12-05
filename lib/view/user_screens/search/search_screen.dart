import 'package:amazon/controller/provider/search_provider.dart';
import 'package:amazon/model/product_model.dart';
import 'package:amazon/utils/colors.dart';
import 'package:amazon/view/user_screens/home/widgets/address_bar.dart';
import 'package:amazon/view/widgets/stars_rating.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_and_images.dart';
import 'widgets/display_searched_products.dart';

class SearchScreen extends StatefulWidget {
  final String searchCategory;
  const SearchScreen({super.key, required this.searchCategory});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  search(String searchQuery) {
    context.read<SearchProvider>().fetchSearchProduct(searchQuery);
  }

  TextEditingController searchController = TextEditingController();
  final oCcy = NumberFormat("#,##0.00", "en_US");
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
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            const AddressBar(),
            DisplaySearchedProducts(
              searchCategory: widget.searchCategory,
            ),
          ],
        ),
      ),
    );
  }
}
