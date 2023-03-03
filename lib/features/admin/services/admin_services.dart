import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone/constants/error_handeling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/Models/product.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic("dfxiwrbfy", "ssajaucb");
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }
      print(imageUrls);

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );
      print("category " + product.toJson());

      http.Response res = await http.post(
        Uri.parse("$uri/admin/add-product"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print("done");
          showSnackBar(context, "Product added Successfully!");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    List<Product> productsList = [];

    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/get-products"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productsList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }

    return productsList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/admin/delete-product"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': product.id}),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
