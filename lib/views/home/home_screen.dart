// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ld_alumni/core/globals.dart' as globals;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ld_alumni/controllers/home/home_controller.dart';
import 'package:ld_alumni/core/text.dart';
import 'package:ld_alumni/main.dart';
import 'package:ld_alumni/models/home/home.dart';
import 'package:ld_alumni/theme/theme_type.dart';
import 'package:ld_alumni/theme/themes.dart';
import 'package:ld_alumni/utils/custom_badge_icons.dart';
import 'package:ld_alumni/utils/local_notification_service.dart';
import 'package:ld_alumni/views/general/no_internet_screen.dart';
import 'package:ld_alumni/views/home/home_downloads_tab.dart';
import 'package:ld_alumni/views/home/home_events_tab.dart';
import 'package:ld_alumni/views/home/home_home_tab.dart';
import 'package:ld_alumni/views/home/home_media_tab.dart';
import 'package:ld_alumni/views/home/home_news_tab.dart';
import 'package:ld_alumni/views/home/home_noteworthy_tab.dart';
import 'package:ld_alumni/views/loading_effect.dart';
import 'package:ld_alumni/views/projects/home_project_tab.dart';
import 'package:ld_alumni/views/widgets/app_bar_widget.dart';
import 'package:ld_alumni/views/widgets/app_drawer_widget.dart';
import 'package:ld_alumni/views/widgets/simple_dialog.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    this.notificationAppLaunchDetails,
    Key? key,
  }) : super(key: key);
  final NotificationAppLaunchDetails? notificationAppLaunchDetails;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int currentIndex = 0;

  late ThemeData theme;
  late CustomTheme customTheme;
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  late TabController tabController;
  late List<NavItem> navItems;
  String? selectedNotificationPayload;

  bool isDark = false;
  TextDirection textDirection = TextDirection.ltr;
  void _showDialog(id, type, title) {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            SimpleDialogWidget(id: id.toString(), type: type.toString(), title: title.toString()));
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 7, vsync: this, initialIndex: 0);

    tabController.addListener(() {
      currentIndex = tabController.index;
      setState(() {});
    });

    tabController.animation!.addListener(() {
      final aniValue = tabController.animation!.value;
      if (aniValue - currentIndex > 0.5) {
        currentIndex++;
      } else if (aniValue - currentIndex < -0.5) {
        currentIndex--;
      }

      setState(() {});
    });
    print(widget.notificationAppLaunchDetails?.didNotificationLaunchApp);
    if (widget.notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload = widget.notificationAppLaunchDetails!.payload;
      print('##########################################################');
      print(selectedNotificationPayload);
      Map jsonPayload = json.decode(selectedNotificationPayload!);
      if (jsonPayload["type"].toString().toLowerCase().contains('news')) {
        print("NEWSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => SingleInternetNewsScreen(
          //               id: jsonPayload['id'],
          //             )));
          Navigator.pushNamed(context, 'single_internet_news_screen',
              arguments: ScreenArguments(jsonPayload['id']));
        });
      }
      if (jsonPayload["type"].toString().toLowerCase().contains('event') ||
          jsonPayload["type"].toString().toLowerCase().contains('events')) {
        // print("EVENTSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => SingleInternetEventScreen(
          //                 id:jsonPayload['id'],
          //               )));
          Navigator.pushNamed(context, 'single_internet_events_screen',
              arguments: ScreenArguments(jsonPayload['id']));
        });
      }
      print('##########################################################');
    }
    // homeController = HomeController();

    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;

    ///  Terminated State
    /// 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and
    // you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        // Navigator.of(context).pushNamed(routeFromMessage);

        print(message.notification!.title);
        print(message.notification!.body);
        print("Message Whole Data : ${message.data}");
        print("Message Data : ${message.data["eventID"]}");
        print("Terminated Message ID: ${message.data["_id"]}");
        print("Notification message.data: ${message}");
        // print("Notification: ${message.notification}");

        //////// In case of DemoScreen ///////////////////
        // if (message.data['_id'] != null) {
        //   Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => DemoScreen(id: message.data['_id'])));
        // }
        //////////////////////////////////////////////////
        // LocalNotificationService.createAndDisplayNotification(message);
        // if (message.data["type"].toString().toLowerCase().contains('news')) {
        //   print("NEWSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => SingleInternetNewsScreen(
        //                 id: message.data["id"],
        //               )));
        // }
        // if (message.data["type"].toString().toLowerCase().contains('event') ||
        //     message.data["type"].toString().toLowerCase().contains('events')) {
        //   print("EVENTSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => SingleInternetEventScreen(
        //                 id: message.data["id"],
        //               )));
        // }
      }
    });

    ///  Foreground State
    /// 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen((message) {
      print("FirebaseMessaging.onMessage.listen");
      if (message.data != 'null') {
        // print(message.notification!.title);
        // print(message.notification!.body);
        // print(message.notification!.bodyLocArgs);
        // print("#######################################################");
        // print("Foreground Message ID: ${message.data["_id"]}");
        print("Message Whole Data : ${message.data}");
        print("Message Title : ${message.data["title"]}");
        print("#######################################################");
        if (message.data["type"].toString().toLowerCase().contains('news')) {
          print("NEWSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
          _showDialog(message.data["id"].toString(), "NEWS", message.data["title"]);
        }
        if (message.data["type"].toString().toLowerCase().contains('event') ||
            message.data["type"].toString().toLowerCase().contains('events')) {
          _showDialog(message.data["id"].toString(), "EVENT", message.data["title"]);
        }

        // LocalNotificationService.createAndDisplayNotification(message);
      }
    });

    ///  Background State
    /// 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        print("Background Message ID: ${message.data}");
        print("Message Whole Data : ${message.data}");
        print("Message Data : ${message.data["type"]}");
        print("Message Data : ${message.data["type"].toString().toLowerCase()}");
        // Navigator.pushNamed(context, "single_internet_news_screen");
        // if (message.data["type"].toString().toLowerCase().contains('news')) {
        //   print("NEWSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => SingleInternetNewsScreen(
        //                 id: message.data["id"],
        //               )));
        // }
        // if (message.data["type"].toString().toLowerCase().contains('event') ||
        //     message.data["type"].toString().toLowerCase().contains('events')) {
        //   print("EVENTSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => SingleInternetEventScreen(
        //                 id: message.data["id"],
        //               )));
        // }
        // LocalNotificationService.createAndDisplayNotification(message);
      }
    });
  }

  Widget _singleSliderImage(Home singleSliderPage) {
    return CachedNetworkImage(
      imageUrl: "https://" + singleSliderPage.imageUrl,
      placeholder: (context, url) => Image.asset(
        './assets/images/banners/LDCE_2.webp',
      ),
      // errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  List<Widget> _buildSliderImage() {
    final homeProvider = Provider.of<HomeController>(context);

    List<Widget> list = [];
    for (Home singleImage in homeProvider.home) {
      list.add(_singleSliderImage(singleImage));
    }
    return list;
  }


  @override
  Widget build(BuildContext context) {
    return Consumer2<AppNotifier, HomeController>(
      builder: (BuildContext context, AppNotifier value, homeProvider, Widget? child) {
        globals.checkInternet(context);
        //    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        // statusBarColor: Colors.black.withOpacity(0.85),
        // statusBarIconBrightness: Brightness.light));
        //inspect(value);
        // print("0 HomeProvider");
        isDark = AppTheme.themeType == ThemeType.dark;
        textDirection = AppTheme.textDirection;
        theme = AppTheme.theme;
        customTheme = AppTheme.customTheme;
        if (homeProvider.uiLoading) {
          // print("HomeProvider");
          // homeProvider.getNews();
          homeProvider.fetchData();
          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
              ),
              backgroundColor: customTheme.card,
              body: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
                  child: LoadingEffect.getHomeLoadingScreen(
                    context,
                  )));
        } else {
          navItems = [
            NavItem('Home', Icons.home, HomeTab()),
            NavItem('News', Icons.newspaper, HomeNewsTab()),
            NavItem('Events', Icons.event, HomeEventstab()),
            NavItem('Media', Icons.image, HomeMediaTab(), 32),
            NavItem('Noteworthy Mentions', CustomBadge.badge, HomeNoteworthyTab()),
            NavItem('Projects', Icons.note, TreePlantationScreenTab()),
            NavItem('Digital Downloads', Icons.download, HomeDownloadsTab()),
          ];
          // SystemUiOverlayStyle.light.copyWith(systemNavigationBarColor: Colors.red);
          return Scaffold(
            endDrawer: AppDrawerWidget(),
            key: _drawerKey,
            appBar: AppBarWidget(scaffoldKey: _drawerKey),
            // appBar: AppBar(
            //   elevation: 0,
            //   title: FxText.t2(
            //     navItems[currentIndex].title,
            //     fontWeight: 600,
            //   ),
            //   actions: [
            //     InkWell(
            //       onTap: () {
            //         // Navigator.push(context, SlideLeftRoute(AppSettingScreen()));
            //       },
            //       child: Container(
            //         padding: EdgeInsets.only(left:20,right:20),
            //         child:Text("SETTING"),
            //       ),
            //     ),
            //   ],
            // ),
            body: Column(
              children: [
                Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 180.0,
                        // enlargeCenterPage: true,
                        autoPlay: true,
                        // aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 500),
                        viewportFraction: 2,
                      ),
                      items: _buildSliderImage(),
                    ),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.125,
                        left: MediaQuery.of(context).size.width * 0.72,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          height: 50,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              color: Colors.black.withAlpha(150)),
                          child: Image(
                            image: AssetImage("./assets/images/75.png"),
                            height: 100,
                            width: 100,
                          ),
                        )),
                  ],
                ),

                Row(children: [
                  Expanded(
                      child: Container(
                          height: currentIndex == 0 ? 50 : null,
                          margin: EdgeInsets.fromLTRB(10, currentIndex == 0 ? 11 : 10, 10, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'alumni_directory_home', ModalRoute.withName('home'));
                              // Navigator.pushNamed(context, 'alumni_directory_home',
                              //     arguments: homeProvider.news);
                            },
                            child: FxText.b1("ALUMNI DIRECTORY",
                                fontSize: currentIndex == 0 ? 20 : null,
                                fontWeight: 600,
                                color: theme.colorScheme.onPrimary),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
                          )))
                ]),
                Expanded(
                  child: TabBarView(
                      controller: tabController,
                      children: navItems.map((navItem) => navItem.screen).toList()),
                ),
                // Container(
                //   padding: EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),

                //   decoration: BoxDecoration(
                //       color: Colors.blue,
                //       borderRadius: null,
                //       border: Border(
                //         top: BorderSide(width: 2, color: customTheme.border),
                //       )),
                //   child:
                SafeArea(
                    child: PreferredSize(
                        preferredSize: new Size(200.0, 200.0),
                        child: new Container(
                            // height: 80,
                            // width: 200.0,
                            child: TabBar(
                                indicator: UnderlineTabIndicator(
                                  borderSide: BorderSide(color: theme.colorScheme.secondary, width: 5.0),
                                  insets: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 150.0),
                                ),
                                controller: tabController,
                                isScrollable: true,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorColor: theme.colorScheme.primary,
                                padding: EdgeInsets.zero,
                                indicatorPadding: EdgeInsets.only(bottom: 5),
                                labelPadding: EdgeInsets.zero,
                                indicatorWeight: 0,
                                tabs: [
                              Container(
                                  color: Color.fromARGB(255, 250, 38, 48),
                                  constraints: BoxConstraints.expand(width: 80, height: 80),
                                  height: 80,
                                  child: Tab(
                                    child: Tooltip(
                                      height: 800,
                                      message: "Home",
                                      child: Container(
                                          // constraints: BoxConstraints.expand(width: 100, height: 800),
                                          color: Color.fromARGB(255, 250, 38, 48),
                                          child: Icon(navItems[0].icon,
                                              color: (currentIndex == 0)
                                                  ? theme.colorScheme.onBackground
                                                  : theme.colorScheme.onPrimary.withAlpha(500),
                                              size: navItems[0].size * 1.5)),
                                    ),
                                  )),
                              Container(
                                  color: Color(0xffffca02),
                                  constraints: BoxConstraints.expand(width: 80, height: 80),
                                  height: 80,
                                  child: Tab(
                                      child: Tooltip(
                                    message: "News",
                                    child: Container(
                                        constraints: BoxConstraints.expand(width: 80),
                                        color: Color(0xffffca02),
                                        child: Icon(navItems[1].icon,
                                            color: (currentIndex == 1)
                                                ? theme.colorScheme.onBackground
                                                : theme.colorScheme.onPrimary.withAlpha(500),
                                            size: navItems[1].size * 1.5)),
                                  ))),
                              Container(
                                  color: Color.fromARGB(255, 250, 38, 48),
                                  constraints: BoxConstraints.expand(width: 80, height: 80),
                                  height: 80,
                                  child: Tab(
                                      child: Tooltip(
                                    message: "Events",
                                    child: Container(
                                        constraints: BoxConstraints.expand(
                                          width: 80,
                                        ),
                                        color: Color(0xff1692d0),
                                        child: Icon(navItems[2].icon,
                                            color: (currentIndex == 2)
                                                ? theme.colorScheme.onBackground
                                                : theme.colorScheme.onPrimary.withAlpha(500),
                                            size: navItems[2].size * 1.5)),
                                  ))),
                              Container(
                                  color: Color.fromARGB(255, 250, 38, 48),
                                  constraints: BoxConstraints.expand(width: 80, height: 80),
                                  height: 80,
                                  child: Tab(
                                      child: Tooltip(
                                    message: "Media Gallery",
                                    child: Container(
                                        constraints: BoxConstraints.expand(width: 80),
                                        color: Color(0xff07a44d),
                                        child: Icon(navItems[3].icon,
                                            color: (currentIndex == 3)
                                                ? theme.colorScheme.onBackground
                                                : theme.colorScheme.onPrimary.withAlpha(500),
                                            size: navItems[3].size * 1.5)),
                                  ))),
                              Container(
                                  color: Color.fromARGB(255, 250, 38, 48),
                                  constraints: BoxConstraints.expand(width: 80, height: 80),
                                  height: 80,
                                  child: Tab(
                                      child: Tooltip(
                                    message: "Noteworthy Mentions",
                                    child: Container(
                                        constraints: BoxConstraints.expand(width: 80),
                                        color: Color.fromARGB(255, 250, 38, 48),
                                        child: Icon(navItems[4].icon,
                                            color: (currentIndex == 4)
                                                ? theme.colorScheme.onBackground
                                                : theme.colorScheme.onPrimary.withAlpha(500),
                                            size: navItems[4].size * 1.5)),
                                  ))),
                              Container(
                                  color: Color.fromARGB(255, 250, 38, 48),
                                  constraints: BoxConstraints.expand(width: 80, height: 80),
                                  height: 80,
                                  child: Tab(
                                      child: Tooltip(
                                    message: "Projects",
                                    child: Container(
                                        constraints: BoxConstraints.expand(width: 80),
                                        color: Color(0xffffca02),
                                        child: Icon(navItems[5].icon,
                                            color: (currentIndex == 5)
                                                ? theme.colorScheme.onBackground
                                                : theme.colorScheme.onPrimary.withAlpha(500),
                                            size: navItems[5].size * 1.5)),
                                  ))),
                              Container(
                                  color: Color.fromARGB(255, 250, 38, 48),
                                  constraints: BoxConstraints.expand(width: 80, height: 80),
                                  height: 80,
                                  child: Tab(
                                      child: Tooltip(
                                    message: "Digital Downloads",
                                    child: Container(
                                        constraints: BoxConstraints.expand(width: 80),
                                        color: Color(0xff1692d0),
                                        child: Icon(navItems[6].icon,
                                            color: (currentIndex == 6)
                                                ? theme.colorScheme.onBackground
                                                : theme.colorScheme.onPrimary.withAlpha(500),
                                            size: navItems[6].size * 1.5)),
                                  ))),
                            ]

                                // buildTab(),
                                )))),
                // )
              ],
            ),
          );
        }
      },
    );
  }

  List<Widget> buildTab() {
    List<Widget> tabs = [];

    for (int i = 0; i < navItems.length; i++) {
      tabs.add(Container(
          color: Colors.red,
          child: Icon(navItems[i].icon,
              color: (currentIndex == i)
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onBackground.withAlpha(220),
              size: navItems[i].size)));
    }
    return tabs;
  }
}

class NavItem {
  final String title;
  final IconData icon;
  final Widget screen;
  final double size;

  NavItem(this.title, this.icon, this.screen, [this.size = 28]);
}
