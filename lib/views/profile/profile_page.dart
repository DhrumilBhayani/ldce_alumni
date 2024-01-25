// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ldce_alumni/controllers/profile/profile_controller.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:ldce_alumni/views/widgets/app_bar_widget.dart';
import 'package:ldce_alumni/views/widgets/app_drawer_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  late ThemeData theme;
  late CustomTheme customTheme;
  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.white,
    //   statusBarIconBrightness: Brightness.dark
    // ));
  }

  @override
  Widget build(BuildContext context) {
    const kSpacingUnit = 10;
    return Consumer2<AppNotifier, ProfileController>(
        builder: (BuildContext context, AppNotifier value, profileProvider, Widget? child) {
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
              endDrawer: AppDrawerWidget(),
              body: SingleChildScrollView(
                // controller: controller,
                child: Column(
                  children: <Widget>[
                    Container(
                        child: Padding(
                      padding: EdgeInsets.only(left: 24, right: 24,top:profileProvider.profileResponse.Result.ProfilePicPath !=""?0:20),
                      child: Column(children: <Widget>[
                         if (profileProvider.profileResponse.Result.ProfilePicPath !="") 
                         Container(
                          height: kSpacingUnit * 10,
                          width: kSpacingUnit * 10,
                          margin: EdgeInsets.only(top: kSpacingUnit * 3),
                          child: Stack(
                            children: <Widget>[
                             
                              CircleAvatar(
                                radius: kSpacingUnit * 5,
                                backgroundImage: NetworkImage(
                                    profileProvider.profileResponse.Result.ProfilePicPath.toString()  ),
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
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                        SizedBox(
                          height: 20,
                        ),
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
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Membership',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.Membership.toString(),
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
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
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 8.0), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.IsMembershipVerified?"Verified":"Not Verified",
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      // SizedBox(
                                      //   height: 20,
                                      // ),
                                    ],
                                  )),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ExpansionTile(
                                    initiallyExpanded: true,
                                    title:
                                        FxText.h6("PERSONAL INFORMATION", fontSize: 18, fontWeight: 800),
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Table(
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Full Name',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.FullName.toString(),
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
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
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10),
                                                    child: Text(profileProvider.profileResponse.Result.DOB.toString(),
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Gender',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.Gender.toString(),
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'City',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text('Ahmedabad',
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'State',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text('Gujarat',
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Country',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text('India',
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      // SizedBox(
                                      //   height: 20,
                                      // )
                                    ],
                                  )),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ExpansionTile(
                                    title:
                                        FxText.h6("CONTACT INFORMATION", fontSize: 18, fontWeight: 800),
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Table(
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Primary Address',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.PrimaryAddress,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
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
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10),
                                                    child: Text(profileProvider.profileResponse.Result.SecondaryAddress,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Email Address',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.EmailAddress,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Pincode',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.PinCode,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Mobile Number',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.MobileNo,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Alternate Number',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.TelephoneNo,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  )),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ExpansionTile(
                                    title:
                                        FxText.h6("COMPANY INFORMATION", fontSize: 18, fontWeight: 800),
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Table(
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Current Company',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.CompanyName,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
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
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10),
                                                    child: Text(profileProvider.profileResponse.Result.CompanyAddress,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Current Designation',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(profileProvider.profileResponse.Result.Designation,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  )),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ExpansionTile(
                                    title:
                                        FxText.h6("ACADEMIC INFORMATION", fontSize: 18, fontWeight: 800),
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Table(
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Program',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text('B.E.',
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
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
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(bottom: 10),
                                                    child: Text(profileProvider.profileResponse.Result.PassoutYear,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text(
                                                      'Branch',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold, fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10), // Adjust the padding as needed
                                                    child: Text('Information Technology',
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(fontSize: 15)),
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
}
