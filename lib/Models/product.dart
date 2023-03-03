import 'dart:convert';
import 'package:amazon_clone/Models/rating.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String name;
  final String description;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  final double quantity;
  final List<Rating>? rating;
  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    this.rating,
  });

  //rating

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'quantity': quantity.toDouble(),
      'images': images,
      'category': category,
      'price': price.toDouble(),
      'id': id,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      description: map['description'] as String,
      quantity: map['quantity'].toDouble(),
      images: List<String>.from((map['images'])),
      category: map['category'] as String,
      price: map['price'].toDouble(),
      id: map['_id'].toString(),
      rating: map['rating'] != null
          ? List<Rating>.from(
              map['rating']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) {
    return Product.fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
