import 'package:amazon_clone/constants/global_variables.dart';
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
    'www.google.com',
    'www.google.com',
    'www.google.com',
    'www.google.com',
    'www.google.com',
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
            itemCount: list.length,
            itemBuilder: ((context, index) {}),
          ),
        )
      ],
    );
  }
}
