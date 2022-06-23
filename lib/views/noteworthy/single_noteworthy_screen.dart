// import 'package:ldce_alumni/screens/news/news_editor_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/theme/app_theme.dart';
// import 'package:flutkit/utils/generator.dart';
import 'package:flutter/material.dart';
// import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleNoteworthyScreen extends StatefulWidget {
  SingleNoteworthyScreen(
      {Key? key,
      required this.title,
      required this.description,
      required this.shortDescription,
      required this.coverPhoto,
      required this.alumniName,
      required this.alumniBranch,
      required this.alumniPassoutYear})
      : super(key: key);

  String title, description, shortDescription, coverPhoto, alumniName, alumniBranch, alumniPassoutYear;

  @override
  _SingleNoteworthyScreenState createState() => _SingleNoteworthyScreenState();
}

class _SingleNoteworthyScreenState extends State<SingleNoteworthyScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void dispose() {
    super.dispose();
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.black.withOpacity(0.85), statusBarIconBrightness: Brightness.light));
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
    // print(widget.coverPhoto);
    return Scaffold(
        appBar: AppBar(
          title: FxText.h6("Noteworthy Mention"),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              // Container(
              //   margin: EdgeInsets.only(top:16),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           Navigator.pop(context);
              //         },
              //         child: Container(
              //           decoration: BoxDecoration(
              //               color: customTheme.card,
              //               shape: BoxShape.circle,
              //               boxShadow: [
              //                 BoxShadow(
              //                     color: customTheme.shadowColor,
              //                     spreadRadius: 2,
              //                     blurRadius: 8,
              //                     offset: Offset(0, 4))
              //               ]),
              //           padding: EdgeInsets.all(12),
              //           child: Icon(
              //             MdiIcons.chevronLeft,
              //             color: theme.colorScheme.onBackground,
              //             size: 20,
              //           ),
              //         ),
              //       ),
              //       Container(
              //         decoration: BoxDecoration(
              //             color: customTheme.card,
              //             shape: BoxShape.circle,
              //             boxShadow: [
              //               BoxShadow(
              //                   color: customTheme.shadowColor,
              //                   spreadRadius: 2,
              //                   blurRadius: 8,
              //                   offset: Offset(0, 4))
              //             ]),
              //         padding: EdgeInsets.all(12),
              //         child: Icon(
              //           MdiIcons.bookmarkOutline,
              //           color: theme.colorScheme.onBackground,
              //           size: 20,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              Expanded(
                  child: ListView(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Container(
                                      width: 90,
                                      decoration: BoxDecoration(
                                        color: Color(0xffd32a27),
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                      ),
                                      // color: Colors.red,
                                      padding: EdgeInsets.all(6),
                                      child: InkWell(
                                          child: Column(children: [
                                            Icon(
                                              Icons.home,
                                              color: Colors.white,
                                            ),
                                            FxText.b2(
                                              "Home",
                                              color: Colors.white,
                                            )
                                          ]),
                                          onTap: () {
                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                'home', (Route<dynamic> route) => false);
                                          })))),
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Color(0xffd32a27),
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  // color: Colors.red,
                                  padding: EdgeInsets.all(6),
                                  child: InkWell(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                          top: 0,
                                        ),
                                        child: Column(children: [
                                          Icon(
                                            Icons.image,
                                            color: Colors.white,
                                          ),
                                          FxText.b2(
                                            "All Noteworthy \nMentions",
                                            color: Colors.white,
                                            textAlign: TextAlign.center,
                                            fontSize: 10,
                                          )
                                        ])),
                                    onTap: () {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          'noteworthy_home', ModalRoute.withName('home'));
                                    },
                                  ))),
                        ],
                      )),
                  widget.coverPhoto != "null"
                      ? ClipRRect(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          child: Image(
                            image: CachedNetworkImageProvider('https://' + widget.coverPhoto),
                          ),
                        )
                      : ClipRRect(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          child: Image(
                            image: AssetImage('./assets/images/no-image.jpg'),
                          ),
                        ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: customTheme.card,
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        boxShadow: [
                          // BoxShadow(
                          //     color: customTheme.shadowColor.withAlpha(120),
                          //     blurRadius: 24,
                          //     spreadRadius: 4)
                        ]),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Container(
                                child: FxText.h6(widget.alumniName + ' - ' + widget.title,
                                    color: theme.colorScheme.onBackground, fontWeight: 600),
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     print("object");
                              //     // Navigator.push(
                              //     //     context,
                              //     //     MaterialPageRoute(
                              //     //         builder: (context) =>
                              //     //             NewsEditorProfileScreen()));
                              //   },
                              //   child:
                              Container(
                                margin: EdgeInsets.only(top: 16),
                                child: Row(
                                  children: [
                                    FxText.caption(
                                        widget.alumniPassoutYear + ' - ' + widget.alumniBranch,
                                        fontSize: 15,
                                        color: theme.colorScheme.onBackground,
                                        fontWeight: 600,
                                        xMuted: true),
                                  ],
                                ),
                                //   ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              widget.shortDescription != "null" && widget.description != "null"
                                  ? Container(
                                      child: FxText.caption(widget.shortDescription,
                                          color: theme.colorScheme.onBackground,
                                          fontWeight: 600,
                                          xMuted: true),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget.description != "null"
                      ? Container(
                          margin: EdgeInsets.only(top: 24),
                          child: FxText(
                            widget.description,
                            textAlign: TextAlign.justify,
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 24), child: FxText(widget.shortDescription)),
                ],
              )),
            ],
          ),
        ));
  }
}
/*

'Although the years 2020 and 2021 have been difficulties due to Corona, the placement in LD Engineering College has not been affected. From March 2020 to August 2021, 174 companies have offered job packages to 621 students while 554 students who passed in 2021 have been offered job packages ranging from Rs 5 lakh to Rs 7 lakh per annum. In the academic year 2019, approximately 104 companies from various sectors participated in the placement and offered jobs to 625 final year students of the college. But in 2020 and 2021 together companies from different sectors have offered jobs to 1175 students.\n\nAn average package of up to Rs 5 lakh per annum is being offered in placement. The number of students getting the job could go much higher as placements in LD Engineering are yet to run till December. L. D. Engineering\'s Placement Cell Coordinator Dr. Vinod Patel said, "Even during Corona, the placement cell of the college continued to operate online. All the placement process including aptitude test, group discussion, and personal interview was done online and online placement is still going on. "'
 */
