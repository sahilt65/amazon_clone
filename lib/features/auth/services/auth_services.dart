import 'package:amazon_clone/Models/user.dart';
import 'package:amazon_clone/constants/error_handeling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_clone/constants/global_variables.dart';

class AuthService {
  //sign up
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: 'user',
        token: '',
      );

      print("Sahil3" + user.toJson());

      http.Response res = await http.post(
        Uri.parse("http://localhost:3000/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print("Body :${res.body}");
      print("StatusCode : ${res.statusCode}");

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Account Created! Login with the same credentials");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
