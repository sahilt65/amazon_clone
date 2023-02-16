import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 15, top: 15),
          child: const Text(
            "Deal of the day",
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Image.network(
          "https://th.bing.com/th/id/OIP.ov57nJfrUFnjSLZ40PMgDgHaFs?pid=ImgDet&rs=1",
          fit: BoxFit.contain,
          height: 300,
          width: 300,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15),
          child: const Text("\$999.0", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 15, top: 5, right: 40),
          child: const Text(
            'Description',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                "https://th.bing.com/th/id/OIP.ov57nJfrUFnjSLZ40PMgDgHaFs?pid=ImgDet&rs=1",
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
              Image.network(
                "https://th.bing.com/th/id/OIP.ov57nJfrUFnjSLZ40PMgDgHaFs?pid=ImgDet&rs=1",
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
              Image.network(
                "https://th.bing.com/th/id/OIP.ov57nJfrUFnjSLZ40PMgDgHaFs?pid=ImgDet&rs=1",
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
              Image.network(
                "https://th.bing.com/th/id/OIP.ov57nJfrUFnjSLZ40PMgDgHaFs?pid=ImgDet&rs=1",
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
              Image.network(
                "https://th.bing.com/th/id/OIP.ov57nJfrUFnjSLZ40PMgDgHaFs?pid=ImgDet&rs=1",
                fit: BoxFit.fitWidth,
                height: 100,
                width: 100,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
          alignment: Alignment.topLeft,
          child: const Text(
            "See all desls",
            style: TextStyle(color: Colors.cyan),
          ),
        )
      ],
    );
  }
}
