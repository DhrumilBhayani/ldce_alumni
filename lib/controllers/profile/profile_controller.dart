import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

import 'package:flutter/material.dart';
import 'package:ldce_alumni/models/masters/branch/branch.dart';
import 'package:ldce_alumni/models/masters/branch/lbranch.dart';
import 'package:ldce_alumni/models/masters/country/country.dart';
import 'package:ldce_alumni/models/masters/country/lcountry.dart';
import 'package:ldce_alumni/models/masters/program/lprogam.dart';
import 'package:ldce_alumni/models/masters/program/program.dart';
import 'package:ldce_alumni/models/masters/state/state.dart';
import 'package:ldce_alumni/models/masters/state/lstate.dart';
import 'package:ldce_alumni/models/masters/city/city.dart';
import 'package:ldce_alumni/models/masters/city/lcity.dart';
import 'package:ldce_alumni/models/profile/profile.dart';
import 'package:ldce_alumni/models/update%20profile/updateprofile.dart';

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

  TextEditingController firstNameTEC = TextEditingController();
  TextEditingController middleNameTEC = TextEditingController();
  TextEditingController lastNameTEC = TextEditingController();
  TextEditingController dobTEC = TextEditingController();
  // TextEditingController genderTEC = TextEditingController();
  TextEditingController cityTEC = TextEditingController();
  TextEditingController stateTEC = TextEditingController();
  TextEditingController countryTEC = TextEditingController();
  TextEditingController primaryAddTEC = TextEditingController();
  TextEditingController secondaryAddTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController pincodeTEC = TextEditingController();
  TextEditingController mobileNumTEC = TextEditingController();
  TextEditingController altMobileNumTEC = TextEditingController();
  TextEditingController companyNameTEC = TextEditingController();
  TextEditingController companyAddTEC = TextEditingController();
  TextEditingController designationTEC = TextEditingController();
  TextEditingController degreeNameTEC = TextEditingController();
  TextEditingController passoutYearTEC = TextEditingController();
  TextEditingController streamNameTEC = TextEditingController();
  TextEditingController membershipTEC = TextEditingController();
  TextEditingController membershipVerificationStatusTEC = TextEditingController();
  String genderValue = 'Male';
  // String genderValue = profileResponse.Result.Gender ? "Male" : "Female";

  late Profile profileResponse;
  late String countryResponse;
  late Map<String, String> country;
  List<LCountry> countries = [];
  late String stateResponse;
  List<LState> states = [];
  late String cityResponse;
  List<LCity> cities = [];
  late String programResponse;
  List<LProgram> programs = [];
  late String branchResponse;
  List<LBranch> branches = [];
  // Country selectedCountry=country[0];
  // = [];
  late UpdateProfile updatePofileResponse;
  Map<String, dynamic> profileData = {};

  LCountry? selectedCountry;
  LState? selectedState;
  LCity? selectedCity;
  LProgram? selectedProgram;
  LBranch? selectedBranch;

  // int selectedProgramId=0;

  ProfileController() {
    getaAllDetails();
  }
  Future getaAllDetails() async {
    await getProfile();
    // getCity();
    getCountry();

    getState(profileResponse.Result.CountryId);
    getCity(profileResponse.Result.StateId);
    getProgram();
    getBranch();
  }

  Future getProfile() async {
    var encId = await globals.FlutterSecureStorageObj.read(key: "encId");
    if (encId != null) {
      profileResponse = await Profile.getProfileDetails(encId: encId);
      profileData = json.decode(profileResponse.Result.toJson());
    } else {
      log("encId is null");
      return null;
    }
    // profileResponse = await
    log("profileResponse: $profileResponse");
    log("profileData: $profileData");
    showLoading = false;
    notifyListeners();
  }

  Future updateProfile() async {
    var encId = await globals.FlutterSecureStorageObj.read(key: "encId");
    var token = await globals.FlutterSecureStorageObj.read(key: "access_token");
    if (encId != null || token != null) {
      log('DOB - C - ${dobTEC.text}');
      log('selectedCountry - C - ${selectedCountry?.name}');
      // profileData['FullName'] = fullNameTEC.text.isNotEmpty ? fullNameTEC.text : profileData['FullName'];
      profileData['FirstName'] = firstNameTEC.text.isNotEmpty ? firstNameTEC.text : profileData['FirstName'];
      profileData['MiddleName'] = middleNameTEC.text.isNotEmpty ? middleNameTEC.text : profileData['MiddleName'];
      profileData['LastName'] = lastNameTEC.text.isNotEmpty ? lastNameTEC.text : profileData['LastName'];
      profileData['DOB'] = dobTEC.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parseStrict(dobTEC.text))
          : profileData['DOB'];
      profileData['DOB'] = profileData['DOB'].toString() + "T00:00:00";
      log('DOB - 90 - ${profileData['DOB']}');
      // profileData['Gender'] = genderTEC.text.isNotEmpty ? genderTEC.text : profileData['Gender'];
      profileData['Gender'] = genderValue.isNotEmpty
          ? genderValue == "Male"
              ? true
              : false
          : profileData['Gender'];
      profileData['CityName'] = cityTEC.text.isNotEmpty ? cityTEC.text : profileData['CityName'];
      profileData['StateName'] = stateTEC.text.isNotEmpty ? stateTEC.text : profileData['StateName'];
      // profileData['CountryName'] = countryTEC.text.isNotEmpty ? countryTEC.text : profileData['CountryName'];
      // profileData['CountryName'] = selectedCountry!.name.isNotEmpty ? selectedCountry?.name : profileData['CountryName'];
      profileData['CountryName'] = selectedCountry?.name != '' ? selectedCountry?.name : profileData['CountryName'];
      profileData['PrimaryAddress'] =
          primaryAddTEC.text.isNotEmpty ? primaryAddTEC.text : profileData['PrimaryAddress'];
      profileData['SecondaryAddress'] =
          secondaryAddTEC.text.isNotEmpty ? secondaryAddTEC.text : profileData['SecondaryAddress'];
      profileData['EmailAddress'] = emailTEC.text.isNotEmpty ? emailTEC.text : profileData['EmailAddress'];
      profileData['PinCode'] = pincodeTEC.text.isNotEmpty ? pincodeTEC.text : profileData['PinCode'];
      profileData['MobileNo'] = mobileNumTEC.text.isNotEmpty ? mobileNumTEC.text : profileData['MobileNo'];
      profileData['TelephoneNo'] = altMobileNumTEC.text.isNotEmpty ? altMobileNumTEC.text : profileData['TelephoneNo'];
      profileData['CompanyName'] = companyNameTEC.text.isNotEmpty ? companyNameTEC.text : profileData['CompanyName'];
      profileData['CompanyAddress'] =
          companyAddTEC.text.isNotEmpty ? companyAddTEC.text : profileData['CompanyAddress'];
      profileData['Designation'] = designationTEC.text.isNotEmpty ? designationTEC.text : profileData['Designation'];
      profileData['PassoutYear'] = passoutYearTEC.text.isNotEmpty ? passoutYearTEC.text : profileData['PassoutYear'];
      profileData['DegreeId'] = selectedProgram?.id.toInt() != 0 ? selectedProgram?.id : profileData['DegreeId'];
      // profileData['DegreeName'] = selectedProgram!.name.isNotEmpty ? selectedProgram?.name : profileData['DegreeName'];
      profileData['DegreeName'] = selectedProgram?.name != '' ? selectedProgram?.name : profileData['DegreeName'];
      profileData['StreamId'] = selectedBranch?.id.toInt() != 0 ? selectedBranch?.id : profileData['StreamId'];
      // profileData['StreamName'] = selectedBranch!.name.isNotEmpty ? selectedBranch?.name : profileData['StreamName'];
      profileData['StreamName'] = selectedBranch?.name != '' ? selectedBranch?.name : profileData['StreamName'];
      log('profileData: 104 $profileData');
      updatePofileResponse = await UpdateProfile.updateProfileDetails(
        encId: encId,
        token: token,
        dataBody: profileData,
      );
      profileData = json.decode(updatePofileResponse.toJson());
      log('profileData: 111 $profileData');
    } else {
      log("encId/token is null");
      return null;
    }
    log("updatePofileResponse: $updatePofileResponse");
    await getProfile();
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

  Future getState(int countryId) async {
    log("getState - $countryId");
    try {
      stateResponse = await States.getStateDetails(countryId);
      List<dynamic> jsonList = json.decode(stateResponse)['Result'];
      states = [];
      states = jsonList.map((json) {
        return LState(id: json['Id'], name: json['Name']);
      }).toList();
      // log("Country Json: $countryResponse");
      log('State - ${states[6].name}');
      notifyListeners();
      // setState(() {});
    } catch (e) {
      print('Error loading dropdown data: $e');
    }
  }

  Future getCity(int stateId) async {
    log("getCity - $stateId");
    try {
      cityResponse = await City.getCityDetails(stateId);
      List<dynamic> jsonList = json.decode(cityResponse)['Result'];
      cities = jsonList.map((json) {
        return LCity(id: json['Id'], name: json['Name']);
      }).toList();
      log('Cities - $cities');
      notifyListeners();
    } catch (e) {
      print('Error loading dropdown data: $e');
    }
  }

  Future getProgram() async {
    try {
      programResponse = await Program.getProgramDetails();
      List<dynamic> jsonList = json.decode(programResponse)['Result'];
      programs = jsonList.map((json) {
        return LProgram(id: json['Id'], name: json['Name']);
      }).toList();
      log('Program - $programs');
      notifyListeners();
    } catch (e) {
      print('Error loading dropdown data: $e');
    }
  }

  Future getBranch() async {
    try {
      branchResponse = await Branch.getBranchDetails();
      List<dynamic> jsonList = json.decode(branchResponse)['Result'];
      branches = jsonList.map((json) {
        return LBranch(id: json['Id'], name: json['Name']);
      }).toList();
      log('Branch - $branches');
      notifyListeners();
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
