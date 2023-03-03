// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/Models/product.dart';
import 'package:provider/provider.dart';

class SearchedProducts extends StatelessWidget {
  final Product product;
  const SearchedProducts({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    double avgRating = 0;

    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            Image.network(
              product.images[0],
              fit: BoxFit.fitWidth,
              height: 135,
              width: 135,
            ),
            Column(
              children: [
                Container(
                  width: 235,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    product.name,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Stars(rating: avgRating),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    "\$${product.price}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: const Text(
                    "In Stock",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
                    maxLines: 2,
                  ),
                ),
              ],
            )
          ]),
        )
      ],
    );
  }
}
