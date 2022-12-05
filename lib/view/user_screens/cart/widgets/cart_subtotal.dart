import 'package:amazon/controller/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserDataProvider>().userModel;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    final textTheme = Theme.of(context).textTheme;
    final oCcy = NumberFormat("#,##0.0", "en_US");
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(10),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
          text: 'Subtotal: ',
          style: textTheme.headline4,
        ),
        TextSpan(
          text: '₹ ${oCcy.format(sum)}',
          style: textTheme.headline4!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ])),
    );
  }
}
