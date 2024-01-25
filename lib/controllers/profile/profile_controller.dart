import 'dart:developer';

import 'package:ldce_alumni/core/globals.dart' as globals;

import 'package:flutter/material.dart';
import 'package:ldce_alumni/models/profile/profile.dart';

class ProfileController with ChangeNotifier {
   bool showLoading = true,
      uiLoading = true,
      hasMoreUpcomingData = true,
      hasMorePastData = true,
      exceptionCreated = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reTypePasswordController = TextEditingController();

  late Profile profileResponse;
  
  ProfileController() {
    getProfile();
    
  }

  Future getProfile() async {
    var encId = await globals.FlutterSecureStorageObj.read(key: "encId");
    if (encId != null) {
      profileResponse = await Profile.getProfileDetails(encId: encId);
    } else {
      log("encId is null");
      return null;
    }
    // profileResponse = await

    log("profileResponse: $profileResponse");
  showLoading = false;
    notifyListeners();
  }
}
