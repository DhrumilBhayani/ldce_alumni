// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ldce_alumni/controllers/profile/profile_controller.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/models/country.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:ldce_alumni/views/widgets/app_bar_widget.dart';
import 'package:ldce_alumni/views/widgets/app_drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  late ThemeData theme;
  late CustomTheme customTheme;

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

  late Country selectedCountry;

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

  late File _image;
  Future<void> uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

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
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-type": "multipart/form-data"
    };
    request.headers.addAll(headers);

    try {
      var response = await request.send();
      var response1 = await http.Response.fromStream(response);

      print("Response status: ${response1.body}");
      if (response.statusCode == 200) {
        var profile = new ProfileController();
        profile.getProfile();
        print('Image uploaded successfully'); //
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    const kSpacingUnit = 10;
    return Consumer2<AppNotifier, ProfileController>(builder:
        (BuildContext context, AppNotifier value, profileProvider,
            Widget? child) {
      return profileProvider.showLoading
          ? Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
              ),
              backgroundColor: customTheme.card,
              body: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 20),
                  child: LoadingEffect.getProfileLoadingScreen(
                    context,
                  )))
          : Scaffold(
              key: _key,
              appBar: AppBarWidget(
                scaffoldKey: _key,
                // title: "About US",
              ),
              endDrawer: AppDrawerWidget(),
              body: SingleChildScrollView(
                // controller: controller,
                child: Column(
                  children: <Widget>[
                    Container(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: profileProvider
                                      .profileResponse.Result.ProfilePicPath !=
                                  ""
                              ? 0
                              : 20),
                      child: Column(children: <Widget>[
                        if (profileProvider
                                .profileResponse.Result.ProfilePicPath !=
                            "")
                          Container(
                            height: kSpacingUnit * 10,
                            width: kSpacingUnit * 10,
                            margin: EdgeInsets.only(top: kSpacingUnit * 3),
                            child: Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: kSpacingUnit * 5,
                                  backgroundImage: NetworkImage('https://' +
                                      profileProvider
                                          .profileResponse.Result.ProfilePicPath
                                          .toString()),
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
                        ElevatedButton(
                          onPressed: uploadImage,
                          child: Text('Upload Image'),
                        ),
                        SizedBox(height: 10),
                        SizedBox(height: 10),
                        Text(
                          profileProvider.profileResponse.Result.FullName
                              .toString(),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          profileProvider.profileResponse.Result.EmailAddress
                              .toString(),
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
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ExpansionTile(
                                    initiallyExpanded: true,
                                    title: FxText.h6("MEMBERSHIP INFORMATION",
                                        fontSize: 18, fontWeight: 800),
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Table(
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Membership',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                        profileProvider
                                                            .profileResponse
                                                            .Result
                                                            .Membership
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15)),
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
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top:
                                                            8.0), // Adjust the padding as needed
                                                    child: Text(
                                                        profileProvider
                                                                .profileResponse
                                                                .Result
                                                                .IsMembershipVerified
                                                            ? "Verified"
                                                            : "Not Verified",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      ElevatedButton(
                                        onPressed: () {
                                          showMembershipInfo(context);
                                        },
                                        child: Text('Edit'),
                                      ),

                                      // SizedBox(
                                      //   height: 20,
                                      // ),
                                    ],
                                  )),
                            )),
                        SizedBox(height: 10),
                        Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ExpansionTile(
                                    initiallyExpanded: true,
                                    title: FxText.h6("PERSONAL INFORMATION",
                                        fontSize: 18, fontWeight: 800),
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Table(
                                          children: [
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          10), // Adjust the padding as needed
                                                  child: Text(
                                                    'Full Name',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          10), // Adjust the padding as needed
                                                  child: Text(
                                                      profileProvider
                                                          .profileResponse
                                                          .Result
                                                          .FullName
                                                          .toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Text(
                                                    'DOB',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Text(
                                                      profileProvider
                                                          .profileResponse
                                                          .Result
                                                          .DOB
                                                          .toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          10), // Adjust the padding as needed
                                                  child: Text(
                                                    'Gender',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          10), // Adjust the padding as needed
                                                  child: Text(
                                                      profileProvider
                                                          .profileResponse
                                                          .Result
                                                          .Gender
                                                          .toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          10), // Adjust the padding as needed
                                                  child: Text(
                                                    'City',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          10), // Adjust the padding as needed
                                                  child: Text(
                                                      profileProvider
                                                          .profileResponse
                                                          .Result
                                                          .CityId
                                                          .toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          10), // Adjust the padding as needed
                                                  child: Text(
                                                    'State',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          10), // Adjust the padding as needed
                                                  child: Text(
                                                      profileProvider
                                                          .profileResponse
                                                          .Result
                                                          .StateId
                                                          .toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          10), // Adjust the padding as needed
                                                  child: Text(
                                                    'Country',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          10), // Adjust the padding as needed
                                                  child: Text(
                                                      profileProvider
                                                          .profileResponse
                                                          .Result
                                                          .CountryId
                                                          .toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          // showPersonalInfo(context);
                                          fullNameTEC.text = profileProvider
                                              .profileResponse.Result.FullName
                                              .toString();
                                          dobTEC.text = profileProvider
                                              .profileResponse.Result.DOB
                                              .toString();
                                          genderTEC.text = profileProvider
                                              .profileResponse.Result.Gender
                                              .toString();
                                          cityTEC.text = profileProvider
                                              .profileResponse.Result.CityId
                                              .toString();
                                          stateTEC.text = profileProvider
                                              .profileResponse.Result.StateId
                                              .toString();
                                          countryTEC.text = profileProvider
                                              .profileResponse.Result.CountryId
                                              .toString();
                                          log('Contry - ${profileProvider.country[0]}');
                                          await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Personal Information'),
                                                content: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Full Name'),
                                                      TextField(
                                                        controller: fullNameTEC,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    "Full Name "),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text('DOB'),
                                                      TextField(
                                                        controller: dobTEC,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                "Date of birth"),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text('Gender'),
                                                      TextField(
                                                        controller: genderTEC,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    "Gender"),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text('City'),
                                                      TextField(
                                                        controller: cityTEC,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    "City"),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text('State'),
                                                      TextField(
                                                        controller: stateTEC,
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    "State"),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text('Country'),
                                                      // TextField(
                                                      //   controller: countryTEC,
                                                      //   decoration:
                                                      //       InputDecoration(
                                                      //           hintText:
                                                      //               "Country"),
                                                      // ),
                                                      DropdownButtonFormField(
                                                        // value: profileProvider
                                                        //     .country[0],
                                                        items: profileProvider
                                                            .country.map((Country
                                                                    country) =>
                                                                DropdownMenuItem(
                                                                    child: Text(
                                                                        'Country'))),
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            // selectedUser =
                                                            //     newValue;
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
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
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ExpansionTile(
                                    title: FxText.h6("CONTACT INFORMATION",
                                        fontSize: 18, fontWeight: 800),
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Table(
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Primary Address',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                        profileProvider
                                                            .profileResponse
                                                            .Result
                                                            .PrimaryAddress,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Text(
                                                      'Secondary Address',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Text(
                                                        profileProvider
                                                            .profileResponse
                                                            .Result
                                                            .SecondaryAddress,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Email Address',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                        profileProvider
                                                            .profileResponse
                                                            .Result
                                                            .EmailAddress,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Pincode',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                        profileProvider
                                                            .profileResponse
                                                            .Result
                                                            .PinCode,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Mobile Number',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                        profileProvider
                                                            .profileResponse
                                                            .Result
                                                            .MobileNo,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Alternate Number',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                        profileProvider
                                                            .profileResponse
                                                            .Result
                                                            .TelephoneNo,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      ElevatedButton(
                                        onPressed: () {
                                          showContactInfo(context);
                                        },
                                        child: Text('Edit'),
                                      ),
                                    ],
                                  )),
                            )),
                        SizedBox(height: 10),
                        Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ExpansionTile(
                                    title: FxText.h6("COMPANY INFORMATION",
                                        fontSize: 18, fontWeight: 800),
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Table(
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Current Company',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                        profileProvider
                                                            .profileResponse
                                                            .Result
                                                            .CompanyName,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Text(
                                                      'Company Address',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Text(
                                                        profileProvider
                                                            .profileResponse
                                                            .Result
                                                            .CompanyAddress,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Current Designation',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                        profileProvider
                                                            .profileResponse
                                                            .Result
                                                            .Designation,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  )),
                            )),
                        SizedBox(height: 10),
                        Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ExpansionTile(
                                    title: FxText.h6("ACADEMIC INFORMATION",
                                        fontSize: 18, fontWeight: 800),
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Table(
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Program',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text('B.E.',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Text(
                                                      'Passout Year',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Text(
                                                        profileProvider
                                                            .profileResponse
                                                            .Result
                                                            .PassoutYear,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Branch',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                            10), // Adjust the padding as needed
                                                    child: Text(
                                                        'Information Technology',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
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

  Map<String, dynamic> alumni = {};
  Future<void> fetchAlumniData() async {
    var encId = await globals.FlutterSecureStorageObj.read(key: "encId");
    final response = await http
        .get(Uri.parse(globals.BASE_API_URL + '/alumni?EncryptedId=$encId'));
    if (response.statusCode == 200) {
      setState(() {
        alumni = json.decode(response.body)['Result'];
        log('alumni data: - ${alumni}');
      });
    } else {
      print(
          'Failed to fetch current data. Status code: ${response.statusCode}');
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
                    decoration:
                        InputDecoration(hintText: "Enter your input here"),
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
                    decoration:
                        InputDecoration(hintText: "Enter your input here"),
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
                  // DropdownButtonFormField<String>(
                  //   value: _selectedCountry,
                  //   items: _countryList.map((String country) {
                  //     return DropdownMenuItem<String>(
                  //       value: country,
                  //       child: Text(country),
                  //     );
                  //   }).toList(),
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       _selectedCountry = newValue!;
                  //       _selectedState = '';
                  //       _selectedCity = '';
                  //       _stateList = [];
                  //       _cityList = [];
                  //       _loadStateData(_selectedCountry);
                  //     });
                  //   },
                  //   decoration: InputDecoration(labelText: 'Country'),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please select your country';
                  //     }
                  //     return null;
                  //   },
                  // ),
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
                var encId =
                    await globals.FlutterSecureStorageObj.read(key: "encId");
                var token = await globals.FlutterSecureStorageObj.read(
                    key: "access_token");
                try {
                  alumni['FullName'] = fullNameTEC.text;
                  alumni['DOB'] = dobTEC.text;
                  alumni['Gender'] = genderTEC.text;
                  alumni['CityName'] = cityTEC.text;
                  alumni['StateName'] = stateTEC.text;
                  alumni['CountryName'] = countryTEC.text;
                  log('FullName data - ${alumni['FullName']}');
                  log('Update data - $alumni');
                  var response = await http.post(
                      Uri.parse(globals.BASE_API_URL +
                          '/Alumni/Update?EncryptedId=$encId'),
                      headers: <String, String>{
                        "Authorization": "Bearer $token",
                        "Content-type": "application/json"
                      },
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
                    print(
                        'Failed to update data. Status code: ${response.statusCode}');
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
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
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
                var encId =
                    await globals.FlutterSecureStorageObj.read(key: "encId");
                var token = await globals.FlutterSecureStorageObj.read(
                    key: "access_token");
                try {
                  var response = await http.post(
                      Uri.parse(globals.BASE_API_URL +
                          '/Alumni/Update?EncryptedId=$encId'),
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
                    await fetchAlumniData();
                    Navigator.pop(context);
                  } else {
                    print(
                        'Failed to update data. Status code: ${response.statusCode}');
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
}
