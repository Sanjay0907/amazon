import 'dart:developer';

import 'package:amazon/controller/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_and_images.dart';
import '../../../constants/common_functions.dart';
import '../../widgets/common_text_form_field.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address_screen';
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController houseNoController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    houseNoController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    // var address = context.watch<UserDataProvider>().userModel.address;
    var address = '101, hello street';
    log('the address is $address');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.075),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.02),
        child: Column(
          children: [
            if (address.isNotEmpty)
              Column(
                children: [
                  Container(
                    height: height * 0.07,
                    width: width,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Text(
                      address,
                      style: textTheme.headline5,
                    ),
                  ),
                  CommonFunctions.blankSpaces(context, 0.01, 0),
                  Text(
                    'OR',
                    style: textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CommonFunctions.blankSpaces(context, 0.03 , 0),
                ],
              ),
            Form(
              key: _addressFormKey,
              child: Column(
                children: [
                  CommonTextField(
                    textEditingController: houseNoController,
                    hintText: 'Flat, House no. Building',
                    obscureText: false,
                    textInputType: TextInputType.emailAddress,
                  ),
                  CommonFunctions.blankSpaces(context, 0.01, 0),
                  CommonTextField(
                    textEditingController: areaController,
                    hintText: 'Area, Street',
                    obscureText: true,
                    textInputType: TextInputType.streetAddress,
                  ),
                  CommonFunctions.blankSpaces(context, 0.01, 0),
                  CommonTextField(
                    textEditingController: pincodeController,
                    hintText: 'Pincode',
                    obscureText: false,
                    textInputType: TextInputType.number,
                  ),
                  CommonFunctions.blankSpaces(context, 0.01, 0),
                  CommonTextField(
                    textEditingController: cityController,
                    hintText: 'Town / City',
                    obscureText: true,
                    textInputType: TextInputType.streetAddress,
                  ),
                  CommonFunctions.blankSpaces(context, 0.03, 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
