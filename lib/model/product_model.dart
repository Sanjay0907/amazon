import 'dart:convert';

import 'package:amazon/model/rating_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final String name;
  final String description;
  final double quantity;
  final String category;
  final double price;
  final String? id;
  final List<String> images;
  final List<RatingModel>? rating;
  ProductModel({
    required this.name,
    required this.description,
    required this.quantity,
    required this.category,
    required this.price,
    this.id,
    required this.images,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity,
      'category': category,
      'price': price,
      'id': id,
      'images': images,
      'rating': rating,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      description: map['description'] as String,
      quantity: double.parse(map['quantity'].toString()),
      category: map['category'] as String,
      price: double.parse(map['price'].toString()),
      id: map['_id'] != null ? map['_id'] as String : null,
      images: List<String>.from(
        (map['images'] as List<dynamic>),
      ),
      rating: map['rating'] != null
          ? List<RatingModel>.from(
              map['rating']?.map(
                (x) => RatingModel.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
