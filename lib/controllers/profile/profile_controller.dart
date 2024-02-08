import 'dart:convert';
import 'dart:developer';

import 'package:ldce_alumni/core/globals.dart' as globals;

import 'package:flutter/material.dart';
import 'package:ldce_alumni/models/masters/country/country.dart';
import 'package:ldce_alumni/models/masters/country/lcountry.dart';
import 'package:ldce_alumni/models/profile/profile.dart';

class ProfileController with ChangeNotifier {
  bool showLoading = true,
      uiLoading = true,
      hasMoreUpcomingData = true,
      hasMorePastData = true,
      exceptionCreated = false,
      uploadingImage = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reTypePasswordController = TextEditingController();

  TextEditingController fullNameTEC = TextEditingController();
  TextEditingController dobTEC = TextEditingController();
  TextEditingController genderTEC = TextEditingController();
  TextEditingController cityTEC = TextEditingController();
  TextEditingController stateTEC = TextEditingController();
  TextEditingController countryTEC = TextEditingController();
  TextEditingController primaryAddTEC = TextEditingController();
  TextEditingController secondaryAddTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController pincodeTEC = TextEditingController();
  TextEditingController mobileNumTEC = TextEditingController();
  TextEditingController altMobileNumTEC = TextEditingController();

  late Profile profileResponse;
  late String countryResponse;
  late Map<String, String> country;
  List<LCountry> countries = [];
  // Country selectedCountry=country[0];
  // = [];

  ProfileController() {
    getProfile();
    getCountry();
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

  // Future<void>
  Future getCountry() async {
    try {
      countryResponse = await Country.getCountryDetails();
      // country = await jsonDecode(countryResponse.toString());
      List<dynamic> jsonList = json.decode(countryResponse)['Result'];
      countries = jsonList.map((json) {
        return LCountry(id: json['Id'], name: json['Name']);
      }).toList();
      // log("Country Json: $countryResponse");
      log('Con - $countries');
      notifyListeners();
      // setState(() {});
    } catch (e) {
      print('Error loading dropdown data: $e');
    }
  }

  // Map<String, dynamic> profiledata = {};
  // Future getProfileData() async {
  //   var encId = await globals.FlutterSecureStorageObj.read(key: "encId");
  //   if (encId != null) {
  //     profileResponse = await Profile.getProfileDetails(encId: encId);
  //     // profiledata = profileResponse;
  //   } else {
  //     log("encId is null");
  //     return null;
  //   }
  //   showLoading = false;
  //   notifyListeners();
  // }
}
