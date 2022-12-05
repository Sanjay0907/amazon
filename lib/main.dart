// ignore_for_file: use_build_context_synchronously

import 'package:amazon/controller/provider/admin_products_provider.dart';
import 'package:amazon/controller/provider/deal_of_the_day_provider.dart';
import 'package:amazon/controller/provider/product_provider.dart';
import 'package:amazon/controller/provider/search_provider.dart';
import 'package:amazon/controller/provider/success_provider.dart';
import 'package:amazon/controller/provider/user_data_provider.dart';
import 'package:amazon/utils/theme.dart';
import 'package:amazon/routes.dart';
import 'package:amazon/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Amazon());
}

class Amazon extends StatefulWidget {
  const Amazon({super.key});

  @override
  State<Amazon> createState() => _AmazonState();
}

class _AmazonState extends State<Amazon> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DealOfTheDayProvider>(
          create: (context) => DealOfTheDayProvider(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider<ProductsProvider>(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider<AdminProductsProvider>(
          create: (context) => AdminProductsProvider(),
        ),
        ChangeNotifierProvider<CheckSuccessProvider>(
          create: (context) => CheckSuccessProvider(),
        ),
        ChangeNotifierProvider<UserDataProvider>(
          create: (context) => UserDataProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Amazon',
        theme: theme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const SplashScreen(),
      ),
    );
  }
}
