import 'package:flutter/services.dart';
import 'package:ldce_alumni/controllers/events/events_controller.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/views/events/event_past_screen.dart';
import 'package:ldce_alumni/views/events/event_upcoming_screen.dart';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:ldce_alumni/views/widgets/app_bar_widget.dart';
import 'package:ldce_alumni/views/widgets/app_drawer_widget.dart';
import 'package:ldce_alumni/theme/app_notifier.dart';
import 'package:ldce_alumni/theme/app_theme.dart';
import 'package:ldce_alumni/theme/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

class EventHomeScreen extends StatefulWidget {
  @override
  _EventHomeScreenState createState() => _EventHomeScreenState();
}

class _EventHomeScreenState extends State<EventHomeScreen> with SingleTickerProviderStateMixin {
  late CustomTheme customTheme;
  bool isDark = false;
  int? selectedCategory = 0;
  late TabController tabController;
  TextDirection textDirection = TextDirection.ltr;
  late ThemeData theme;

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.black.withOpacity(0.85),
    //     statusBarIconBrightness: Brightness.light));
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.black.withOpacity(0.85),
    //     statusBarIconBrightness: Brightness.light));
    return Consumer2<AppNotifier, EventsController>(
        builder: (BuildContext context, AppNotifier value, eventsProvider, Widget? child) {
      globals.checkInternet(context);

      isDark = AppTheme.themeType == ThemeType.dark;
      textDirection = AppTheme.textDirection;
      theme = AppTheme.theme;
      customTheme = AppTheme.customTheme;
      if (eventsProvider.exceptionCreated) {
        print("Exception created block");
        // Navigator.pushNamedAndRemoveUntil(context, 'something_wrong', (route) => false);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          print("Exception created block 1");
          Navigator.pushNamedAndRemoveUntil(context, 'something_wrong', (route) => false);
          eventsProvider.uiLoading = false;
          // showSnackBarWithFloating();
        });
      }
      if (eventsProvider.uiLoading) {
        SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));

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

        return !eventsProvider.exceptionCreated
            ? Scaffold(
                //extendBodyBehindAppBar: true,
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
                //  title: "Events",
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
                        content: FxText.b1("Events",
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
                  //  Stack(children:[
                  Container(
                      color: theme.cardColor,
                   //   padding: EdgeInsets.only(top: AppBar().preferredSize.height * 2),
                      child: TabBar(
                        unselectedLabelColor: Colors.black.withOpacity(0.8),
                        labelColor: Colors.blue,
                        controller: tabController,
                        tabs: [
                          Tab(icon: Icon(Icons.upcoming), text: "Upcoming Events"),
                          Tab(icon: Icon(Icons.history), text: "Past Events")
                        ],
                      )),
                  //  ]),
                  // SizedBox(height: 10,),

                  Flexible(
                      child: Container(
                          // /padding: Ed,
                          child: TabBarView(controller: tabController, children: [
                    EventUpcomingScreen(eventsProvider.upcomingEvents),
                    EventPastScreen(eventsProvider.pastEvents)
                  ])))
                ]))
            : Scaffold(
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
        
      }
    });
  }
}
