// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:ldce_alumni/views/widgets/app_bar_widget.dart';
import 'package:ldce_alumni/views/widgets/app_drawer_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberShipTypes extends StatefulWidget {
  MemberShipTypes({Key? key}) : super(key: key);

  @override
  State<MemberShipTypes> createState() => _MemberShipTypesState();
}

class _MemberShipTypesState extends State<MemberShipTypes> {
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
                  height: 10,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 0),
                      child: FxText.h6("Membership Types", color: Color(0xffd32a27), fontWeight: 800),
                    )),
                Divider(
                  height: 1.5,
                  color: theme.dividerColor,
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: customTheme.card,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                            color: customTheme.shadowColor.withAlpha(120),
                            blurRadius: 24,
                            spreadRadius: 4)
                      ]),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Container(
                            //   margin: EdgeInsets.only(top: 16),
                            //   child: Row(
                            //     children: [
                            //       FxText.caption(widget.date,
                            //           fontSize: 15,
                            //           color: theme.colorScheme.onBackground,
                            //           fontWeight: 600,
                            //           xMuted: true),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Container(
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                    text:
                                        "If you are already LDCE Alumni Association member but do not see your name in LDCE Alumni Directory then please write to"),
                                TextSpan(
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                    text: " portal.admin@ldcealumni.net "),
                                TextSpan(
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                    text: "with your membership ID."),
                                TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    text:
                                        "\n\nIf you haven’t yet become member but would like to be part of ever growing and elite list of registered alumni with listing on online directory then please"),
                                TextSpan(
                                  style: TextStyle(
                                      color: theme.colorScheme.primary,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  text: " Click Here ",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      final url = 'https://www.ldcealumni.net/Home/Registration';
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                                await launchUrl(Uri.parse(url));
                                              }
                                    },
                                ),
                                TextSpan(
                                    style: TextStyle(color: Colors.black, fontSize: 16),
                                    text: "to submit your information."),
                              ])),
                            ),
                            // widget.shortDescription != "null" && widget.description != "null"
                            //     ? Container(
                            //         margin: EdgeInsets.only(top: 16),
                            //         child: Row(
                            //           children: [
                            //             Flexible(
                            //               child: FxText.caption(widget.shortDescription,
                            //                   fontSize: 15,
                            //                   color: theme.colorScheme.onBackground,
                            //                   fontWeight: 600,
                            //                   xMuted: true),
                            //             )
                            //           ],
                            //         ),
                            //       )
                            //     : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

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
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: EdgeInsets.only(top: 0),
                      child: ExpansionTile(
                        initiallyExpanded: false,
                        title:
                            FxText.h6("PATRON", fontSize: 18, color: Color(0xffd32a27), fontWeight: 800),
                        children: [
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
                              "Registering as Patron LAA member requires pledge of ₹51000, which is a donation to our alma matter. Upon fulfilment of the pledge, member will be having discounted/complimentary access to all LAA events and will be distinctly recognised as Patron member, in Alumni directory and other alumni list and pages.",
                              textAlign: TextAlign.justify,
                              // style: AppTheme.getTextStyle(
                              //     themeData.textTheme.bodyText2,
                              //     color: themeData.colorScheme.onBackground,
                              //     fontWeight: 600,
                              //     muted: true),
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: EdgeInsets.only(top: 0),
                      child: ExpansionTile(
                        title:
                            FxText.h6("DONOR", fontSize: 18, color: Color(0xffd32a27), fontWeight: 800),
                        children: [
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
                              "Registering as Donor LAA member requires pledge of ₹25000 which is a donation to our alma matter. Upon fulfilment of the pledge, member will be having discounted/complimentary access to all LAA events and will be distinctly recognised as Donor member, in Alumni directory and other alumni list and pages.",
                              textAlign: TextAlign.justify,
                              // style: AppTheme.getTextStyle(
                              //     themeData.textTheme.bodyText2,
                              //     color: themeData.colorScheme.onBackground,
                              //     fontWeight: 600,
                              //     muted: true),
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: EdgeInsets.only(top: 0),
                      child: ExpansionTile(
                        title: FxText.h6("LAA Member",
                            fontSize: 18, color: Color(0xffd32a27), fontWeight: 800),
                        children: [
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
                              "Membership fee for regular member is ₹1000. Along with Patron and Donor members, regular members will also have their say into LAA governing council. Membership is valid for lifetime and available to all LD passouts.",
                              textAlign: TextAlign.justify,
                              // style: AppTheme.getTextStyle(
                              //     themeData.textTheme.bodyText2,
                              //     color: themeData.colorScheme.onBackground,
                              //     fontWeight: 600,
                              //     muted: true),
                            ),
                          ),
                        ],
                      )),
                ),

                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: EdgeInsets.only(top: 0),
                      child: ExpansionTile(
                        title: FxText.h6("Student LAA Member",
                            fontSize: 18, color: Color(0xffd32a27), fontWeight: 800),
                        children: [
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
                              "Membership fee for student is ₹500. Student members can serve as LAA volunteer but cannot be part of LAA governing council. Student membership is valid only while person is undergoing studies at LD and after completion of studies, person shall convert his/her membership to regular membership by paying applicable difference.",
                              textAlign: TextAlign.justify,
                              // style: AppTheme.getTextStyle(
                              //     themeData.textTheme.bodyText2,
                              //     color: themeData.colorScheme.onBackground,
                              //     fontWeight: 600,
                              //     muted: true),
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                      margin: EdgeInsets.only(top: 0),
                      child: ExpansionTile(
                        title: FxText.h6("LAA non-member",
                            fontSize: 18, color: Color(0xffd32a27), fontWeight: 800),
                        children: [
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
                              "This indicates registration on LAA Connect but does not entitle person to be part of LAA governing council or benefits available to LAA members.",
                              textAlign: TextAlign.justify,
                              // style: AppTheme.getTextStyle(
                              //     themeData.textTheme.bodyText2,
                              //     color: themeData.colorScheme.onBackground,
                              //     fontWeight: 600,
                              //     muted: true),
                            ),
                          ),
                        ],
                      )),
                ),
              ]),
            )),
          ],
        ),
      ),
    );
  }
}
