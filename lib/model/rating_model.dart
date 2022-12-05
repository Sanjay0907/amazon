import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RatingModel {
  final String userId;
  final double rating;
  RatingModel({
    required this.userId,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'rating': rating,
    };
  }

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      userId: map['userId'] as String,
      rating: double.parse(map['rating'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory RatingModel.fromJson(String source) =>
      RatingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
