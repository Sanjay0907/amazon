import 'dart:developer';
import 'dart:io';

import 'package:amazon/constants/common_functions.dart';
import 'package:amazon/controller/services/admin_services.dart';
import 'package:amazon/controller/services/pick_image.dart';
import 'package:amazon/utils/colors.dart';
import 'package:amazon/view/auth/auth_screen.dart';
import 'package:amazon/view/widgets/common_text_form_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../constants/color_and_images.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  final addProductFormKey = GlobalKey<FormState>();

  void sellProduct() {
    if (addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      AdminServices.sellProduct(
        context: context,
        name: productNameController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category,
        images: images,
      );
    } else if (images.isEmpty) {
      CommonFunctions.warningToast(
        context: context,
        description: 'Please select some product Image',
        givenWidth: 0.8,
        givenHeight: 0.1,
      );
    } else {
      CommonFunctions.warningToast(
        context: context,
        description: 'Please Fill all the fields',
        givenWidth: 0.8,
        givenHeight: 0.1,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];
  String category = 'Mobiles';
  List<File> images = [];

  void selectImage() async {
    var res = await pickProductImage();
    setState(() {
      images = res;
    });
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
            automaticallyImplyLeading: true,
            elevation: 0,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            centerTitle: true,
            title: Text(
              'Add Product',
              style: textTheme.headline4!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.01),
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Form(
              key: addProductFormKey,
              child: Column(
                children: [
                  CommonFunctions.blankSpaces(context, 0.01, 0),
                  images.isNotEmpty
                      ? Container(
                          height: height * 0.18,
                          width: width,
                          decoration: BoxDecoration(
                            // color: red,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: CarouselSlider(
                            items: images.map((i) {
                              return Builder(
                                builder: (context) {
                                  return Image.file(
                                    i,
                                    fit: BoxFit.fitHeight,
                                    height: height * 0.15,
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
                        )
                      : GestureDetector(
                          onTap: selectImage,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            strokeWidth: 1,
                            child: Container(
                              height: height * 0.18,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.folder_open,
                                    size: height * 0.07,
                                  ),
                                  CommonFunctions.blankSpaces(context, 0.01, 0),
                                  Text(
                                    'Select Product Images',
                                    style: textTheme.headline5!.copyWith(
                                      color: grey400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                  CommonFunctions.blankSpaces(context, 0.03, 0),
                  CommonTextField(
                    textEditingController: productNameController,
                    hintText: 'Product Name',
                    obscureText: false,
                    textInputType: TextInputType.name,
                  ),
                  CommonFunctions.blankSpaces(context, 0.01, 0),
                  CommonTextField(
                    textEditingController: descriptionController,
                    hintText: 'Description',
                    obscureText: false,
                    textInputType: TextInputType.name,
                    maxLines: 7,
                  ),
                  CommonFunctions.blankSpaces(context, 0.01, 0),
                  CommonTextField(
                    textEditingController: priceController,
                    hintText: 'Price',
                    obscureText: false,
                    textInputType: TextInputType.number,
                  ),
                  CommonFunctions.blankSpaces(context, 0.01, 0),
                  CommonTextField(
                    textEditingController: quantityController,
                    hintText: 'Quantity',
                    obscureText: false,
                    textInputType: TextInputType.number,
                  ),
                  CommonFunctions.blankSpaces(context, 0.02, 0),
                  SizedBox(
                    width: width,
                    child: DropdownButton(
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: productCategories.map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue!;
                        });
                      },
                    ),
                  ),
                  CommonFunctions.blankSpaces(context, 0.02, 0),
                  CommonButton(
                    width: width,
                    height: height,
                    textTheme: textTheme,
                    onPressed: sellProduct,
                    text: 'Sell',
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
