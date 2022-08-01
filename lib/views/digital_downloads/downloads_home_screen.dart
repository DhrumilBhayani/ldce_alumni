// import 'dart:html';

import 'package:ldce_alumni/controllers/digital_downloads/digital_downloads_controller.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/views/digital_downloads/calendars_screen.dart';
import 'package:ldce_alumni/views/digital_downloads/campaign_downloads_screen.dart';
import 'package:ldce_alumni/views/digital_downloads/desktop_wallpapers_screen.dart';
import 'package:ldce_alumni/views/digital_downloads/mobile_skins_screen.dart';
import 'package:ldce_alumni/views/digital_downloads/other_materials_screen.dart';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:ldce_alumni/views/widgets/app_bar_widget.dart';
import 'package:ldce_alumni/views/widgets/app_drawer_widget.dart';
import 'package:ldce_alumni/theme/app_notifier.dart';
import 'package:ldce_alumni/theme/app_theme.dart';
import 'package:ldce_alumni/theme/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

class DownloadsHomeScreen extends StatefulWidget {
  @override
  _DownloadsHomeScreenState createState() => _DownloadsHomeScreenState();
}

class _DownloadsHomeScreenState extends State<DownloadsHomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  late CustomTheme customTheme;
  late ThemeData theme;
  late TabController tabController;

  bool isDark = false;
  TextDirection textDirection = TextDirection.ltr;
  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.black.withOpacity(0.85),
    //   statusBarIconBrightness: Brightness.light
    // ));
  }

  int? selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.black.withOpacity(0.85),
    //   statusBarIconBrightness: Brightness.light
    // ));
    return Consumer2<AppNotifier, DigitalDownloadsController>(
        builder: (BuildContext context, AppNotifier value, digitalDownloadsProvider, Widget? child) {
      //inspect(value);
      globals.checkInternet(context);

      isDark = AppTheme.themeType == ThemeType.dark;
      textDirection = AppTheme.textDirection;
      theme = AppTheme.theme;
      customTheme = AppTheme.customTheme;
      if (digitalDownloadsProvider.exceptionCreated) {
          print("Exception created block");
          // Navigator.pushNamedAndRemoveUntil(context, 'something_wrong', (route) => false);
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            print("Exception created block 1");
            Navigator.pushNamedAndRemoveUntil(context, 'something_wrong', (route) => false);
            digitalDownloadsProvider.uiLoading = false;
            // showSnackBarWithFloating();
          });
        }
      if (digitalDownloadsProvider.uiLoading && !digitalDownloadsProvider.exceptionCreated) {
        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
            ),
            backgroundColor: customTheme.card,
            body: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
                child: LoadingEffect.getEventsHomeLoadingScreen(
                  context,
                )));
      } else {
        // return Consumer2<AppNotifier,HomeController>(
        //     builder: (BuildContext context, AppNotifier value,HomeController homeProvider, Widget? child) {
        //   //inspect(value);

        //   isDark = AppTheme.themeType == ThemeType.dark;
        //   textDirection = AppTheme.textDirection;
        //   theme = AppTheme.theme;
        //   customTheme = AppTheme.customTheme;

        return !digitalDownloadsProvider.exceptionCreated ? Scaffold(
            // extendBodyBehindAppBar: true,
            key: _key,
            // key: homeController.scaffoldKey,
            // appBar: AppBar(
            //   elevation: 0,
            //   title: FxText.t1(
            //     "Events",
            //     fontWeight: 600,
            //   ),
            // ),
            appBar: AppBarWidget(
              scaffoldKey: _key,
              title: "Digital Downloads",
            ),
            // appBar: AppBar(
            //     backgroundColor: Colors.black.withOpacity(0.5),
            //     leading: Container(
            //         margin: EdgeInsets.only(top: 5, right: 5),
            //         padding: EdgeInsets.only(left: 5, bottom: 5),
            //         child: Row(children: [
            //           Image.asset("./assets/images/laa_logo_notext.png"),
            //           // SizedBox(
            //           //   width: 1,
            //           // ),
            //           // FxText.t1(
            //           //   "LDCE Alumni Portal",
            //           //   // title ?? "",
            //           //   color: Colors.white,
            //           //   fontWeight: 600,
            //           // ),
            //         ])),
            //     // bottom: TabBar(
            //     //   unselectedLabelColor: Colors.white.withOpacity(0.8),
            //     //   labelColor: Colors.blue,
            //     //   controller: tabController,
            //     //   tabs: [
            //     //     Tab(icon: Icon(Icons.upcoming), text: "Upcoming Events"),
            //     //     Tab(icon: Icon(Icons.history), text: "Past Events")
            //     //   ],
            //     // ),
            //     // backgroundColor: theme.appBarTheme.pri,
            //     actions: [
            //       Builder(
            //         builder: (BuildContext context) {
            //           return IconButton(
            //             icon: const Icon(
            //               Icons.menu,
            //               color: Colors.white,
            //             ),
            //             onPressed: () {
            //               print("object");
            //               // print(scaffoldKey);
            //               _key.currentState!.openEndDrawer();
            //             },
            //             tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            //           );
            //         },
            //       ),
            //     ],
            //     title: Container(
            //       child: FxText.t1(
            //         "LDCE Alumni Portal",
            //         color: Colors.white,
            //       ),
            //     )),
            endDrawer: AppDrawerWidget(),
            // drawer: AppDrawerWidget(),
            // resizeToAvoidBottomInset: false,
            body: Column(children: [
              MaterialBanner(
                        content: FxText.b1("Digital Downloads",
                            // fontSize: currentIndex == 0 ? 20 : null,
                            textAlign: TextAlign.left,
                            fontWeight: 600,
                            color: theme.colorScheme.onPrimary),
                        // contentTextStyle: const TextStyle(color: Colors.black, fontSize: 30),
                        backgroundColor:  Colors.black.withAlpha(200),
                        // leadingPadding: const EdgeInsets.only(right: 30),
                        actions: [
                          TextButton(onPressed: () {}, child: const Text('')),
                        ]),
              Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  color: theme.cardColor,
                  // padding: EdgeInsets.only(top: AppBar().preferredSize.height * 1.8),
                  child: TabBar(
                    isScrollable: true,
                    labelStyle: TextStyle(
                      fontSize: 13.0,
                    ),
                    unselectedLabelColor: Colors.black.withOpacity(0.8),
                    labelColor: Colors.blue,
                    controller: tabController,
                    tabs: [
                      Tab(icon: Icon(Icons.wallpaper), text: "Mobile Skins"),
                      Tab(
                          icon: Icon(Icons.desktop_windows),
                          child: Text(
                            "Desktop Wallpapers",
                            softWrap: false,
                          )),
                      Tab(icon: Icon(Icons.calendar_month), text: "Calendars"),
                      Tab(icon: Icon(Icons.campaign), text: "Campaign Downloads"),
                      Tab(icon: Icon(Icons.download), text: "Other Materials"),
                    ],
                  )),

              // SizedBox(height: 10,),
              Expanded(
                  child: TabBarView(controller: tabController, children: [
                MobileSkinsScreen(digitalDownloadsProvider.mobileSkins),
                DesktopWallpapersScreen(digitalDownloadsProvider.desktopWallpapers),
                CalendarsScreen(digitalDownloadsProvider.calendars),
                CampaignDownloadsScreen(digitalDownloadsProvider.campaignDownloads),
                OtherMaterialsScreen(digitalDownloadsProvider.otherMaterials),
              ]))
            ])):Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
            ),
            backgroundColor: customTheme.card,
            body: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
                child: LoadingEffect.getEventsHomeLoadingScreen(
                  context,
                )));;
      }
    });
  }
}
