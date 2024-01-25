import 'dart:developer';

import 'package:ldce_alumni/core/globals.dart' as globals;
import 'package:ldce_alumni/models/auth/login.dart';

import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reTypePasswordController = TextEditingController();

  late Auth loginResponse;
  Future storeEncId() async {
    await Auth.getEncId();
  }

  Future login() async {
    loginResponse = await Auth.doLogin(email: emailController.text, password: passwordController.text);

    log("loginResponse: $loginResponse");
    if (loginResponse.access_token != "") {
      await globals.FlutterSecureStorageObj.write(
        key: "access_token",
        value: loginResponse.access_token,
      );
      storeEncId();
      // emailController.clear();
      // passwordController.clear();
    }
    // var token =
    //     await globals.FlutterSecureStorageObj.read(key: "token", aOptions: globals.getAndroidOptions());
    // log(token.toString());
    notifyListeners();
  }
}
