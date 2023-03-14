import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  //Temporary Lis
  List list = [
    'https://www.xda-developers.com/files/2022/09/Deep-Purple-iPhone-14-Pro-Max.jpg',
    'https://www.gizmochina.com/wp-content/uploads/2020/11/MacBook-Air-featured.jpg',
    'https://d28i4xct2kl5lp.cloudfront.net/product_images/None_6bbe58a2-f5ff-4f5b-b21f-d3f18c405463.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'Your Orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                'See all',
                style: TextStyle(fontSize: 16, color: GlobalVariables.selectedNavBarColor, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        //Display Order
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: ((context, index) {
              return SingleProduct(image: list[index]);
            }),
          ),
        )
      ],
    );
  }
}
