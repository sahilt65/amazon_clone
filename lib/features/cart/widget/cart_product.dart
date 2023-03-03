// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:amazon_clone/Models/product.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailServices productDetailServices = ProductDetailServices();

  void increaseQuantity(Product product) {
    productDetailServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product) {}
  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart);
    final quantity = productCart['quantity'];
    // Product product = Product(
    //     name: "Iphone 12", description: "Hey this is gold", quantity: 12, images: [], category: 'Mobiles', price: 1230);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
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
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.black12,
                child: Row(children: [
                  //Increase
                  InkWell(
                    onTap: () => increaseQuantity(product),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.remove,
                        size: 18,
                      ),
                    ),
                  ),
                  //Middle Box Showing Quantity
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: Text(
                        quantity,
                      ),
                    ),
                  ),
                  //Decrease
                  Container(
                    width: 35,
                    height: 32,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.add,
                      size: 18,
                    ),
                  )
                ]),
              )
            ],
          ),
        )
      ],
    );
  }
}
