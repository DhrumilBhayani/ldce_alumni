import 'package:flutter/services.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/theme/app_notifier.dart';
import 'package:ldce_alumni/theme/app_theme.dart';
import 'package:ldce_alumni/theme/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final GlobalKey<ScaffoldState> scaffoldKey; // Create a key
  final PreferredSizeWidget? bottom;
  AppBarWidget({Key? key, this.title, required this.scaffoldKey, this.bottom}) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    late ThemeData theme;
    late CustomTheme customTheme;
    bool isDark = false;
    TextDirection textDirection = TextDirection.ltr;
    return Consumer<AppNotifier>(builder: (BuildContext context, AppNotifier value, Widget? child) {
      isDark = AppTheme.themeType == ThemeType.dark;
      textDirection = AppTheme.textDirection;
      theme = AppTheme.theme;
      customTheme = AppTheme.customTheme;
      // return SafeArea(
      //   child:
      // Column(children: <Widget>[
      // Text("data"),
      // SizedBox(height: 10),
      return AppBar(
        backwardsCompatibility: false,
        bottom: bottom,
        // toolbarHeight: AppBar().preferredSize.height,
        iconTheme: IconThemeData(color: Color.fromRGBO(255, 255, 255, 1)),
        backgroundColor: Colors.black.withOpacity(0.8),
        // backgroundColor: Colors.black.withOpacity(0.5),
        systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.red,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent.withOpacity(0.0),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark),
        flexibleSpace: SafeArea(
            child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (ModalRoute.of(context)!.settings.name != 'home') {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamedAndRemoveUntil('home', ModalRoute.withName('home'));
                  }
                },
                child: Row(children: [
                  Container(
                      padding: EdgeInsets.only(
                        top: 5,
                        left: 5,
                        bottom: 5,
                        right: 10
                      ),
                      child: Image.asset(
                        "./assets/images/laa_logo.png",
                        height: 60,
                      )),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  if (title == null)
                    Container(
                        padding: EdgeInsets.only(top: 5),
                        child: FxText.t1(
                          "LDCE Connect",
                          // title ?? "",
                          textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.3),
                          color: Colors.white,
                          fontWeight: 600,
                        )),
                  if (title != null)
                    Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: FxText.t1(
                          "LDCE Connect\n" + title!,
                          // title ?? "",
                          textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.1),
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: 600,
                        )),
                ]))),
        // leading:  Row(children: [
        //       Image.asset("./assets/images/laa_logo_notext.png",height: 100,),
        //       SizedBox(
        //         width: 5,
        //       ),
        //       if (title == null)
        //         FxText.t1(
        //           "LDCE Alumni Portal",
        //           // title ?? "",
        //           color: Colors.white,
        //           fontWeight: 600,
        //         ),
        //       if (title != null)
        //         FxText.t1(
        //           "LDCE Alumni Portal\n"+title!,
        //           // title ?? "",
        //           color: Colors.white,
        //           fontWeight: 600,
        //         ),
        //     ]),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  print("object");
                  print(scaffoldKey);
                  scaffoldKey.currentState!.openEndDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ],

        // toolbar0Height: 40,
        elevation: 0.1,
      );
      // Row(
      //   children: <Widget>[
      //     Expanded(
      //         child: Container(
      //       padding: EdgeInsets.only(top: 10, left: 12),
      //       height: 40,
      //       // color: Theme.of(context).cardColor,
      //       child: Row(children: [
      //         Text(
      //           "Home > ",
      //           style: TextStyle(
      //             color: Theme.of(context).primaryColor,
      //           ),
      //         ),
      //         Text(
      //           "News",
      //           style:
      //               TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
      //         )
      //       ]),
      //     )),
      //   ],
      // ),
      // ])
      // );
      // AppBar(
      //   elevation: 0,
      //   title: FxText.t1(
      //     title ?? "",
      //     fontWeight: 600,
      //   ),
      // );
    });
  }
}
