// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ldce_alumni/controllers/profile/profile_controller.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/models/masters/branch/lbranch.dart';
import 'package:ldce_alumni/models/masters/country/country.dart';
import 'package:ldce_alumni/models/masters/country/lcountry.dart';
import 'package:ldce_alumni/models/masters/program/lprogam.dart';
import 'package:ldce_alumni/models/masters/state/lstate.dart';
import 'package:ldce_alumni/models/masters/city/lcity.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:ldce_alumni/views/auth/Login/constants.dart';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:ldce_alumni/views/widgets/app_bar_widget.dart';
import 'package:ldce_alumni/views/widgets/app_drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

import 'dart:io';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> alumni = {};
  // TextEditingController cityTEC = TextEditingController();
  // TextEditingController countryTEC = TextEditingController();
  late CustomTheme customTheme;
  // TextEditingController dobTEC = TextEditingController();
  // TextEditingController firstNameTEC = TextEditingController();
  // TextEditingController genderTEC = TextEditingController();

  String dropdownvalue = 'Male';
  var items = [
    'Male',
    'Female',
  ];

  // TextEditingController lastNameTEC = TextEditingController();
  // TextEditingController middleNameTEC = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime selectedYear = DateTime.now(); //DateTime(DateTime.now().year); //DateTime.now();
  // TextEditingController stateTEC = TextEditingController();
  late ThemeData theme;

  final _academicInfo = GlobalKey<FormState>();
  final _contactInfo = GlobalKey<FormState>();
  late File _image;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final _personalInfo = GlobalKey<FormState>();

  // TextEditingController primaryAddTEC = TextEditingController();
  // TextEditingController secondaryAddTEC = TextEditingController();
  // TextEditingController emailTEC = TextEditingController();
  // TextEditingController pincodeTEC = TextEditingController();
  // TextEditingController mobileNumTEC = TextEditingController();
  // TextEditingController altMobileNumTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.white,
    //   statusBarIconBrightness: Brightness.dark
    // ));
    // selectedCountry = users[0];
  }

  Future<void> uploadImage(ProfileController profileProvider) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    log(profileProvider.uploadingImage.toString());
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    if (_image == null) {
      return;
    }

    if (_image.lengthSync() > 5 * 1024 * 1024) {
      return;
    }

    var encId = await globals.FlutterSecureStorageObj.read(key: "encId");
    var token = await globals.FlutterSecureStorageObj.read(key: "access_token");
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        globals.BASE_API_URL + '/Alumni/UpdateProfilePicture/$encId',
      ),
    );

    request.files.add(
      http.MultipartFile(
        'image',
        _image.readAsBytes().asStream(),
        _image.lengthSync(),
        filename: 'profile_image.jpg',
      ),
    );
    // request.headers['Authorization'] = 'Bearer ${token}';
    Map<String, String> headers = {"Authorization": "Bearer $token", "Content-type": "multipart/form-data"};
    request.headers.addAll(headers);

    profileProvider.uploadingImage = true;
    profileProvider.notifyListeners();
    log(profileProvider.uploadingImage.toString());
    try {
      var response = await request.send();
      var response1 = await http.Response.fromStream(response);

      print("Response status: ${response1.body}");
      if (response.statusCode == 200) {
        profileProvider.getProfile();
        print('Image uploaded successfully');
        profileProvider.uploadingImage = false;
        log(profileProvider.uploadingImage.toString());
        profileProvider.notifyListeners();
        //
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        profileProvider.uploadingImage = false;
      }
    } catch (error) {
      profileProvider.uploadingImage = false;
      print('Error uploading image: $error');
    }
  }

  selectYear(context, passoutYear) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Year"),
          content: Container(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(1900), //DateTime.now().year - 100, 1
              lastDate: DateTime(DateTime.now().year),
              initialDate: DateTime.now(),
              // save the selected date to _selectedDate DateTime variable.
              // It's used to set the previous selected date when
              // re-showing the dialog.
              selectedDate: selectedYear,
              onChanged: (DateTime dateTime) {
                // close the dialog when year is selected.
                passoutYear.text = dateTime.year.toString();
                selectedYear = dateTime;
                // selectedYear = DateFormat('YYYY').format(DateTime.parse(dateTime));
                log('selectedYear- $selectedYear');
                Navigator.pop(context);

                // Do something with the dateTime selected.
                // Remember that you need to use dateTime.year to get the year
              },
            ),
          ),
        );
      },
    );
  }

  /*Future<void> fetchAlumniData() async {
    var encId = await globals.FlutterSecureStorageObj.read(key: "encId");
    final response = await http.get(Uri.parse(globals.BASE_API_URL + '/alumni?EncryptedId=$encId'));
    if (response.statusCode == 200) {
      setState(() {
        alumni = json.decode(response.body)['Result'];
        log('alumni data: - ${alumni}');
      });
    } else {
      print('Failed to fetch current data. Status code: ${response.statusCode}');
    }
  }

  Future<void> showMembershipInfo(BuildContext context) async {
    final _membershipInfo = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Membership Information'),
          content: SingleChildScrollView(
            child: Form(
              key: _membershipInfo,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Membership'),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Enter your input here"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid value!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text('Verification Status'),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Enter your input here"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid value!';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                // Handle the submit action
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showPersonalInfo(BuildContext context) async {
    final _personalInfo = GlobalKey<FormState>();
    // await fetchAlumniData();
    // fullNameTEC.text = alumni['FullName']; // ?? ''
    // dobTEC.text = alumni['DOB'];
    // genderTEC.text = alumni['Gender'].toString();
    // cityTEC.text = alumni['CityName'];
    // stateTEC.text = alumni['StateName'];
    // countryTEC.text = alumni['CountryName'];

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Personal Information'),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _personalInfo,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Full Name'),
                  TextFormField(
                    controller: fullNameTEC,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Full Name "),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid Full Name!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text('DOB'),
                  TextFormField(
                    controller: dobTEC,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(hintText: "Date of birth"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid Full Name!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text('Gender'),
                  TextFormField(
                    controller: genderTEC,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Gender"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid Full Name!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text('City'),
                  TextFormField(
                    controller: cityTEC,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "City"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid Full Name!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text('State'),
                  TextFormField(
                    controller: stateTEC,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "State"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid Full Name!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text('Country'),
                  TextFormField(
                    controller: countryTEC,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Country"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid Full Name!';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedCountry,
                    items: _countryList.map((String country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCountry = newValue!;
                        _selectedState = '';
                        _selectedCity = '';
                        _stateList = [];
                        _cityList = [];
                        _loadStateData(_selectedCountry);
                      });
                    },
                    decoration: InputDecoration(labelText: 'Country'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your country';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () async {
                var encId = await globals.FlutterSecureStorageObj.read(key: "encId");
                var token = await globals.FlutterSecureStorageObj.read(key: "access_token");
                try {
                  // alumni['FullName'] = fullNameTEC.text;
                  alumni['DOB'] = dobTEC.text;
                  alumni['Gender'] = genderTEC.text;
                  alumni['CityName'] = cityTEC.text;
                  alumni['StateName'] = stateTEC.text;
                  alumni['CountryName'] = countryTEC.text;
                  log('FullName data - ${alumni['FullName']}');
                  log('Update data - $alumni');
                  var response = await http.post(Uri.parse(globals.BASE_API_URL + '/Alumni/Update?EncryptedId=$encId'),
                      headers: <String, String>{"Authorization": "Bearer $token", "Content-type": "application/json"},
                      body: jsonEncode(alumni
                          // {
                          //   'FullName': fullNameTEC.text,
                          //   'DOB': dobTEC.text,
                          //   'Gender': genderTEC.text,
                          //   'CityName': cityTEC.text,
                          //   'StateName': stateTEC.text,
                          //   'CountryName': countryTEC.text,
                          // },
                          ));
                  log('1283 - ${response.statusCode}');
                  if (response.statusCode == 200) {
                    await fetchAlumniData();
                    setState(() {});
                    Navigator.pop(context);
                  } else {
                    print('Failed to update data. Status code: ${response.statusCode}');
                  }
                } catch (e) {
                  print('Failed to update data. $e');
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showContactInfo(BuildContext context) async {
    final _contactInfo = GlobalKey<FormState>();
    await fetchAlumniData();
    primaryAddTEC.text = alumni['PrimaryAddress'];
    secondaryAddTEC.text = alumni['SecondaryAddress'];
    emailTEC.text = alumni['EmailAddress'];
    pincodeTEC.text = alumni['PinCode'];
    mobileNumTEC.text = alumni['MobileNo'];
    altMobileNumTEC.text = alumni['TelephoneNo'];

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Contact Information'),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _contactInfo,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Primary Address'),
                  TextFormField(
                    controller: primaryAddTEC,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Primary Address"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid Primary Address!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text('Secondary Address'),
                  TextFormField(
                    controller: secondaryAddTEC,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "Secondary Address"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid Secondary Address!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text('Email Address'),
                  TextFormField(
                    controller: emailTEC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Email"),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text('Pincode'),
                  TextFormField(
                    controller: pincodeTEC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Pincode"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid Pincode!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text('Mobile Number'),
                  TextFormField(
                    controller: mobileNumTEC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Mobile Number"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid Mobile Number!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Text('Alternate Number'),
                  TextFormField(
                    controller: altMobileNumTEC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Alternate Number"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a valid Alternate Number!';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () async {
                var encId = await globals.FlutterSecureStorageObj.read(key: "encId");
                var token = await globals.FlutterSecureStorageObj.read(key: "access_token");
                try {
                  var response = await http.post(Uri.parse(globals.BASE_API_URL + '/Alumni/Update?EncryptedId=$encId'),
                      headers: <String, String>{"Authorization": "Bearer $token", "Content-type": "application/json"},
                      body: jsonEncode({
                        'PrimaryAddress': primaryAddTEC.text,
                        'SecondaryAddress': secondaryAddTEC.text,
                        'EmailAddress': emailTEC.text,
                        'PinCode': pincodeTEC.text,
                        'MobileNo': mobileNumTEC.text,
                        'TelephoneNo': altMobileNumTEC.text,
                      }));
                  if (response.statusCode == 200) {
                    await fetchAlumniData();
                    Navigator.pop(context);
                  } else {
                    print('Failed to update data. Status code: ${response.statusCode}');
                  }
                } catch (e) {
                  print('Failed to update data. $e');
                }
              },
            ),
          ],
        );
      },
    );
  }
*/

  @override
  Widget build(BuildContext context) {
    // LCountry? selectedCountry;
    // LState? selectedState;
    // LCity? selectedCity;
    // LProgram? selectedProgram;
    // LBranch? selectedBranch;

    const kSpacingUnit = 10;
    return Consumer2<AppNotifier, ProfileController>(builder: (BuildContext context, AppNotifier value, profileProvider, Widget? child) {
      // dropdownvalue = profileProvider.profileResponse.Result.Gender ? "Male" : "Female";
      profileProvider.genderValue = profileProvider.profileResponse.Result.Gender ? "Male" : "Female";
      return profileProvider.showLoading
          ? Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
              ),
              backgroundColor: customTheme.card,
              body: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
                  child: LoadingEffect.getProfileLoadingScreen(
                    context,
                  )))
          : Scaffold(
              key: _key,
              appBar: AppBarWidget(
                scaffoldKey: _key,
                // title: "About US",
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  profileProvider.getCountry();
                },
                child: Icon(Icons.refresh),
              ),
              endDrawer: AppDrawerWidget(),
              body: SingleChildScrollView(
                // controller: controller,
                child: Column(
                  children: <Widget>[
                    Container(
                        child: Padding(
                      padding:
                          EdgeInsets.only(left: 24, right: 24, top: profileProvider.profileResponse.Result.ProfilePicPath != "" ? 0 : 20),
                      child: Column(children: <Widget>[
                        if (profileProvider.profileResponse.Result.ProfilePicPath != "")
                          Container(
                            height: kSpacingUnit * 10,
                            width: kSpacingUnit * 10,
                            margin: EdgeInsets.only(top: kSpacingUnit * 3),
                            child: Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: kSpacingUnit * 5,
                                  backgroundImage:
                                      NetworkImage('https://' + profileProvider.profileResponse.Result.ProfilePicPath.toString()),
                                ),
                                // Align(
                                //   alignment: Alignment.bottomRight,
                                //   child: Container(
                                //     height: kSpacingUnit * 2.5,
                                //     width: kSpacingUnit * 2.5,
                                //     decoration: BoxDecoration(
                                //       color: Theme.of(context).secondaryHeaderColor,
                                //       shape: BoxShape.circle,
                                //     ),
                                //     child: Center(
                                //       heightFactor: kSpacingUnit * 1.5,
                                //       widthFactor: kSpacingUnit * 1.5,
                                //       child: Icon(
                                //         Icons.edit,
                                //         color: Theme.of(context).primaryColor,
                                //         size: 15,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        profileProvider.uploadingImage
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () => uploadImage(profileProvider),
                                child: Text('Upload Image'),
                              ),
                        SizedBox(height: 10),
                        SizedBox(height: 10),
                        Text(
                          profileProvider.profileResponse.Result.FullName.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          profileProvider.profileResponse.Result.EmailAddress.toString(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(height: 20),
                        // ElevatedButton(
                        //   child: Text('Elevated Button'),
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.green,
                        //   ),
                        //   onPressed: () {
                        //     ProfileController profileController = ProfileController();
                        //     profileController.getProfile();
                        //   },
                        // ),

                        Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ExpansionTile(
                                    title: FxText.h6("PERSONAL INFORMATION", fontSize: 18, fontWeight: 800),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Table(
                                          children: [
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(
                                                    'First Name',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(profileProvider.profileResponse.Result.FirstName.toString(),
                                                      textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(
                                                    'Middle Name',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(profileProvider.profileResponse.Result.MiddleName.toString(),
                                                      textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(
                                                    'Last Name',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(profileProvider.profileResponse.Result.LastName.toString(),
                                                      textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(
                                                    'Full Name',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(profileProvider.profileResponse.Result.FullName.toString(),
                                                      textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10),
                                                  child: Text(
                                                    'DOB',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10),
                                                  child: Text(
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(DateTime.parse(profileProvider.profileResponse.Result.DOB.toString())),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(
                                                    'Gender',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(profileProvider.profileResponse.Result.Gender ? "Male" : "Female",
                                                      textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(
                                                    'City',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(profileProvider.profileResponse.Result.CityName.toString(),
                                                      textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(
                                                    'State',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(profileProvider.profileResponse.Result.StateName.toString(),
                                                      textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(
                                                    'Country',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(profileProvider.profileResponse.Result.CountryName.toString(),
                                                      textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          // showPersonalInfo(context);
                                          profileProvider.firstNameTEC.text = profileProvider.profileResponse.Result.FirstName.toString();
                                          profileProvider.middleNameTEC.text = profileProvider.profileResponse.Result.MiddleName.toString();
                                          profileProvider.lastNameTEC.text = profileProvider.profileResponse.Result.LastName.toString();
                                          profileProvider.dobTEC.text = DateFormat('dd-MM-yyyy')
                                              .format(DateTime.parse(profileProvider.profileResponse.Result.DOB.toString()));
                                          // profileProvider.profileResponse.Result.DOB.toString();
                                          // profileProvider.genderTEC.text = profileProvider.profileResponse.Result.Gender.toString();
                                          profileProvider.cityTEC.text = profileProvider.profileResponse.Result.CityName.toString();
                                          profileProvider.stateTEC.text = profileProvider.profileResponse.Result.StateName.toString();
                                          profileProvider.countryTEC.text = profileProvider.profileResponse.Result.CountryName.toString();
                                          setState(() {
                                            profileProvider.countries.map((LCountry country) {
                                              if (country.name.toString() ==
                                                  profileProvider.profileResponse.Result.CountryName.toString()) {
                                                log("Country Name - ${country.name}");
                                                profileProvider.selectedCountry = country;
                                              }
                                            }).toList();
                                            profileProvider.states.map((LState state) {
                                              if (state.name.toString() == profileProvider.profileResponse.Result.StateName.toString()) {
                                                profileProvider.selectedState = state;
                                              }
                                            }).toList();
                                            profileProvider.cities.map((LCity city) {
                                              if (city.name.toString() == profileProvider.profileResponse.Result.CityName.toString()) {
                                                profileProvider.selectedCity = city;
                                              }
                                            }).toList();
                                          });
                                          await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                                return AlertDialog(
                                                  title: FxText.h6("PERSONAL INFORMATION", fontSize: 18, fontWeight: 800),
                                                  // insetPadding: EdgeInsets.all(30),
                                                  content: SingleChildScrollView(
                                                    scrollDirection: Axis.vertical,
                                                    child: Form(
                                                      key: _personalInfo,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'First Name',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          TextFormField(
                                                            controller: profileProvider.firstNameTEC,
                                                            decoration: InputDecoration(
                                                              hintText: "First Name ",
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Colors.black),
                                                              ),
                                                            ),
                                                            keyboardType: TextInputType.text,
                                                            textInputAction: TextInputAction.next,
                                                            cursorColor: kPrimaryColor,
                                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                                            validator: (value) {
                                                              if (value!.isEmpty || value.trim() == '') {
                                                                return 'Enter a valid first Name!';
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                          SizedBox(height: 10),
                                                          Text(
                                                            'Middle Name',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          TextFormField(
                                                            controller: profileProvider.middleNameTEC,
                                                            decoration: InputDecoration(
                                                              hintText: "Middle name ",
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Colors.black),
                                                              ),
                                                            ),
                                                            keyboardType: TextInputType.text,
                                                            textInputAction: TextInputAction.next,
                                                            cursorColor: kPrimaryColor,
                                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                                            validator: (value) {
                                                              if (value!.isEmpty || value.trim() == '') {
                                                                return 'Enter a valid middle Name!';
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                          SizedBox(height: 10),
                                                          Text(
                                                            'Last Name',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          TextFormField(
                                                            controller: profileProvider.lastNameTEC,
                                                            decoration: InputDecoration(
                                                              hintText: "Last name",
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Colors.black),
                                                              ),
                                                            ),
                                                            keyboardType: TextInputType.text,
                                                            textInputAction: TextInputAction.next,
                                                            cursorColor: kPrimaryColor,
                                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                                            validator: (value) {
                                                              if (value!.isEmpty || value.trim() == '') {
                                                                return 'Enter a valid last Name!';
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                          SizedBox(height: 10),
                                                          Text(
                                                            'DOB',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          TextFormField(
                                                            controller: profileProvider.dobTEC,
                                                            decoration: InputDecoration(
                                                              hintText: "Date of birth",
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Colors.black),
                                                              ),
                                                            ),
                                                            keyboardType: TextInputType.datetime,
                                                            textInputAction: TextInputAction.next,
                                                            cursorColor: kPrimaryColor,
                                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                                            validator: (value) {
                                                              if (value!.isEmpty || value.trim() == '') {
                                                                return 'Enter a valid date of birth!';
                                                              }
                                                              return null;
                                                            },
                                                            onTap: () async {
                                                              final DateTime? picked = await showDatePicker(
                                                                context: context,
                                                                initialDate: DateTime.now(),
                                                                // DateTime.parse(profileProvider.profileResponse.Result.DOB) ,
                                                                firstDate: DateTime(1900),
                                                                lastDate: DateTime.now(),
                                                              );
                                                              // lastDate: DateTime(3000));
                                                              if (picked != null && picked != selectedDate) {
                                                                setState(() {
                                                                  // dobTEC.text = picked.toString();
                                                                  profileProvider.dobTEC.text =
                                                                      DateFormat('dd-MM-yyyy').format(DateTime.parse(picked.toString()));
                                                                  selectedDate = picked;
                                                                  print(
                                                                      'DOB - ${picked} & ${profileProvider.dobTEC.text} & ${selectedDate}');
                                                                });
                                                              } else {
                                                                print("Date is not selected");
                                                              }
                                                            },
                                                          ),
                                                          SizedBox(height: 10),
                                                          Text(
                                                            'Gender',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          DropdownButtonFormField<String>(
                                                            dropdownColor: Colors.white,
                                                            isExpanded: true,
                                                            value: profileProvider.genderValue,
                                                            // profileProvider.profileResponse.Result.Gender ? "Male" : "Female" ,
                                                            icon: const Icon(Icons.keyboard_arrow_down),
                                                            decoration: InputDecoration(
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Colors.black),
                                                              ),
                                                            ),
                                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                                            validator: (value) {
                                                              if (value == null || value.isEmpty || value.trim() == '') {
                                                                return 'Please select your gender';
                                                              }
                                                              return null;
                                                            },
                                                            items: items.map((String items) {
                                                              return DropdownMenuItem(
                                                                value: items,
                                                                child: Text(items),
                                                              );
                                                            }).toList(),
                                                            onChanged: (String? newValue) {
                                                              log('gender new value - $newValue');
                                                              setState(() {
                                                                profileProvider.genderValue = newValue!;
                                                              });
                                                            },
                                                          ),
                                                          /*Theme(
                                                            data: Theme.of(context).copyWith(
                                                              canvasColor: Colors.blue.shade200,
                                                            ),
                                                            child: DropdownButton(
                                                              style: TextStyle(color: Colors.black),

                                                              // Initial Value
                                                              value: dropdownvalue,

                                                              // Down Arrow Icon
                                                              icon: const Icon(Icons.keyboard_arrow_down),

                                                              // Array list of items
                                                              items: items.map((String items) {
                                                                return DropdownMenuItem(
                                                                  value: items,
                                                                  child: Text(items),
                                                                );
                                                              }).toList(),
                                                              // After selecting the desired option,it will
                                                              // change button value to selected value
                                                              onChanged: (String? newValue) {
                                                                setState(() {
                                                                  dropdownvalue = newValue!;
                                                                });
                                                              },
                                                            )),*/
                                                          SizedBox(height: 10),
                                                          Text(
                                                            'Country',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          DropdownButtonFormField<LCountry>(
                                                            dropdownColor: Colors.white,
                                                            isExpanded: true,
                                                            icon: const Icon(Icons.keyboard_arrow_down),
                                                            value: profileProvider.selectedCountry ?? null,
                                                            hint: Text('Select a country'),
                                                            decoration: InputDecoration(
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Colors.black),
                                                              ),
                                                            ),
                                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                                            validator: (value) {
                                                              if (value == null) {
                                                                return 'Please select your country';
                                                              }
                                                              return null;
                                                            },
                                                            onChanged: (LCountry? newValue) {
                                                              if (newValue != null) {
                                                                setState(() {
                                                                  profileProvider.selectedCountry = newValue;
                                                                  profileProvider.countryTEC.text = newValue.name;
                                                                });
                                                                print('Selected Country ID: ${newValue.id}');
                                                                print('Selected Country name: ${newValue.name}');
                                                              }
                                                            },
                                                            items: profileProvider.countries.map((LCountry country) {
                                                              return DropdownMenuItem<LCountry>(
                                                                value: country,
                                                                child: Text(country.name),
                                                              );
                                                            }).toList(),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Text(
                                                            'State',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          DropdownButtonFormField<LState>(
                                                            dropdownColor: Colors.white,
                                                            isExpanded: true,
                                                            icon: const Icon(Icons.keyboard_arrow_down),
                                                            value: profileProvider.selectedState ?? null,
                                                            hint: Text('Select a state'),
                                                            decoration: InputDecoration(
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Colors.black),
                                                              ),
                                                            ),
                                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                                            validator: (value) {
                                                              if (value == null) {
                                                                return 'Please select your state';
                                                              }
                                                              return null;
                                                            },
                                                            onChanged: (LState? newValue) {
                                                              if (newValue != null) {
                                                                setState(() {
                                                                  profileProvider.selectedState = newValue;
                                                                });
                                                                print('Selected State ID: ${newValue.id}');
                                                                print('Selected State name: ${newValue.name}');
                                                              }
                                                            },
                                                            items: profileProvider.states.map((LState state) {
                                                              return DropdownMenuItem<LState>(
                                                                value: state,
                                                                child: Text(state.name),
                                                              );
                                                            }).toList(),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Text(
                                                            'City',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          DropdownButtonFormField<LCity>(
                                                            dropdownColor: Colors.white,
                                                            isExpanded: true,
                                                            icon: const Icon(Icons.keyboard_arrow_down),
                                                            value: profileProvider.selectedCity ?? null,
                                                            hint: Text('Select a city'),
                                                            decoration: InputDecoration(
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Colors.black),
                                                              ),
                                                            ),
                                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                                            validator: (value) {
                                                              if (value == null) {
                                                                return 'Please select your city';
                                                              }
                                                              return null;
                                                            },
                                                            onChanged: (LCity? newValue) {
                                                              if (newValue != null) {
                                                                setState(() {
                                                                  profileProvider.selectedCity = newValue;
                                                                });
                                                                print('Selected City ID: ${newValue.id}');
                                                                print('Selected City name: ${newValue.name}');
                                                              }
                                                            },
                                                            items: profileProvider.cities.map((LCity city) {
                                                              return DropdownMenuItem<LCity>(
                                                                value: city,
                                                                child: Text(city.name),
                                                              );
                                                            }).toList(),
                                                          ),
                                                          // TextField(
                                                          //   controller: cityTEC,
                                                          //   decoration: InputDecoration(hintText: "City"),
                                                          // ),
                                                          // TextField(
                                                          //   controller: stateTEC,
                                                          //   decoration: InputDecoration(hintText: "State"),
                                                          // ),
                                                          /* Theme(
                                                        //     data: Theme.of(context).copyWith(
                                                        //       canvasColor: Colors.white,
                                                        //     ),
                                                        //     child: DropdownButton<LCountry>(
                                                        //       value: selectedCountry ?? null, // Set the selected value to null initially
                                                        //       hint: Text('Select a country'),
                                                        //       onChanged: (LCountry? newValue) {
                                                        //         if (newValue != null) {
                                                        //           setState(() {
                                                        //             selectedCountry = newValue;
                                                        //           });
                                                        //           print('Selected Country ID: ${newValue.id}');
                                                        //           print('Selected Country name: ${newValue.name}');
                                                        //         }
                                                        //       },
                                                        //       items: profileProvider.countries.map((LCountry country) {
                                                        //         return DropdownMenuItem<LCountry>(
                                                        //           value: country,
                                                        //           child: Text(country.name),
                                                        //         );
                                                        //       }).toList(),
                                                             ))*/
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('Cancel'),
                                                      onPressed: () {
                                                        setState(() {});
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text('Submit'),
                                                      onPressed: () async {
                                                        await profileProvider.updateProfile();
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                            },
                                          );
                                        },
                                        child: Text('Edit'),
                                      ),
                                      // SizedBox(
                                      //   height: 20,
                                      // )
                                    ],
                                  )),
                            )),
                        SizedBox(height: 10),
                        Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ExpansionTile(
                                    title: FxText.h6("CONTACT INFORMATION", fontSize: 18, fontWeight: 800),
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Table(
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Primary Address',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.PrimaryAddress,
                                                        textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10),
                                                    child: Text(
                                                      'Secondary Address',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10),
                                                    child: Text(profileProvider.profileResponse.Result.SecondaryAddress,
                                                        textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Email Address',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.EmailAddress,
                                                        textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Pincode',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.PinCode,
                                                        textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Mobile Number',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.MobileNo,
                                                        textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Alternate Number',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.TelephoneNo,
                                                        textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      ElevatedButton(
                                        onPressed: () async {
                                          // showContactInfo(context);
                                          // Future<void> showContactInfo(BuildContext context) async {

                                          // await fetchAlumniData();
                                          profileProvider.primaryAddTEC.text =
                                              profileProvider.profileResponse.Result.PrimaryAddress.toString();
                                          profileProvider.secondaryAddTEC.text =
                                              profileProvider.profileResponse.Result.SecondaryAddress.toString();
                                          profileProvider.emailTEC.text = profileProvider.profileResponse.Result.EmailAddress.toString();
                                          profileProvider.pincodeTEC.text = profileProvider.profileResponse.Result.PinCode.toString();
                                          profileProvider.mobileNumTEC.text = profileProvider.profileResponse.Result.MobileNo.toString();
                                          profileProvider.altMobileNumTEC.text =
                                              profileProvider.profileResponse.Result.TelephoneNo.toString();

                                          await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: FxText.h6("CONTACT INFORMATION", fontSize: 18, fontWeight: 800),
                                                content: profileProvider.showLoading
                                                    ? CircularProgressIndicator()
                                                    : SingleChildScrollView(
                                                        scrollDirection: Axis.vertical,
                                                        child: Form(
                                                          key: _contactInfo,
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Primary Address',
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ),
                                                              TextFormField(
                                                                controller: profileProvider.primaryAddTEC,
                                                                decoration: InputDecoration(
                                                                  hintText: "Primary Address",
                                                                  focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(width: 1, color: Colors.black),
                                                                  ),
                                                                ),
                                                                keyboardType: TextInputType.text,
                                                                textInputAction: TextInputAction.next,
                                                                cursorColor: kPrimaryColor,
                                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                validator: (value) {
                                                                  if (value!.isEmpty || value.trim() == '') {
                                                                    return 'Enter a valid primary address!';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              SizedBox(height: 10),
                                                              Text(
                                                                'Secondary Address',
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ),
                                                              TextFormField(
                                                                controller: profileProvider.secondaryAddTEC,
                                                                keyboardType: TextInputType.text,
                                                                decoration: InputDecoration(
                                                                  hintText: "Secondary Address",
                                                                  focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(width: 1, color: Colors.black),
                                                                  ),
                                                                ),
                                                                textInputAction: TextInputAction.next,
                                                                cursorColor: kPrimaryColor,
                                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                validator: (value) {
                                                                  if (value!.isEmpty || value.trim() == '') {
                                                                    return 'Enter a valid secondary Address!';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              SizedBox(height: 10),
                                                              Text(
                                                                'Email Address',
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ),
                                                              TextFormField(
                                                                controller: profileProvider.emailTEC,
                                                                keyboardType: TextInputType.emailAddress,
                                                                decoration: InputDecoration(
                                                                  hintText: "Email",
                                                                  focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(width: 1, color: Colors.black),
                                                                  ),
                                                                ),
                                                                textInputAction: TextInputAction.next,
                                                                cursorColor: kPrimaryColor,
                                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                validator: (value) {
                                                                  if (value!.isEmpty ||
                                                                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                                          .hasMatch(value)) {
                                                                    return 'Enter a valid email!';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              SizedBox(height: 10),
                                                              Text(
                                                                'Pincode',
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ),
                                                              TextFormField(
                                                                controller: profileProvider.pincodeTEC,
                                                                keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                  hintText: "Pincode",
                                                                  focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(width: 1, color: Colors.black),
                                                                  ),
                                                                ),
                                                                textInputAction: TextInputAction.next,
                                                                cursorColor: kPrimaryColor,
                                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                validator: (value) {
                                                                  if (value!.isEmpty || value.trim() == '') {
                                                                    return 'Enter a valid pincode!';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              SizedBox(height: 10),
                                                              Text(
                                                                'Mobile Number',
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ),
                                                              TextFormField(
                                                                controller: profileProvider.mobileNumTEC,
                                                                keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                  hintText: "Mobile Number",
                                                                  focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(width: 1, color: Colors.black),
                                                                  ),
                                                                ),
                                                                textInputAction: TextInputAction.next,
                                                                cursorColor: kPrimaryColor,
                                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                validator: (value) {
                                                                  if (value!.isEmpty || value.trim() == '') {
                                                                    return 'Enter a valid mobile number!';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              SizedBox(height: 10),
                                                              Text(
                                                                'Alternate Number',
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ),
                                                              TextFormField(
                                                                controller: profileProvider.altMobileNumTEC,
                                                                keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                  hintText: "Alternate Number",
                                                                  focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(width: 1, color: Colors.black),
                                                                  ),
                                                                ),
                                                                textInputAction: TextInputAction.next,
                                                                cursorColor: kPrimaryColor,
                                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                validator: (value) {
                                                                  if (value!.isEmpty || value.trim() == '') {
                                                                    return 'Enter a valid alternate number!';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('Submit'),
                                                    onPressed: () async {
                                                      await profileProvider.updateProfile();
                                                      Navigator.of(context).pop();
                                                      /*var encId = await globals.FlutterSecureStorageObj.read(key: "encId");
                                                        var token = await globals.FlutterSecureStorageObj.read(key: "access_token");
                                                        try {
                                                          var response = await http.post(
                                                              Uri.parse(globals.BASE_API_URL + '/Alumni/Update?EncryptedId=$encId'),
                                                              headers: <String, String>{
                                                                "Authorization": "Bearer $token",
                                                                "Content-type": "application/json"
                                                              },
                                                              body: jsonEncode({
                                                                'PrimaryAddress': primaryAddTEC.text,
                                                                'SecondaryAddress': secondaryAddTEC.text,
                                                                'EmailAddress': emailTEC.text,
                                                                'PinCode': pincodeTEC.text,
                                                                'MobileNo': mobileNumTEC.text,
                                                                'TelephoneNo': altMobileNumTEC.text,
                                                              }));
                                                          if (response.statusCode == 200) {
                                                            // await fetchAlumniData();
                                                            Navigator.pop(context);
                                                          } else {
                                                            print('Failed to update data. Status code: ${response.statusCode}');
                                                          }
                                                        } catch (e) {
                                                          print('Failed to update data. $e');
                                                        }*/
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          // }
                                        },
                                        child: Text('Edit'),
                                      ),
                                    ],
                                  )),
                            )),
                        SizedBox(height: 10),
                        Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ExpansionTile(
                                    title: FxText.h6("COMPANY INFORMATION", fontSize: 18, fontWeight: 800),
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Table(
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Current Company',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.CompanyName,
                                                        textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10),
                                                    child: Text(
                                                      'Company Address',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10),
                                                    child: Text(profileProvider.profileResponse.Result.CompanyAddress,
                                                        textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Current Designation',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.Designation,
                                                        textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      ElevatedButton(
                                        onPressed: () async {
                                          profileProvider.companyNameTEC.text =
                                              profileProvider.profileResponse.Result.CompanyName.toString();
                                          profileProvider.companyAddTEC.text =
                                              profileProvider.profileResponse.Result.CompanyAddress.toString();
                                          profileProvider.designationTEC.text =
                                              profileProvider.profileResponse.Result.Designation.toString();

                                          await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: FxText.h6("COMPANY INFORMATION", fontSize: 18, fontWeight: 800),
                                                content: profileProvider.showLoading
                                                    ? CircularProgressIndicator()
                                                    : SingleChildScrollView(
                                                        scrollDirection: Axis.vertical,
                                                        child: Form(
                                                          key: _contactInfo,
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Current Company',
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ),
                                                              TextFormField(
                                                                controller: profileProvider.companyNameTEC,
                                                                decoration: InputDecoration(
                                                                  hintText: "Current Company",
                                                                  focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(width: 1, color: Colors.black),
                                                                  ),
                                                                ),
                                                                keyboardType: TextInputType.text,
                                                                textInputAction: TextInputAction.next,
                                                                cursorColor: kPrimaryColor,
                                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                validator: (value) {
                                                                  if (value!.isEmpty || value.trim() == '') {
                                                                    return 'Enter a valid current company name!';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              SizedBox(height: 10),
                                                              Text(
                                                                'Company Address',
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ),
                                                              TextFormField(
                                                                controller: profileProvider.companyAddTEC,
                                                                keyboardType: TextInputType.text,
                                                                decoration: InputDecoration(
                                                                  hintText: "Company Address",
                                                                  focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(width: 1, color: Colors.black),
                                                                  ),
                                                                ),
                                                                textInputAction: TextInputAction.next,
                                                                cursorColor: kPrimaryColor,
                                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                validator: (value) {
                                                                  if (value!.isEmpty || value.trim() == '') {
                                                                    return 'Enter a valid company Address!';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                              SizedBox(height: 10),
                                                              Text(
                                                                'Current Designation',
                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                              ),
                                                              TextFormField(
                                                                controller: profileProvider.designationTEC,
                                                                keyboardType: TextInputType.text,
                                                                decoration: InputDecoration(
                                                                  hintText: "Current Designation",
                                                                  focusedBorder: UnderlineInputBorder(
                                                                    borderSide: BorderSide(width: 1, color: Colors.black),
                                                                  ),
                                                                ),
                                                                textInputAction: TextInputAction.next,
                                                                cursorColor: kPrimaryColor,
                                                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                                                validator: (value) {
                                                                  if (value!.isEmpty || value.trim() == '') {
                                                                    return 'Enter a valid company Address!';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('Submit'),
                                                    onPressed: () async {
                                                      await profileProvider.updateProfile();
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          // }
                                        },
                                        child: Text('Edit'),
                                      ),
                                    ],
                                  )),
                            )),
                        SizedBox(height: 10),
                        Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ExpansionTile(
                                    title: FxText.h6("ACADEMIC INFORMATION", fontSize: 18, fontWeight: 800),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Table(
                                          children: [
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(
                                                    'Program',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(profileProvider.profileResponse.Result.DegreeName,
                                                      textAlign: TextAlign.left, style: TextStyle(fontSize: 15)), //'B.E.'
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10),
                                                  child: Text(
                                                    'Passout Year',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10),
                                                  child: Text(profileProvider.profileResponse.Result.PassoutYear,
                                                      textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(
                                                    'Branch',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                  child: Text(profileProvider.profileResponse.Result.StreamName,
                                                      textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          // profileProvider.passoutYearTEC.text =
                                          //     profileProvider.profileResponse.Result.PassoutYear.toString();
                                          // profileProvider.degreeNameTEC.text = profileProvider.profileResponse.Result.DegreeName.toString();
                                          // profileProvider.streamNameTEC.text = profileProvider.profileResponse.Result.StreamName.toString();
                                          setState(() {
                                            profileProvider.programs.map((LProgram program) {
                                              if (program.name.toString() == profileProvider.profileResponse.Result.DegreeName.toString()) {
                                                log("Program Name -${program.id} ${program.name}");
                                                profileProvider.selectedProgram = program;
                                              }
                                            }).toList();
                                            profileProvider.branches.map((LBranch branch) {
                                              if (branch.name.toString() == profileProvider.profileResponse.Result.StreamName.toString()) {
                                                profileProvider.selectedBranch = branch;
                                              }
                                            }).toList();
                                          });

                                          await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                                return AlertDialog(
                                                  title: FxText.h6("ACADEMIC INFORMATION", fontSize: 18, fontWeight: 800),
                                                  content: SingleChildScrollView(
                                                    scrollDirection: Axis.vertical,
                                                    child: Form(
                                                      key: _academicInfo,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Passout Year',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          TextFormField(
                                                            controller: profileProvider.passoutYearTEC,
                                                            decoration: InputDecoration(
                                                              hintText: "Passout year",
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Colors.black),
                                                              ),
                                                            ),
                                                            keyboardType: TextInputType.datetime,
                                                            textInputAction: TextInputAction.next,
                                                            cursorColor: kPrimaryColor,
                                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                                            validator: (value) {
                                                              if (value!.isEmpty || value.trim() == '') {
                                                                return 'Enter a valid passout year!';
                                                              }
                                                              return null;
                                                            },
                                                            onTap: () async {
                                                              var passoutYear = profileProvider.passoutYearTEC;
                                                              await selectYear(context, passoutYear);
                                                              /* final DateTime? picked = await showDatePicker(
                                                                context: context,
                                                                initialDatePickerMode: DatePickerMode.year,
                                                                initialEntryMode:  DatePickerEntryMode.calendarOnly,
                                                                initialDate: DateTime.now(),
                                                                firstDate: DateTime(1900),
                                                                lastDate: DateTime.now(),
                                                              );
                                                              // lastDate: DateTime(3000));
                                                              if (picked != null && picked != selectedDate) {
                                                                setState(() {
                                                                  // dobTEC.text = picked.toString();
                                                                  profileProvider.passoutYearTEC.text =
                                                                      DateFormat('yyyy').format(DateTime.parse(picked.toString()));
                                                                  selectedYear = picked;
                                                                });
                                                              }*/
                                                              /*final YearPicker picked = await YearPicker(
                                                                  // context: context,
                                                                  firstDate: DateTime(1900),
                                                                  lastDate: DateTime(DateTime.now().year),
                                                                  selectedDate: selectedYear,
                                                                  onChanged: (DateTime dateTime) {
                                                                    setState(
                                                                      () {
                                                                        selectedYear = dateTime;
                                                                      },
                                                                    );
                                                                  });

                                                              final DateTime? pickedYear = await showYearPicker(
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                      title: Text('Select Year'),
                                                                      content: YearPicker(
                                                                          // context: context,
                                                                          firstDate: DateTime(1900),
                                                                          lastDate: DateTime(DateTime.now().year),
                                                                          selectedDate: selectedYear,
                                                                          onChanged: (DateTime dateTime) {
                                                                            setState(
                                                                              () {
                                                                                selectedYear = dateTime;
                                                                              },
                                                                            );
                                                                          }));
                                                                },
                                                              );
                                                              // lastDate: DateTime(3000));
                                                              if (picked != null && picked != selectedDate) {
                                                                setState(() {
                                                                  // dobTEC.text = picked.toString();
                                                                  profileProvider.passoutYearTEC.text =
                                                                      DateFormat('yyyy').format(DateTime.parse(picked.toString()));
                                                                  selectedDate = picked;
                                                                });
                                                              }*/
                                                            },
                                                          ),
                                                          SizedBox(height: 10),
                                                          Text(
                                                            'Program',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          DropdownButtonFormField<LProgram>(
                                                            dropdownColor: Colors.white,
                                                            isExpanded: true,
                                                            icon: const Icon(Icons.keyboard_arrow_down),
                                                            value: profileProvider.selectedProgram ?? null,
                                                            hint: Text('Select a program'),
                                                            decoration: InputDecoration(
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Colors.black),
                                                              ),
                                                            ),
                                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                                            validator: (value) {
                                                              if (value == null) {
                                                                return 'Please select your program';
                                                              }
                                                              return null;
                                                            },
                                                            onChanged: (LProgram? newValue) {
                                                              if (newValue != null) {
                                                                setState(() {
                                                                  profileProvider.selectedProgram = newValue;
                                                                });
                                                                print('Selected Program ID: ${newValue.id}');
                                                                print('Selected Program name: ${newValue.name}');
                                                              }
                                                            },
                                                            items: profileProvider.programs.map((LProgram program) {
                                                              return DropdownMenuItem<LProgram>(
                                                                value: program,
                                                                child: Text(program.name),
                                                              );
                                                            }).toList(),
                                                          ),
                                                          SizedBox(height: 10),
                                                          Text(
                                                            'Branch',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          DropdownButtonFormField<LBranch>(
                                                            dropdownColor: Colors.white,
                                                            isExpanded: true,
                                                            icon: const Icon(Icons.keyboard_arrow_down),
                                                            value: profileProvider.selectedBranch ?? null,
                                                            hint: Text('Select a branch'),
                                                            decoration: InputDecoration(
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Colors.black),
                                                              ),
                                                            ),
                                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                                            validator: (value) {
                                                              if (value == null) {
                                                                return 'Please select your branch';
                                                              }
                                                              return null;
                                                            },
                                                            onChanged: (LBranch? newValue) {
                                                              if (newValue != null) {
                                                                setState(() {
                                                                  profileProvider.selectedBranch = newValue;
                                                                });
                                                                print('Selected Branch ID: ${newValue.id}');
                                                                print('Selected Branch name: ${newValue.name}');
                                                              }
                                                            },
                                                            items: profileProvider.branches.map((LBranch branch) {
                                                              return DropdownMenuItem<LBranch>(
                                                                value: branch,
                                                                child: Text(branch.name),
                                                              );
                                                            }).toList(),
                                                          ),

                                                          /*SizedBox(height: 10),
                                                          Text(
                                                            'City',
                                                            style: TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                          DropdownButtonFormField<LCity>(
                                                            dropdownColor: Colors.white,
                                                            isExpanded: true,
                                                            icon: const Icon(Icons.keyboard_arrow_down),
                                                            value: selectedCity ?? null,
                                                            hint: Text('Select a city'),
                                                            decoration: InputDecoration(
                                                              focusedBorder: UnderlineInputBorder(
                                                                borderSide: BorderSide(width: 1, color: Colors.black),
                                                              ),
                                                            ),
                                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                                            validator: (value) {
                                                              if (value == null) {
                                                                return 'Please select your city';
                                                              }
                                                              return null;
                                                            },
                                                            onChanged: (LCity? newValue) {
                                                              if (newValue != null) {
                                                                setState(() {
                                                                  selectedCity = newValue;
                                                                });
                                                                print('Selected City ID: ${newValue.id}');
                                                                print('Selected City name: ${newValue.name}');
                                                              }
                                                            },
                                                            items: profileProvider.cities.map((LCity city) {
                                                              return DropdownMenuItem<LCity>(
                                                                value: city,
                                                                child: Text(city.name),
                                                              );
                                                            }).toList(),
                                                          ),
                                                          */
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('Cancel'),
                                                      onPressed: () {
                                                        setState(() {});
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text('Submit'),
                                                      onPressed: () async {
                                                        await profileProvider.updateProfile();
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                            },
                                          );
                                        },
                                        child: Text('Edit'),
                                      ),
                                    ],
                                  )),
                            )),
                        SizedBox(height: 10),
                        Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ExpansionTile(
                                    title: FxText.h6("MEMBERSHIP INFORMATION", fontSize: 18, fontWeight: 800),
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Table(
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Membership',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.Membership.toString(),
                                                        textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    // padding: EdgeInsets.only(bottom: 8), // Adjust the padding as needed
                                                    child: Text(
                                                      'Membership Verification Status',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(top: 8.0), // Adjust the padding as needed
                                                    child: Text(
                                                        profileProvider.profileResponse.Result.IsMembershipVerified
                                                            ? "Verified"
                                                            : "Not Verified",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      // ElevatedButton(
                                      //   onPressed: () {
                                      //     showMembershipInfo(context);
                                      //   },
                                      //   child: Text('Edit'),
                                      // ),

                                      // SizedBox(
                                      //   height: 20,
                                      // ),
                                    ],
                                  )),
                            )),
                      ]),
                    )),
                  ],
                ),
              ),
            );
    });
  }
}
