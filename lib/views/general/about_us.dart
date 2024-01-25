// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:ldce_alumni/views/widgets/app_bar_widget.dart';
import 'package:ldce_alumni/views/widgets/app_drawer_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatefulWidget {
  AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final ThemeData theme = AppTheme.theme;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: EdgeInsets.all(24),
              child: Column(children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 0),
                      child: FxText.h6("About Us", color: Color(0xffd32a27), fontWeight: 800),
                    )),
                Divider(
                  height: 1.5,
                  color: theme.dividerColor,
                  thickness: 1,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      child: FxText.h5(
                          "\nLDCE Alumni Association(LAA) was established in 1996 with aim to To promote fellowship among alumni, exchange ideas, spread knowledge, stimulate thinking and help L.D. College of Engineering to provide excellence in the field of Engineering\n\nThe main objectives of the association are :",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              )
                          // style: AppTheme.getTextStyle(
                          //     themeData.textTheme.bodyText2,
                          //     color: themeData.colorScheme.onBackground,
                          //     fontWeight: 600,
                          //     muted: true),
                          ),
                    )),
                // Container(
                //   margin: EdgeInsets.only(top: 10),
                //   child: Text(
                //     "To promote fellowship among alumni, exchange ideas, spread knowledge, stimulate thinking and help L.D. College of Engineering to provide excellence in the field of Engineering",
                //     textAlign: TextAlign.justify,
                //     // style: AppTheme.getTextStyle(
                //     //     themeData.textTheme.bodyText2,
                //     //     color: themeData.colorScheme.onBackground,
                //     //     fontWeight: 600,
                //     //     muted: true),
                //   ),
                // ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    child: FxText.h6("MAINTAIN CONTACT",
                        fontSize: 18, color: Color(0xffd32a27), fontWeight: 800),
                  ),
                ),

                Divider(
                  height: 1.5,
                  color: theme.dividerColor,
                  thickness: 1,
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 20),
                //   child: Text("Transforming Engineering For Human Happiness           ",
                //       textAlign: TextAlign.start,
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       )
                //       // style: AppTheme.getTextStyle(
                //       //     themeData.textTheme.bodyText2,
                //       //     color: themeData.colorScheme.onBackground,
                //       //     fontWeight: 600,
                //       //     muted: true),
                //       ),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "To establish and maintain contact among past students, present students and the teaching staff of LDCE Alumni.",
                    textAlign: TextAlign.justify,
                    // style: AppTheme.getTextStyle(
                    //     themeData.textTheme.bodyText2,
                    //     color: themeData.colorScheme.onBackground,
                    //     fontWeight: 600,
                    //     muted: true),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    child: FxText.h6("GLOBAL STANDARDS",
                        fontSize: 18, color: Color(0xffd32a27), fontWeight: 800),
                  ),
                ),

                Divider(
                  height: 1.5,
                  color: theme.dividerColor,
                  thickness: 1,
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 20),
                //   child: Text("Transforming Engineering For Human Happiness           ",
                //       textAlign: TextAlign.start,
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       )
                //       // style: AppTheme.getTextStyle(
                //       //     themeData.textTheme.bodyText2,
                //       //     color: themeData.colorScheme.onBackground,
                //       //     fontWeight: 600,
                //       //     muted: true),
                //       ),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "To raise and maintain high standards of education by interaction commerce.",
                    textAlign: TextAlign.justify,
                    // style: AppTheme.getTextStyle(
                    //     themeData.textTheme.bodyText2,
                    //     color: themeData.colorScheme.onBackground,
                    //     fontWeight: 600,
                    //     muted: true),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    child: FxText.h6("INDUSTRY INTERACTION",
                        fontSize: 18, color: Color(0xffd32a27), fontWeight: 800),
                  ),
                ),

                Divider(
                  height: 1.5,
                  color: theme.dividerColor,
                  thickness: 1,
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 20),
                //   child: Text("Transforming Engineering For Human Happiness           ",
                //       textAlign: TextAlign.start,
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       )
                //       // style: AppTheme.getTextStyle(
                //       //     themeData.textTheme.bodyText2,
                //       //     color: themeData.colorScheme.onBackground,
                //       //     fontWeight: 600,
                //       //     muted: true),
                //       ),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "To establish interaction with industry for the benefit of students.",
                    textAlign: TextAlign.justify,
                    // style: AppTheme.getTextStyle(
                    //     themeData.textTheme.bodyText2,
                    //     color: themeData.colorScheme.onBackground,
                    //     fontWeight: 600,
                    //     muted: true),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    child: FxText.h6("FINANCIAL ASSISTANCE",
                        fontSize: 18, color: Color(0xffd32a27), fontWeight: 800),
                  ),
                ),

                Divider(
                  height: 1.5,
                  color: theme.dividerColor,
                  thickness: 1,
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 20),
                //   child: Text("Transforming Engineering For Human Happiness           ",
                //       textAlign: TextAlign.start,
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       )
                //       // style: AppTheme.getTextStyle(
                //       //     themeData.textTheme.bodyText2,
                //       //     color: themeData.colorScheme.onBackground,
                //       //     fontWeight: 600,
                //       //     muted: true),
                //       ),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "To extend financial assistance to the deserving present and past students of the University for academic purposes.",
                    textAlign: TextAlign.justify,
                    // style: AppTheme.getTextStyle(
                    //     themeData.textTheme.bodyText2,
                    //     color: themeData.colorScheme.onBackground,
                    //     fontWeight: 600,
                    //     muted: true),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    child: FxText.h6("Address", fontSize: 18, color: Color(0xffd32a27), fontWeight: 800),
                  ),
                ),

                Divider(
                  height: 1.5,
                  color: theme.dividerColor,
                  thickness: 1,
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 20),
                //   child: Text("Transforming Engineering For Human Happiness           ",
                //       textAlign: TextAlign.start,
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //       )
                //       // style: AppTheme.getTextStyle(
                //       //     themeData.textTheme.bodyText2,
                //       //     color: themeData.colorScheme.onBackground,
                //       //     fontWeight: 600,
                //       //     muted: true),
                //       ),
                // ),
                Container(
                  // padding: EdgeInsets.all(16),
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                // decoration: BoxDecoration(
                                //     color: theme.colorScheme.primary.withAlpha(24),
                                //     borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: Icon(
                                  MdiIcons.officeBuilding,
                                  size: 20,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [],
                              ),
                              FxText.caption(
                                  "LDCE Alumni Association,\n637,Mechanical Department,\nL.D. College of Engineering,\nNavrangpura, Ahmedabad-380015.",
                                  fontSize: 14,
                                  fontWeight: 600,
                                  color: theme.colorScheme.onBackground),
                              // Container(
                              //   margin: EdgeInsets.only(top: 2),
                              //   child: FxText.caption("SEAS, Ahmedabad University",
                              //       fontWeight: 500,
                              //       color: theme.colorScheme.onBackground,
                              //       xMuted: true),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(16),
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                // decoration: BoxDecoration(
                                //     color: theme.colorScheme.primary.withAlpha(24),
                                //     borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: Icon(
                                  MdiIcons.email,
                                  size: 20,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [],
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: theme.colorScheme.primary,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  text: "secretary@ldcealumni.net",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      final url = 'mailto:secretary@ldcealumni.net';
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                                await launchUrl(Uri.parse(url));
                                              }
                                    },
                                ),
                              ),
                              // FxText.caption("secretary@ldcealumni.net",
                              //     fontSize: 14,
                              //     fontWeight: 600,
                              //     color: theme.colorScheme.onBackground),
                              // Container(
                              //   margin: EdgeInsets.only(top: 2),
                              //   child: FxText.caption("SEAS, Ahmedabad University",
                              //       fontWeight: 500,
                              //       color: theme.colorScheme.onBackground,
                              //       xMuted: true),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
              ]),
            )),
          ],
        ),
      ),
    );
  }
}
