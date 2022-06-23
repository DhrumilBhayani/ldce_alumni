import 'package:flutter/material.dart';
// import 'package:flutkit/images.dart';
import 'package:ldce_alumni/theme/app_notifier.dart';
import 'package:ldce_alumni/theme/app_theme.dart';
import 'package:ldce_alumni/theme/theme_type.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:flutx/flutx.dart';
import 'package:provider/provider.dart';
import 'package:ldce_alumni/core/text.dart';

class AppDrawerWidget extends StatefulWidget {
  const AppDrawerWidget({Key? key}) : super(key: key);

  @override
  _AppDrawerWidgetState createState() => _AppDrawerWidgetState();
}

class _AppDrawerWidgetState extends State<AppDrawerWidget> {
  late ThemeData theme = AppTheme.theme;
  bool isDark = false;
  //  theme = AppTheme.theme;
  TextDirection textDirection = TextDirection.ltr;
  late CustomTheme customTheme;
  bool isExpanded = false;
  bool isExpandedAbout = false;
  late ScrollController scrollController;

  void changeTheme() {
    if (AppTheme.themeType == ThemeType.light) {
      Provider.of<AppNotifier>(context, listen: false).updateTheme(ThemeType.dark);
    } else {
      Provider.of<AppNotifier>(context, listen: false).updateTheme(ThemeType.light);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // theme = AppTheme.theme;
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(builder: (BuildContext context, AppNotifier value, Widget? child) {
      isDark = AppTheme.themeType == ThemeType.dark;
      textDirection = AppTheme.textDirection;
      theme = AppTheme.theme;
      customTheme = AppTheme.customTheme;
      return Container(
        margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top + 0, 0, 0),
        decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            )),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Drawer(
            backgroundColor: theme.scaffoldBackgroundColor,
            child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              child:
                  // Container(
                  //   height: MediaQuery.of(context).size.height,
                  //   color: theme.scaffoldBackgroundColor,
                  //   child:
                  Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20, bottom: 24, top: 24, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage(!isDark
                              ? "assets/images/laa_logo_black.png"
                              : "assets/images/laa_logo.png"),
                          height: 102,
                          width: 102,
                        ),
                        // SizedBox(height: 16),
                        // Container(
                        //   padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                        //   decoration: BoxDecoration(
                        //       color: theme.colorScheme.primary.withAlpha(40),
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(4),
                        //       )),
                        //   child: FxText.caption("v. 1.0.0",
                        //       color: theme.colorScheme.primary, fontWeight: 600, letterSpacing: 0.2),
                        // ),
                      ],
                    ),
                  ),
                  //SizedBox(height: 32),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 20),
                    child: Column(
                      children: [
                        ExpansionTile(
                          onExpansionChanged: (value) {
                            if (ModalRoute.of(context)!.settings.name != 'home') {
                              Navigator.pop(context);
                              Navigator.of(context)
                                  .pushNamedAndRemoveUntil('home', ModalRoute.withName('home'));
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          title: FxText.b1("Home"),
                          tilePadding: EdgeInsets.all(0),
                          trailing: SizedBox.shrink(),
                          leading: Icon(
                            MdiIcons.home,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 20),
                        ExpansionTile(
                          onExpansionChanged: (value) {
                            if (ModalRoute.of(context)!.settings.name != 'events_home') {
                              Navigator.pop(context);
                              Navigator.of(context)
                                  .pushNamedAndRemoveUntil('events_home', ModalRoute.withName('home'));
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          title: FxText.b1("Events"),
                          tilePadding: EdgeInsets.all(0),
                          trailing: SizedBox.shrink(),
                          leading: Icon(
                            MdiIcons.calendar,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 20),
                        ExpansionTile(
                          onExpansionChanged: (value) {
                            if (ModalRoute.of(context)!.settings.name != 'media_home') {
                              Navigator.pop(context);
                              Navigator.of(context)
                                  .pushNamedAndRemoveUntil('media_home', ModalRoute.withName('home'));
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          title: FxText.b1("Media Gallery"),
                          tilePadding: EdgeInsets.all(0),
                          trailing: SizedBox.shrink(),
                          leading: Icon(
                            MdiIcons.image,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 20),
                        ExpansionTile(
                          onExpansionChanged: (value) {
                            if (ModalRoute.of(context)!.settings.name != 'alumni_directory_home') {
                              Navigator.pop(context);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'alumni_directory_home', ModalRoute.withName('home'));
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          title: FxText.b1("Alumni Directory"),
                          tilePadding: EdgeInsets.all(0),
                          trailing: SizedBox.shrink(),
                          leading: Icon(
                            MdiIcons.accountGroup,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Theme(
                                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                child: Expanded(
                                    child: Container(
                                        child: ExpansionTile(
                                  tilePadding: EdgeInsets.all(0),
                                  leading: Icon(
                                    MdiIcons.note,
                                    color: theme.colorScheme.primary,
                                  ),

                                  onExpansionChanged: ((value) {
                                    setState(() {
                                      isExpandedAbout = value;
                                    });
                                  }),
                                  // initiallyExpanded: true,
                                  title: FxText("Projects"),
                                  children: <Widget>[
                                    // Container(
                                    //     // padding: EdgeInsets.all(16),
                                    //     child: Divider()),
                                    InkWell(
                                        onTap: () {
                                          print("TREE");
                                          if (ModalRoute.of(context)!.settings.name !=
                                              'tree_plantation') {
                                            Navigator.pop(context);

                                            // Navigator.pushNamedAndRemoveUntil(
                                            //   context,
                                            //   'alumni_directory_home',
                                            //   (route) => true,
                                            // );
                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                'tree_plantation', ModalRoute.withName('home'));
                                          } else {
                                            Navigator.pop(context);
                                          }

                                          // showDialog(
                                          //     context: context,
                                          //     builder: (BuildContext context) => SelectLanguageDialog());
                                        },
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16, bottom: 16, left: 70),
                                              child: FxText("Tree Plantation Drives"),
                                            ))),
                                    // Divider(),
                                    InkWell(
                                        onTap: () {
                                          print("AT Hackathon");
                                          if (ModalRoute.of(context)!.settings.name != 'at_hackathon') {
                                            Navigator.pop(context);

                                            // Navigator.pushNamedAndRemoveUntil(
                                            //   context,
                                            //   'alumni_directory_home',
                                            //   (route) => true,
                                            // );
                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                'at_hackathon', ModalRoute.withName('home'));
                                          } else {
                                            Navigator.pop(context);
                                          }

                                          // showDialog(
                                          //     context: context,
                                          //     builder: (BuildContext context) => SelectLanguageDialog());
                                        },
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16, bottom: 16, left: 70),
                                              child: FxText("AT Hackathon"),
                                            )))
                                  ],
                                )))),

                            // SizedBox(width: 16),
                            // Icon(
                            //   FeatherIcons.chevronRight,
                            //   size: 18,
                            //   color: theme.colorScheme.onBackground,
                            // ).autoDirection(),
                          ],
                        ),
                        SizedBox(height: 20),
                        ExpansionTile(
                          onExpansionChanged: (value) {
                            if (ModalRoute.of(context)!.settings.name != 'noteworthy_home') {
                              Navigator.pop(context);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'noteworthy_home', ModalRoute.withName('home'));
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          title: FxText.b1("Noteworthy Mentions"),
                          tilePadding: EdgeInsets.all(0),
                          trailing: SizedBox.shrink(),
                          leading: Icon(
                            MdiIcons.humanMale,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 20),
                        ExpansionTile(
                          onExpansionChanged: (value) {
                            if (ModalRoute.of(context)!.settings.name != 'downloads_home') {
                              Navigator.pop(context);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'downloads_home', ModalRoute.withName('home'));
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          title: FxText.b1("Digital Downloads"),
                          tilePadding: EdgeInsets.all(0),
                          trailing: SizedBox.shrink(),
                          leading: Icon(
                            MdiIcons.download,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 20),
                        ExpansionTile(
                          onExpansionChanged: (value) {
                            if (ModalRoute.of(context)!.settings.name != 'news_home') {
                              Navigator.pop(context);
                              Navigator.of(context)
                                  .pushNamedAndRemoveUntil('news_home', ModalRoute.withName('home'));
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          title: FxText.b1("News"),
                          tilePadding: EdgeInsets.all(0),
                          trailing: SizedBox.shrink(),
                          leading: Icon(
                            MdiIcons.newspaper,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Theme(
                                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                child: Expanded(
                                    child: Container(
                                        child: ExpansionTile(
                                  tilePadding: EdgeInsets.all(0),
                                  leading: Icon(
                                    MdiIcons.information,
                                    color: theme.colorScheme.primary,
                                  ),

                                  onExpansionChanged: ((value) {
                                    setState(() {
                                      isExpandedAbout = value;
                                    });
                                    if (value) {
                                      Future.delayed(Duration(milliseconds: 200), () {
                                        print("Executed after 5 seconds");
                                        scrollController.animateTo(
                                            MediaQuery.of(context).size.height * 1.005,
                                            duration: Duration(milliseconds: 1000),
                                            curve: Curves.linear);
                                      });
                                    }
                                  }),
                                  // initiallyExpanded: true,
                                  title: FxText("About Us"),
                                  children: <Widget>[
                                    // Container(
                                    //     // padding: EdgeInsets.all(16),
                                    //     child: Divider()),
                                    InkWell(
                                        onTap: () {
                                          print("TREE");
                                          if (ModalRoute.of(context)!.settings.name != 'about_us') {
                                            Navigator.pop(context);

                                            // Navigator.pushNamedAndRemoveUntil(
                                            //   context,
                                            //   'alumni_directory_home',
                                            //   (route) => true,
                                            // );
                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                'about_us', ModalRoute.withName('home'));
                                          } else {
                                            Navigator.pop(context);
                                          }

                                          // showDialog(
                                          //     context: context,
                                          //     builder: (BuildContext context) => SelectLanguageDialog());
                                        },
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16, bottom: 16, left: 70),
                                              child: FxText("About LAA"),
                                            ))),
                                    // Divider(),
                                    InkWell(
                                        onTap: () {
                                          // print("AT Hackathon");
                                          if (ModalRoute.of(context)!.settings.name !=
                                              'membership_types') {
                                            Navigator.pop(context);

                                            // Navigator.pushNamedAndRemoveUntil(
                                            //   context,
                                            //   'alumni_directory_home',
                                            //   (route) => true,
                                            // );
                                            Navigator.of(context).pushNamedAndRemoveUntil(
                                                'membership_types', ModalRoute.withName('home'));
                                          } else {
                                            Navigator.pop(context);
                                          }

                                          // showDialog(
                                          //     context: context,
                                          //     builder: (BuildContext context) => SelectLanguageDialog());
                                        },
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16, bottom: 16, left: 70),
                                              child: FxText("Membership Types"),
                                            )))
                                  ],
                                )))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        // )
      );
    });
  }
}
