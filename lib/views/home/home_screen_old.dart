// // import 'package:flutkit/apps/ld_alumni/views/Events/event_home_screen.dart';
// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:ld_alumni/core/text.dart';
// import 'package:ld_alumni/main.dart';
// import 'package:ld_alumni/models/home/home.dart';
// import 'package:ld_alumni/utils/local_notification_service.dart';
// import 'package:ld_alumni/views/events/event_home_screen.dart';
// import 'package:ld_alumni/views/events/single_internet_event_screen..dart';
// import 'package:ld_alumni/views/general/no_internet_screen.dart';
// import 'package:ld_alumni/views/news/single_notification_news_screen.dart';
// import 'package:ld_alumni/views/widgets/app_bar_widget.dart';
// import 'package:ld_alumni/views/widgets/app_drawer_widget.dart';
// import 'package:ld_alumni/views/widgets/single_news_widget.dart';
// import 'package:ld_alumni/views/loading_effect.dart';
// import 'package:ld_alumni/theme/app_theme.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutx/flutx.dart';
// import 'package:ld_alumni/views/widgets/single_grid_item.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:ld_alumni/models/news/news.dart';
// import 'package:provider/provider.dart';
// import 'package:ld_alumni/controllers/home/home_controller.dart';
// import 'package:ld_alumni/theme/app_notifier.dart';
// import 'package:ld_alumni/theme/theme_type.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class HomeScreen extends StatefulWidget {
//   NotificationAppLaunchDetails? notificationAppLaunchDetails;
//   HomeScreen({this.notificationAppLaunchDetails, Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('####################################################################');
//   print('A hhhhhooBackground message just showed up :  ${message.messageId}');
//   print('Ahhhhhhhhhh Background message just showed up :  ${message.data}');
//   Map<String, dynamic> data = {
//     "title": "This is Some test Title of Flutter Notification Test Zero One Two threeththththth",
//     "coverPhoto":
//         "https://www.ldcealumni.net/Content/News/Cover/kaizendonationbyfamily_innameofldprincipal_proftmparikh_03-25032022050835.jpg",
//     "current_time": DateTime.now().toString(),
//   };
//   try {
//     const platform = const MethodChannel('LDCE_NOTIFICATION');
//     print('id :  ${message.data["id"]}');
//     print('####################################################################');
//     // final prefs = await SharedPreferences.getInstance();
//     //Invoke a method named "startNativeActivity"
//     //startNativeActivity is the name of a function located in
//     //MainActivity that can be call from here.
//
//     //Creating a Map
//
//     //Invoke a method named "startNativeActivity"
//     //startNativeActivity is the name of a function located in
//     //MainActivity that can be call from here.
//     // await myPlatform.invokeMethod('showCustomNotificationFromNative', data);
//     // await platform.invokeMethod('testMethodFromFlutter', data);
//     LocalNotificationService.createAndDisplayNotification(message);
//   } on PlatformException catch (e) {
//     print("Failed to Invoke: '${e.message}'.");
//   } on MissingPluginException catch (e) {
//     print("MSP Failed to Invoke: '${e.message}'.");
//   }
//
//   // _HomeScreenState.showCustomNotification();
//
//   // print('A Background message just showed up :  ${message.notification}');
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   static const platform = const MethodChannel('flutter.native/helper');
//   static const myPlatform = const MethodChannel('LDCE_NOTIFICATION');
//
//   final PageController _pageController = PageController(initialPage: 0);
//   int _currentPage = 0;
//   late Timer timerAnimation;
//   late int numPages;
//   // late NewsController newsController;
//
//   late ThemeData theme;
//   late CustomTheme customTheme;
//   final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
//
//   // late HomeController homeController;
//   bool isDark = false;
//   TextDirection textDirection = TextDirection.ltr;
//   late HomeController homeProvider;
//
//   @override
//   void dispose() {
//     // Never called
//     // print("Disposing first route");
//     super.dispose();
//   }
//
//   void initFirebasse() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp();
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
// // Firebase local notification plugin
// //     await flutterLocalNotificationsPlugin
// //         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
// //         ?.createNotificationChannel(channel);
//
// //Firebase messaging
//     FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     FirebaseMessaging.instance.subscribeToTopic('all-dhrumil');
//     FirebaseMessaging.instance.subscribeToTopic('all-dhrumil-dev');
//     FirebaseMessaging.instance.subscribeToTopic('all');
//     // await Firebase.initializeApp();
//     // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // print("object");
//     // newsController = FxControllerStore.putOrFind<NewsController>(NewsController());
//     initFirebasse();
//      print("Home INIT");
//     // newsController = FxControllerStore.putOrFind<NewsController>(NewsController());
//     print(widget.notificationAppLaunchDetails?.didNotificationLaunchApp);
//     if (widget.notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
//       selectedNotificationPayload = widget.notificationAppLaunchDetails!.payload;
//       print('##########################################################');
//       print(selectedNotificationPayload);
//       Map jsonPayload = json.decode(selectedNotificationPayload!);
//       if (jsonPayload["type"].toString().toLowerCase().contains('news')) {
//         print("NEWSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
//
//         WidgetsBinding.instance!.addPostFrameCallback((_) {
//           Navigator.pushNamed(context,'single_internet_news_screen',arguments:ScreenArguments(jsonPayload['id']) );
//         });
//
//       }
//       if (jsonPayload["type"].toString().toLowerCase().contains('event') ||
//           jsonPayload["type"].toString().toLowerCase().contains('events')) {
//         print("EVENTSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
//
//         WidgetsBinding.instance!.addPostFrameCallback((_) {
//           Navigator.pushNamed(context,'single_internet_events_screen',arguments:ScreenArguments(jsonPayload['id']) );
//         });
//
//       }
//       print('##########################################################');
//     }
//     // homeController = HomeController();
//     WidgetsBinding.instance!.addPostFrameCallback((_) {});
//     WidgetsFlutterBinding.ensureInitialized();
//
//     theme = AppTheme.theme;
//     customTheme = AppTheme.customTheme;
//     // for (Home singleImage in homeProvider.home) {
//     //  //precacheImage(singleImage, context) ;
//     // }
//     LocalNotificationService.initialize(context);
//     myPlatform.setMethodCallHandler((call) async {
//       print("MyDartPrinter: " + call.method.toString());
//     });
//
//     /// TODO Terminated State
//     /// 1. This method call when app in terminated state and you get a notification
//     // when you click on notification app open from terminated state and
//     // you can get notification data in this method
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       print("FirebaseMessaging.instance.getInitialMessage");
//       if (message != null) {
//         final routeFromMessage = message.data["route"];
//         // Navigator.of(context).pushNamed(routeFromMessage);
//
//         print(message.notification!.title);
//         print(message.notification!.body);
//         print("Message Whole Data : ${message.data}");
//         print("Message Data : ${message.data["eventID"]}");
//         print("Terminated Message ID: ${message.data["_id"]}");
//         print("Notification message.data: ${message}");
//         // print("Notification: ${message.notification}");
//
//         //////// In case of DemoScreen ///////////////////
//         // if (message.data['_id'] != null) {
//         //   Navigator.of(context).push(MaterialPageRoute(
//         //       builder: (context) => DemoScreen(id: message.data['_id'])));
//         // }
//         //////////////////////////////////////////////////
//         // LocalNotificationService.createAndDisplayNotification(message);
//         // showCustomNotification();
//         if (message.data["type"].toString().toLowerCase().contains('news')) {
//           print("NEWSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => SingleInternetNewsScreen(
//                         id: message.data["id"],
//                       )));
//         }
//         if (message.data["type"].toString().toLowerCase().contains('event') ||
//             message.data["type"].toString().toLowerCase().contains('events')) {
//           print("EVENTSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => SingleInternetEventScreen(
//                         id: message.data["id"],
//                       )));
//         }
//       }
//     });
//
//     /// TODO Foreground State
//     /// 2. This method only call when App in foreground it mean app must be opened
//     FirebaseMessaging.onMessage.listen((message) async {
//       // showCustomNotification(message.data["id"],message.notification.title);
//       print("FirebaseMessaging.onMessage.listen");
//
//       if (message.notification == null) {
//         // print(message.notification!.title);
//         // print(message.notification!.body);
//         // print(message.notification!.bodyLocArgs);
//         try {
//           final prefs = await SharedPreferences.getInstance();
//           prefs.setString('id', message.data["id"]);
//         } catch (e) {
//           print("Exception :" + e.toString());
//         }
//         print("#######################################################");
//         // print("Foreground Message ID: ${message.notification.image!}");
//         print("Message Whole Data : ${message.data}");
//         print("Message Data : ${message.data["id"]}");
//         print("Message Data : ${message.data["image"]}");
//         print("#######################################################");
//         LocalNotificationService.createAndDisplayNotification(message);
//       }
//     });
//
//     /// TODO Background State
//     /// 3. This method only call when App in background and not terminated(not closed)
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       // showCustomNotification();
//       print("FirebaseMessaging.onMessageOpenedApp.listen");
//       if (message.notification != null) {
//         final routeFromMessage = message.data["route"];
//
//         print(message.notification!.title);
//         print(message.notification!.body);
//         print("Background Message ID: ${message.data}");
//         print("Message Whole Data : ${message.data}");
//         print("Message Data : ${message.data["type"]}");
//         print("Message Data : ${message.data["type"].toString().toLowerCase()}");
//         // Navigator.pushNamed(context, "single_internet_news_screen");
//         if (message.data["type"].toString().toLowerCase().contains('news')) {
//           print("NEWSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => SingleInternetNewsScreen(
//                         id: message.data["id"],
//                       )));
//         }
//         if (message.data["type"].toString().toLowerCase().contains('event') ||
//             message.data["type"].toString().toLowerCase().contains('events')) {
//           print("EVENTSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => SingleInternetEventScreen(
//                         id: message.data["id"],
//                       )));
//         }
//         LocalNotificationService.createAndDisplayNotification(message);
//       }
//     });
//   }
//
//   Widget _singleSliderImage(Home singleSliderPage) {
//     return FadeInImage.assetNetwork(
//       height: 1000,
//       width: 1000,
//       placeholder: './assets/images/banners/LDCE_2.jpg',
//       image: "https://" + singleSliderPage.imageUrl,
//
//       // child: Image.network(
//       //   "https://"+singleSliderPage.imageUrl,
//       //   height: 240.0,
//       //   fit: BoxFit.fill,
//       // ),
//     );
//   }
//
//   void preloadImages() {
//     final homeProvider = Provider.of<HomeController>(context);
//     for (var singleNews in homeProvider.news) {
//       if (singleNews.imageUrl != "null") {
//         final theImage = Image.network(
//           'https://' + singleNews.imageUrl,
//         );
//         precacheImage(theImage.image, context);
//         print("Precache");
//       }
//     }
//   }
//
//   List<Widget> _buildSliderImage() {
//     final homeProvider = Provider.of<HomeController>(context);
//
//     List<Widget> list = [];
//     for (Home singleImage in homeProvider.home) {
//       list.add(_singleSliderImage(singleImage));
//     }
//     return list;
//   }
//
//   List<Widget> _buildNewsList() {
//     final homeProvider = Provider.of<HomeController>(context);
//
//     List<Widget> list = [];
//     // newsController = FxControllerStore.putOrFind<NewsController>(NewsController());
//     for (var i = 0; i <= 2; i++) {
//       // print("i");
//       // print(i);
//       if (i < homeProvider.news.length) {
//         list.add(_singleNews((homeProvider.news[i])));
//         // print(homeProvider.news[i]);
//       } else {}
//     }
//     // for (News singleNews in homeProvider.news) {
//     //   list.add(_singleNews(singleNews));
//     // }
//     return list;
//   }
//
//   Widget _singleNews(News singleNews) {
//     // print("Image url: " + singleNews.imageUrl);
//     // print("Date: " + singleNews.date);
//     // print("Title: " + singleNews.title);
//     // print("desc: " + singleNews.shortDescription);
//     return SingleNewsWidget(
//       imageUrl: singleNews.imageUrl,
//       date: singleNews.date,
//       title: singleNews.title,
//       shortDescription: singleNews.shortDescription,
//       description: singleNews.description,
//     );
//   }
//
//   Widget _indicator(bool isActive) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInToLinear,
//       margin: const EdgeInsets.symmetric(horizontal: 4.0),
//       height: 8.0,
//       width: 8,
//       decoration: BoxDecoration(
//         color: isActive ? Colors.white : Colors.white.withAlpha(140),
//         borderRadius: const BorderRadius.all(Radius.circular(4)),
//       ),
//     );
//   }
//
//   checkInternet(buildContext) async {
//     int timeout = 40;
//     try {
//       http.Response response =
//           await http.get(Uri.parse('https://google.com')).timeout(Duration(seconds: timeout));
//       if (response.statusCode == 200) {
//         // do something
//       } else {
//         // handle it
//       }
//     } on TimeoutException catch (e) {
//       print('Timeout Error: $e');
//     } on SocketException catch (e) {
//       print('Socket Error: $e');
//       Navigator.push(
//           buildContext, MaterialPageRoute(builder: (buildContext) => NoInternetScreen()));
//     } on Error catch (e) {
//       print('General Error: $e');
//     }
//   }
//
//   static void showCustomNotification() async {
//     print("showCustomNotification()");
//     try {
//       //Creating a Map
//       Map<String, dynamic> data = {
//         "title":
//             "This is Some test Title of Flutter Notification Test Zero One Two threeththththth",
//         "coverPhoto":
//             "https://www.ldcealumni.net/Content/News/Cover/kaizendonationbyfamily_innameofldprincipal_proftmparikh_03-25032022050835.jpg",
//         "current_time": DateTime.now().toString(),
//       };
//       //Invoke a method named "startNativeActivity"
//       //startNativeActivity is the name of a function located in
//       //MainActivity that can be call from here.
//       // await myPlatform.invokeMethod('showCustomNotificationFromNative', data);
//       await platform.invokeMethod('showCustomNotificationFromNative', data);
//     } on PlatformException catch (e) {
//       print("Failed to Invoke: '${e.message}'.");
//     } on MissingPluginException catch (e) {
//       print("MSP Failed to Invoke: '${e.message}'.");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final homeProvider = Provider.of<HomeController>(context);
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent.withOpacity(0.85),
//         statusBarIconBrightness: Brightness.light));
//     // checkInternet(context);
//     // return FxBuilder<HomeController>(
//     //     controller: homeController,
//     //     builder: (homeController) {
//     return _buildBody();
//     // });
//   }
//
//   Widget _buildBody() {
//     return Consumer2<AppNotifier, HomeController>(
//         builder: (BuildContext context, AppNotifier value, homeProvider, Widget? child) {
//       //inspect(value);
//       // print("0 HomeProvider");
//       isDark = AppTheme.themeType == ThemeType.dark;
//       textDirection = AppTheme.textDirection;
//       theme = AppTheme.theme;
//       customTheme = AppTheme.customTheme;
//       if (homeProvider.uiLoading) {
//         // print("HomeProvider");
//         // homeProvider.getNews();
//         return Scaffold(
//             backgroundColor: customTheme.card,
//             body: Container(
//                 margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
//                 child: LoadingEffect.getHomeLoadingScreen(
//                   context,
//                 )));
//       } else {
//         numPages = homeProvider.home.length;
//         // preloadImages();
//
//         // return Consumer2<AppNotifier,HomeController>(
//         //     builder: (BuildContext context, AppNotifier value,HomeController homeProvider, Widget? child) {
//         //   //inspect(value);
//
//         //   isDark = AppTheme.themeType == ThemeType.dark;
//         //   textDirection = AppTheme.textDirection;
//         //   theme = AppTheme.theme;
//         //   customTheme = AppTheme.customTheme;
//         return Scaffold(
//           key: _key,
//           // extendBodyBehindAppBar: true,
//           //key: homeProvider.scaffoldKey,
//           appBar: AppBarWidget(
//             scaffoldKey: _key,
//             // title: "Home",
//           ),
//           endDrawer: AppDrawerWidget(),
//           // drawer: AppDrawerWidget(),
//           resizeToAvoidBottomInset: true,
//           body:
//               // SafeArea(child:
//               ListView(
//                   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
//                   physics: const ClampingScrollPhysics(),
//                   children: <Widget>[
//                 Column(
//                     // alignment: AlignmentDirectional.center,
//                     children: <Widget>[
//                       CarouselSlider(
//                         options: CarouselOptions(
//                           height: 180.0,
//                           // enlargeCenterPage: true,
//                           autoPlay: true,
//                           // aspectRatio: 16 / 9,
//                           autoPlayCurve: Curves.fastOutSlowIn,
//                           enableInfiniteScroll: true,
//                           autoPlayAnimationDuration: Duration(milliseconds: 500),
//                           viewportFraction: 2,
//                         ),
//                         items: _buildSliderImage(),
//                         // child: PageView(
//                         //   pageSnapping: true,
//                         //   physics: const ClampingScrollPhysics(),
//                         //   controller: _pageController,
//                         //   onPageChanged: (int page) {
//                         //     setState(() {
//                         //       _currentPage = page;
//                         //     });
//                         //   },
//                         //   children: _buildSliderImage(),
//                         // <Widget>[
//                         //   Padding(
//                         //     padding: const EdgeInsets.only(right: 0),
//                         //     child: Image.asset(
//                         //       './assets/images/banners/LDCE_1.jpg',
//                         //       height: 240.0,
//                         //       fit: BoxFit.fill,
//                         //     ),
//                         //   ),
//                         //   Padding(
//                         //     padding: const EdgeInsets.all(0.0),
//                         //     child: Image.asset(
//                         //       './assets/images/banners/LDCE_2.jpg',
//                         //       height: 240.0,
//                         //       fit: BoxFit.fill,
//                         //     ),
//                         //   ),
//                         //   Padding(
//                         //     padding: const EdgeInsets.all(0.0),
//                         //     child: Image.asset(
//                         //       './assets/images/banners/LDCE_3.jpg',
//                         //       height: 240.0,
//                         //       fit: BoxFit.fill,
//                         //     ),
//                         //   ),
//                         // ],
//                         // ),
//                       ),
//                       // Positioned(
//                       //   bottom: 10,
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.center,
//                       //     children: _buildPageIndicatorAnimated(),
//                       //   ),
//                       // ),
//                       // ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Divider(
//                         height: 1.5,
//                         color: theme.dividerColor,
//                         thickness: 2,
//                       ),
//                     ]),
//                 // #d32a27
//                 Padding(
//                     padding: EdgeInsets.all(24),
//                     child: Column(children: <Widget>[
//                       Container(
//                         margin: EdgeInsets.only(top: 0),
//                         child: FxText.h6("Welcome to LDCE Alumni Portal            ",
//                             color: Color(0xffd32a27), fontWeight: 800),
//                       ),
//                       Divider(
//                         height: 1.5,
//                         color: theme.dividerColor,
//                         thickness: 1,
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: 20),
//                         child: Text("Transforming Engineering For Human Happiness           ",
//                             textAlign: TextAlign.start,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             )
//                             // style: AppTheme.getTextStyle(
//                             //     themeData.textTheme.bodyText2,
//                             //     color: themeData.colorScheme.onBackground,
//                             //     fontWeight: 600,
//                             //     muted: true),
//                             ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(top: 10),
//                         child: Text(
//                           "To promote fellowship among alumni, exchange ideas, spread knowledge, stimulate thinking and help L.D. College of Engineering to provide excellence in the field of Engineering",
//                           textAlign: TextAlign.justify,
//                           // style: AppTheme.getTextStyle(
//                           //     themeData.textTheme.bodyText2,
//                           //     color: themeData.colorScheme.onBackground,
//                           //     fontWeight: 600,
//                           //     muted: true),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(top: 16, left: 16, right: 16),
//                         child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
//                           Expanded(
//                             flex: 1,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 GridView.count(
//                                     shrinkWrap: true,
//                                     physics: const ClampingScrollPhysics(),
//                                     crossAxisCount: 2,
//                                     padding: EdgeInsets.zero,
//                                     mainAxisSpacing: 10,
//                                     childAspectRatio: 3 / 2,
//                                     crossAxisSpacing: 20,
//                                     children: <Widget>[
//                                       SinglePageItem(
//                                         iconData: MdiIcons.newspaperVariant,
//                                         navigation: 'news_home',
//                                         title: "News",
//                                       ),
//                                       const SinglePageItem(
//                                         iconData: MdiIcons.calendar,
//                                         navigation: "events_home",
//                                         title: "Events",
//                                       ),
//                                       const SinglePageItem(
//                                         iconData: MdiIcons.image,
//                                         navigation: "media_home",
//                                         title: "Media Gallery",
//                                       ),
//                                       const SinglePageItem(
//                                           iconData: MdiIcons.humanMale,
//                                           navigation: "noteworthy_home",
//                                           title: "Noteworthy Mentions"),
//                                     ]),
//                                 // Container(
//                                 //   margin: Spacing.fromLTRB(24, 24, 24, 0),
//                                 //   child: Text(
//                                 //     "How we can help you?",
//                                 //     style: AppTheme.getTextStyle(themeData.textTheme.subtitle1,
//                                 //         letterSpacing: -0.15,
//                                 //         color: themeData.colorScheme.onBackground,
//                                 //         fontWeight: 600,
//                                 //         muted: true),
//                                 //   ),
//                                 // ),
//                                 // Container(
//                                 //   margin: Spacing.top(24),
//                                 //   child: Row(
//                                 //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 //     children: [
//                                 //       singleHelpWidget(
//                                 //           position: 0, iconData: MdiIcons.calendar, title: "Events"),
//                                 //       singleHelpWidget(
//                                 //           position: 1, iconData: MdiIcons.cash, title: "Funding"),
//                                 //     ],
//                                 //   ),
//                                 // ),
//                                 // Container(
//                                 //   margin: Spacing.top(24),
//                                 //   child: Row(
//                                 //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 //     children: [
//                                 //       singleHelpWidget(
//                                 //           position: 2,
//                                 //           iconData: MdiIcons.officeBuilding,
//                                 //           title: "Placements"),
//                                 //       singleHelpWidget(
//                                 //           position: 3,
//                                 //           iconData: MdiIcons.hospitalBuilding,
//                                 //           title: "Infrastructure"),
//                                 //     ],
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           )
//                         ]),
//                       ),
//                       // const SingleNewsWidget(
//                       //   image: './assets/images/ld.jpg',
//                       //   date: "5  Sep 2021",
//                       //   headline: "PLACEMENT IN LDCE DURING COVID PANDEMIC",
//                       //   shortDescription:
//                       //       "Job package offer of Rs 3 lakh to Rs 5 lakh to 1175 LD Engineering students despite 2 years corona.",
//                       // ),
//                       // const SingleNewsWidget(
//                       //   image: './assets/images/ld.jpg',
//                       //   date: "10  Sep 2021",
//                       //   headline: "PLACEMENT IN LDCE",
//                       //   shortDescription:
//                       //       "Job package offer of Rs 5 lakh to Rs 5 lakh to 117*5 LD Engineering students despite 2 years corona.",
//                       // ),
//
//                       // Container(
//                       //     // padding: EdgeInsets.all(10),
//                       //     child: Row(
//                       //       mainAxisAlignment:
//                       //           MainAxisAlignment.start, //Center Row contents horizontally
//                       //       children: <Widget>[
//                       //         SinglePageItem(
//                       //           iconData: MdiIcons.newspaperVariant,
//                       //           navigation: 'news_home',
//                       //           title: "News\n",
//                       //         ),
//                       //         SizedBox(
//                       //           width: 5,
//                       //         ),
//                       //         SinglePageItem(
//                       //           iconData: MdiIcons.calendar,
//                       //           navigation: "events_home",
//                       //           title: "Events\n",
//                       //         ),
//                       //         SizedBox(
//                       //           width: 5,
//                       //         ),
//                       //         SinglePageItem(
//                       //           iconData: MdiIcons.image,
//                       //           navigation: "media_home",
//                       //           title: "Media Gallery",
//                       //         ),
//                       //         SizedBox(
//                       //           width: 5,
//                       //         ),
//                       //         SinglePageItem(
//                       //             iconData: MdiIcons.humanMale,
//                       //             navigation: "noteworthy_home",
//                       //             title: "Noteworthy Mentions"),
//                       //       ],
//                       //     )),
//                       // SizedBox(
//                       //   height: 20,
//                       // ),
//                       // Container(
//                       //     margin: EdgeInsets.fromLTRB(24, 16, 24, 0),
//                       //     child: ElevatedButton(
//                       //       onPressed: () {
//                       //         Navigator.pushNamed(context, 'alumni_directory_home',
//                       //             arguments: homeProvider.news);
//                       //       },
//                       //       child: FxText.b1("Alumni Directory",
//                       //           fontWeight: 600, color: theme.colorScheme.onPrimary),
//                       //       style: ButtonStyle(
//                       //           padding: MaterialStateProperty.all(
//                       //               EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
//                       //     )),
//                       // Column(
//                       //   children: _buildNewsList(),
//                       // ),
//                       // Container(
//                       //   margin: EdgeInsets.fromLTRB(24, 16, 24, 0),
//                       //   child: ElevatedButton(
//                       //     onPressed: () {
//                       //       Navigator.pushNamed(context, 'news_home', arguments: homeProvider.news);
//                       //     },
//                       //     child: FxText.b2("More News",
//                       //         fontWeight: 600, color: theme.colorScheme.onPrimary),
//                       //     style: ButtonStyle(
//                       //         padding: MaterialStateProperty.all(
//                       //             EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
//                       //   ),
//                       // )
//                     ])),
//                 // Container(
//                 //     // padding: EdgeInsets.all(08),
//                 //     child: Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally
//                 //   children: <Widget>[
//                 //     SinglePageItem(
//                 //       iconData: MdiIcons.newspaperVariant,
//                 //       navigation: 'news_home',
//                 //       title: "News",
//                 //     ),
//                 //     SizedBox(
//                 //       width: 5,
//                 //     ),
//                 //     SinglePageItem(
//                 //       iconData: MdiIcons.calendar,
//                 //       navigation: "events_home",
//                 //       title: "Events",
//                 //     ),
//                 //     SizedBox(
//                 //       width: 5,
//                 //     ),
//                 //     SinglePageItem(
//                 //       iconData: MdiIcons.image,
//                 //       navigation: "media_home",
//                 //       title: "Media Gallery",
//                 //     ),
//                 //     SizedBox(
//                 //       width: 5,
//                 //     ),
//                 //     SinglePageItem(
//                 //       iconData: MdiIcons.humanMale,
//                 //       navigation: "noteworthy_home",
//                 //       title: "Noteworthy Mentions",
//                 //       textSize: 13,
//                 //     ),
//                 //   ],
//                 // )),
//                 // SizedBox(
//                 //   height: 10,
//                 // ),
//                 Container(
//                     margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pushNamedAndRemoveUntil(
//                             'alumni_directory_home', ModalRoute.withName('home'));
//                         // Navigator.pushNamed(context, 'alumni_directory_home',
//                         //     arguments: homeProvider.news);
//                       },
//                       child: FxText.b1("Alumni Directory",
//                           fontWeight: 600, color: theme.colorScheme.onPrimary),
//                       style: ButtonStyle(
//                           padding: MaterialStateProperty.all(
//                               EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
//                     )),
//                 Container(
//                     margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                     child: ElevatedButton(
//                       onPressed: () async {
//                         showCustomNotification();
//                       },
//                       child: FxText.b1("Test", fontWeight: 600, color: theme.colorScheme.onPrimary),
//                       style: ButtonStyle(
//                           padding: MaterialStateProperty.all(
//                               EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
//                     )),
//               ]),
//           // body: ListView(
//           //   padding: FxSpacing.fromLTRB(24, 44, 24, 64),
//           //   children: [
//           //     Row(
//           //       children: [
//           //         FxContainer.bordered(
//           //             onTap: () {
//           //               homeController.openLocationDialog();
//           //             },
//           //             splashColor: customTheme.homemadeSecondary,
//           //             borderRadiusAll: 8,
//           //             paddingAll: 13,
//           //             color: customTheme.homemadeSecondary.withAlpha(28),
//           //             border: Border.all(
//           //                 color: customTheme.homemadeSecondary.withAlpha(120)),
//           //             child: Icon(
//           //               FeatherIcons.mapPin,
//           //               color: customTheme.homemadeSecondary,
//           //               size: 18,
//           //             )),
//           //         FxSpacing.width(16),
//           //         Expanded(
//           //             child: TextFormField(
//           //           controller: homeController.searchEditingController,
//           //           style: FxTextStyle.b2(),
//           //           cursorColor: customTheme.homemadeSecondary,
//           //           decoration: InputDecoration(
//           //             hintText: "Search",
//           //             hintStyle: FxTextStyle.b2(
//           //                 color: theme.colorScheme.onBackground.withAlpha(150)),
//           //             border: OutlineInputBorder(
//           //                 borderRadius: BorderRadius.all(
//           //                   Radius.circular(8),
//           //                 ),
//           //                 borderSide: BorderSide.none),
//           //             enabledBorder: OutlineInputBorder(
//           //                 borderRadius: BorderRadius.all(
//           //                   Radius.circular(8),
//           //                 ),
//           //                 borderSide: BorderSide.none),
//           //             focusedBorder: OutlineInputBorder(
//           //                 borderRadius: BorderRadius.all(
//           //                   Radius.circular(8),
//           //                 ),
//           //                 borderSide: BorderSide.none),
//           //             filled: true,
//           //             fillColor: customTheme.card,
//           //             prefixIcon: Icon(
//           //               FeatherIcons.search,
//           //               size: 20,
//           //               color: theme.colorScheme.onBackground.withAlpha(150),
//           //             ),
//           //             isDense: true,
//           //             contentPadding: EdgeInsets.only(right: 16),
//           //           ),
//           //           textCapitalization: TextCapitalization.sentences,
//           //         )),
//           //         FxSpacing.width(16),
//           //         FxContainer.bordered(
//           //             onTap: () {
//           //               homeController.openEndDrawer();
//           //             },
//           //             color: customTheme.homemadeSecondary.withAlpha(28),
//           //             border: Border.all(
//           //                 color: customTheme.homemadeSecondary.withAlpha(120)),
//           //             borderRadiusAll: 8,
//           //             paddingAll: 13,
//           //             child: Icon(
//           //               FeatherIcons.sliders,
//           //               color: customTheme.homemadeSecondary,
//           //               size: 18,
//           //             )),
//           //       ],
//           //     ),
//           //     FxSpacing.height(16),
//           //     Column(
//           //       children: _buildShopList(),
//           //     ),
//           //   ],
//           // ),
//           // )
//         );
//       }
//     });
//   }
//
//   List<Widget> _buildPageIndicatorAnimated() {
//     List<Widget> list = [];
//     for (int i = 0; i < numPages; i++) {
//       list.add(i == _currentPage ? _indicator(true) : _indicator(false));
//     }
//     return list;
//   }
// }
// import 'package:flutkit/apps/ld_alumni/views/Events/event_home_screen.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ld_alumni/core/text.dart';
import 'package:ld_alumni/models/home/home.dart';
import 'package:ld_alumni/utils/local_notification_service.dart';
import 'package:ld_alumni/views/events/event_home_screen.dart';
import 'package:ld_alumni/views/events/single_internet_event_screen..dart';
import 'package:ld_alumni/views/general/no_internet_screen.dart';
import 'package:ld_alumni/views/news/single_notification_news_screen.dart';
import 'package:ld_alumni/views/widgets/app_bar_widget.dart';
import 'package:ld_alumni/views/widgets/app_drawer_widget.dart';
import 'package:ld_alumni/views/widgets/single_news_widget.dart';
import 'package:ld_alumni/views/loading_effect.dart';
import 'package:ld_alumni/theme/app_theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutx/flutx.dart';
import 'package:ld_alumni/views/widgets/single_grid_item.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ld_alumni/models/news/news.dart';
import 'package:provider/provider.dart';
import 'package:ld_alumni/controllers/home/home_controller.dart';
import 'package:ld_alumni/theme/app_notifier.dart';
import 'package:ld_alumni/theme/theme_type.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class HomeScreenOLD extends StatefulWidget {
  HomeScreenOLD({this.notificationAppLaunchDetails, Key? key}) : super(key: key);

  NotificationAppLaunchDetails? notificationAppLaunchDetails;

  @override
  _HomeScreenOLDState createState() => _HomeScreenOLDState();
}

class _HomeScreenOLDState extends State<HomeScreenOLD> {
  late CustomTheme customTheme;
  late HomeController homeProvider;
  // late HomeController homeController;
  bool isDark = false;

  late int numPages;
  String? selectedNotificationPayload;
  TextDirection textDirection = TextDirection.ltr;
  // late NewsController newsController;

  late ThemeData theme;

  late Timer timerAnimation;

  int _currentPage = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    // Never called
    // print("Disposing first route");
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemUiOverlayStyle(statusBarBrightness: Brightness.dark, statusBarColor: Colors.black);
    print("Home INIT");
    // newsController = FxControllerStore.putOrFind<NewsController>(NewsController());
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
        print("EVENTSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
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
    // for (Home singleImage in homeProvider.home) {
    //  //precacheImage(singleImage, context) ;
    // }
    // LocalNotificationService.initialize(context);

    /// TODO Terminated State
    /// 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and
    // you can get notification data in this method
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        final routeFromMessage = message.data["route"];
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

    /// TODO Foreground State
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
        LocalNotificationService.createAndDisplayNotification(message);
      }
    });

    /// TODO Background State
    /// 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        final routeFromMessage = message.data["route"];

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

  void preloadImages() {
    final homeProvider = Provider.of<HomeController>(context);
    for (var singleNews in homeProvider.news) {
      if (singleNews.imageUrl != "null") {
        final theImage = Image.network(
          'https://' + singleNews.imageUrl,
        );
        precacheImage(theImage.image, context);
        print("Precache");
      }
    }
  }

  checkInternet(buildContext) async {
    int timeout = 40;
    try {
      http.Response response =
          await http.get(Uri.parse('https://google.com')).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        // do something
      } else {
        // handle it
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
    } on SocketException catch (e) {
      print('Socket Error: $e');
      Navigator.push(buildContext, MaterialPageRoute(builder: (buildContext) => NoInternetScreen()));
    } on Error catch (e) {
      print('General Error: $e');
    }
  }

  // Widget _singleSliderImage(Home singleSliderPage) {
  //   return FadeInImage.assetNetwork(
  //     height: 1000,
  //     width: 1000,
  //     placeholder: './assets/images/banners/LDCE_2.jpg',
  //     image: "https://" + singleSliderPage.imageUrl,

  //     // child: Image.network(
  //     //   "https://"+singleSliderPage.imageUrl,
  //     //   height: 240.0,
  //     //   fit: BoxFit.fill,
  //     // ),
  //   );
  // }

  Widget _singleSliderImage(Home singleSliderPage) {
    return CachedNetworkImage(
      imageUrl: "https://" + singleSliderPage.imageUrl,
      placeholder: (context, url) => Image.asset(
        './assets/images/banners/LDCE_2.webp',
      ),
      // errorWidget: (context, url, error) => Icon(Icons.error),
    );

    // FadeInImage.assetNetwork(
    //   height: 1000,
    //   width: 1000,
    //   placeholder: './assets/images/banners/LDCE_2.jpg',
    //   image: "https://" + singleSliderPage.imageUrl,

    //   // child: Image.network(
    //   //   "https://"+singleSliderPage.imageUrl,
    //   //   height: 240.0,
    //   //   fit: BoxFit.fill,
    //   // ),
    // );
  }

  List<Widget> _buildSliderImage() {
    final homeProvider = Provider.of<HomeController>(context);

    List<Widget> list = [];
    for (Home singleImage in homeProvider.home) {
      list.add(_singleSliderImage(singleImage));
    }
    return list;
  }

  List<Widget> _buildNewsList() {
    final homeProvider = Provider.of<HomeController>(context);

    List<Widget> list = [];
    // newsController = FxControllerStore.putOrFind<NewsController>(NewsController());
    for (var i = 0; i <= 2; i++) {
      // print("i");
      // print(i);
      if (i < homeProvider.news.length) {
        list.add(_singleNews((homeProvider.news[i])));
        // print(homeProvider.news[i]);
      } else {}
    }
    // for (News singleNews in homeProvider.news) {
    //   list.add(_singleNews(singleNews));
    // }
    return list;
  }

  Widget _singleNews(News singleNews) {
    // print("Image url: " + singleNews.imageUrl);
    // print("Date: " + singleNews.date);
    // print("Title: " + singleNews.title);
    // print("desc: " + singleNews.shortDescription);
    return SingleNewsWidget(
      imageUrl: singleNews.imageUrl,
      date: singleNews.date,
      title: singleNews.title,
      shortDescription: singleNews.shortDescription,
      description: singleNews.description,
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withAlpha(140),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
    );
  }

  Widget _buildBody() {
    return Consumer2<AppNotifier, HomeController>(
        builder: (BuildContext context, AppNotifier value, homeProvider, Widget? child) {
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
        return Scaffold(
            backgroundColor: customTheme.card,
            body: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
                child: LoadingEffect.getHomeLoadingScreen(
                  context,
                )));
      } else {
        numPages = homeProvider.home.length;
        // preloadImages();

        // return Consumer2<AppNotifier,HomeController>(
        //     builder: (BuildContext context, AppNotifier value,HomeController homeProvider, Widget? child) {
        //   //inspect(value);

        //   isDark = AppTheme.themeType == ThemeType.dark;
        //   textDirection = AppTheme.textDirection;
        //   theme = AppTheme.theme;
        //   customTheme = AppTheme.customTheme;
        return Scaffold(
          key: _key,
          // extendBodyBehindAppBar: true,
          //key: homeProvider.scaffoldKey,
          appBar: AppBarWidget(
            scaffoldKey: _key,
            // title: "Home",
          ),
          endDrawer: AppDrawerWidget(),
          // drawer: AppDrawerWidget(),
          resizeToAvoidBottomInset: true,
          // primary: true,
          body:
              // SafeArea(child:
              ListView(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
                  physics: const ClampingScrollPhysics(),
                  children: <Widget>[
                Column(
                    // alignment: AlignmentDirectional.center,
                    children: <Widget>[
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
                        // child: PageView(
                        //   pageSnapping: true,
                        //   physics: const ClampingScrollPhysics(),
                        //   controller: _pageController,
                        //   onPageChanged: (int page) {
                        //     setState(() {
                        //       _currentPage = page;
                        //     });
                        //   },
                        //   children: _buildSliderImage(),
                        // <Widget>[
                        //   Padding(
                        //     padding: const EdgeInsets.only(right: 0),
                        //     child: Image.asset(
                        //       './assets/images/banners/LDCE_1.jpg',
                        //       height: 240.0,
                        //       fit: BoxFit.fill,
                        //     ),
                        //   ),
                        //   Padding(
                        //     padding: const EdgeInsets.all(0.0),
                        //     child: Image.asset(
                        //       './assets/images/banners/LDCE_2.jpg',
                        //       height: 240.0,
                        //       fit: BoxFit.fill,
                        //     ),
                        //   ),
                        //   Padding(
                        //     padding: const EdgeInsets.all(0.0),
                        //     child: Image.asset(
                        //       './assets/images/banners/LDCE_3.jpg',
                        //       height: 240.0,
                        //       fit: BoxFit.fill,
                        //     ),
                        //   ),
                        // ],
                        // ),
                      ),
                      // Positioned(
                      //   bottom: 10,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: _buildPageIndicatorAnimated(),
                      //   ),
                      // ),
                      // ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        height: 1.5,
                        color: theme.dividerColor,
                        thickness: 2,
                      ),
                    ]),
                // #d32a27
                Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 0),
                        child: FxText.h6("Welcome to LDCE Connect            ",
                            color: Color(0xffd32a27), fontWeight: 800),
                      ),
                      Divider(
                        height: 1.5,
                        color: theme.dividerColor,
                        thickness: 1,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text("Transforming Engineering For Human Happiness           ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )
                            // style: AppTheme.getTextStyle(
                            //     themeData.textTheme.bodyText2,
                            //     color: themeData.colorScheme.onBackground,
                            //     fontWeight: 600,
                            //     muted: true),
                            ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "To promote fellowship among alumni, exchange ideas, spread knowledge, stimulate thinking and help L.D. College of Engineering to provide excellence in the field of Engineering",
                          textAlign: TextAlign.justify,
                          // style: AppTheme.getTextStyle(
                          //     themeData.textTheme.bodyText2,
                          //     color: themeData.colorScheme.onBackground,
                          //     fontWeight: 600,
                          //     muted: true),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                GridView.count(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    crossAxisCount: 2,
                                    padding: EdgeInsets.zero,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 20,
                                    children: <Widget>[
                                      SinglePageItem(
                                        iconData: MdiIcons.newspaperVariant,
                                        navigation: 'news_home',
                                        title: "News",
                                      ),
                                      const SinglePageItem(
                                        iconData: MdiIcons.calendar,
                                        navigation: "events_home",
                                        title: "Events",
                                      ),
                                      const SinglePageItem(
                                        iconData: MdiIcons.image,
                                        navigation: "media_home",
                                        title: "Media Gallery",
                                      ),
                                      const SinglePageItem(
                                          iconData: MdiIcons.humanMale,
                                          navigation: "noteworthy_home",
                                          title: "Noteworthy Mentions"),
                                    ]),
                                // Container(
                                //   margin: Spacing.fromLTRB(24, 24, 24, 0),
                                //   child: Text(
                                //     "How we can help you?",
                                //     style: AppTheme.getTextStyle(themeData.textTheme.subtitle1,
                                //         letterSpacing: -0.15,
                                //         color: themeData.colorScheme.onBackground,
                                //         fontWeight: 600,
                                //         muted: true),
                                //   ),
                                // ),
                                // Container(
                                //   margin: Spacing.top(24),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //     children: [
                                //       singleHelpWidget(
                                //           position: 0, iconData: MdiIcons.calendar, title: "Events"),
                                //       singleHelpWidget(
                                //           position: 1, iconData: MdiIcons.cash, title: "Funding"),
                                //     ],
                                //   ),
                                // ),
                                // Container(
                                //   margin: Spacing.top(24),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //     children: [
                                //       singleHelpWidget(
                                //           position: 2,
                                //           iconData: MdiIcons.officeBuilding,
                                //           title: "Placements"),
                                //       singleHelpWidget(
                                //           position: 3,
                                //           iconData: MdiIcons.hospitalBuilding,
                                //           title: "Infrastructure"),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        ]),
                      ),
                      // const SingleNewsWidget(
                      //   image: './assets/images/ld.jpg',
                      //   date: "5  Sep 2021",
                      //   headline: "PLACEMENT IN LDCE DURING COVID PANDEMIC",
                      //   shortDescription:
                      //       "Job package offer of Rs 3 lakh to Rs 5 lakh to 1175 LD Engineering students despite 2 years corona.",
                      // ),
                      // const SingleNewsWidget(
                      //   image: './assets/images/ld.jpg',
                      //   date: "10  Sep 2021",
                      //   headline: "PLACEMENT IN LDCE",
                      //   shortDescription:
                      //       "Job package offer of Rs 5 lakh to Rs 5 lakh to 117*5 LD Engineering students despite 2 years corona.",
                      // ),

                      // Container(
                      //     // padding: EdgeInsets.all(10),
                      //     child: Row(
                      //       mainAxisAlignment:
                      //           MainAxisAlignment.start, //Center Row contents horizontally
                      //       children: <Widget>[
                      //         SinglePageItem(
                      //           iconData: MdiIcons.newspaperVariant,
                      //           navigation: 'news_home',
                      //           title: "News\n",
                      //         ),
                      //         SizedBox(
                      //           width: 5,
                      //         ),
                      //         SinglePageItem(
                      //           iconData: MdiIcons.calendar,
                      //           navigation: "events_home",
                      //           title: "Events\n",
                      //         ),
                      //         SizedBox(
                      //           width: 5,
                      //         ),
                      //         SinglePageItem(
                      //           iconData: MdiIcons.image,
                      //           navigation: "media_home",
                      //           title: "Media Gallery",
                      //         ),
                      //         SizedBox(
                      //           width: 5,
                      //         ),
                      //         SinglePageItem(
                      //             iconData: MdiIcons.humanMale,
                      //             navigation: "noteworthy_home",
                      //             title: "Noteworthy Mentions"),
                      //       ],
                      //     )),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Container(
                      //     margin: EdgeInsets.fromLTRB(24, 16, 24, 0),
                      //     child: ElevatedButton(
                      //       onPressed: () {
                      //         Navigator.pushNamed(context, 'alumni_directory_home',
                      //             arguments: homeProvider.news);
                      //       },
                      //       child: FxText.b1("Alumni Directory",
                      //           fontWeight: 600, color: theme.colorScheme.onPrimary),
                      //       style: ButtonStyle(
                      //           padding: MaterialStateProperty.all(
                      //               EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
                      //     )),
                      // Column(
                      //   children: _buildNewsList(),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(24, 16, 24, 0),
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.pushNamed(context, 'news_home', arguments: homeProvider.news);
                      //     },
                      //     child: FxText.b2("More News",
                      //         fontWeight: 600, color: theme.colorScheme.onPrimary),
                      //     style: ButtonStyle(
                      //         padding: MaterialStateProperty.all(
                      //             EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
                      //   ),
                      // )
                    ])),
                // Container(
                //     // padding: EdgeInsets.all(08),
                //     child: Row(
                //   mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally
                //   children: <Widget>[
                //     SinglePageItem(
                //       iconData: MdiIcons.newspaperVariant,
                //       navigation: 'news_home',
                //       title: "News",
                //     ),
                //     SizedBox(
                //       width: 5,
                //     ),
                //     SinglePageItem(
                //       iconData: MdiIcons.calendar,
                //       navigation: "events_home",
                //       title: "Events",
                //     ),
                //     SizedBox(
                //       width: 5,
                //     ),
                //     SinglePageItem(
                //       iconData: MdiIcons.image,
                //       navigation: "media_home",
                //       title: "Media Gallery",
                //     ),
                //     SizedBox(
                //       width: 5,
                //     ),
                //     SinglePageItem(
                //       iconData: MdiIcons.humanMale,
                //       navigation: "noteworthy_home",
                //       title: "Noteworthy Mentions",
                //       textSize: 13,
                //     ),
                //   ],
                // )),
                // SizedBox(
                //   height: 10,
                // ),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            'alumni_directory_home', ModalRoute.withName('home'));
                        // Navigator.pushNamed(context, 'alumni_directory_home',
                        //     arguments: homeProvider.news);
                      },
                      child: FxText.b1("Alumni Directory",
                          fontWeight: 600, color: theme.colorScheme.onPrimary),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        LocalNotificationService.showStaticNotification(
                            123456789, "Test Notification", "BOdy of Notification");
                      },
                      child: FxText.b1("TEST", fontWeight: 600, color: theme.colorScheme.onPrimary),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
                    )),
              ]),
          // body: ListView(
          //   padding: FxSpacing.fromLTRB(24, 44, 24, 64),
          //   children: [
          //     Row(
          //       children: [
          //         FxContainer.bordered(
          //             onTap: () {
          //               homeController.openLocationDialog();
          //             },
          //             splashColor: customTheme.homemadeSecondary,
          //             borderRadiusAll: 8,
          //             paddingAll: 13,
          //             color: customTheme.homemadeSecondary.withAlpha(28),
          //             border: Border.all(
          //                 color: customTheme.homemadeSecondary.withAlpha(120)),
          //             child: Icon(
          //               FeatherIcons.mapPin,
          //               color: customTheme.homemadeSecondary,
          //               size: 18,
          //             )),
          //         FxSpacing.width(16),
          //         Expanded(
          //             child: TextFormField(
          //           controller: homeController.searchEditingController,
          //           style: FxTextStyle.b2(),
          //           cursorColor: customTheme.homemadeSecondary,
          //           decoration: InputDecoration(
          //             hintText: "Search",
          //             hintStyle: FxTextStyle.b2(
          //                 color: theme.colorScheme.onBackground.withAlpha(150)),
          //             border: OutlineInputBorder(
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(8),
          //                 ),
          //                 borderSide: BorderSide.none),
          //             enabledBorder: OutlineInputBorder(
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(8),
          //                 ),
          //                 borderSide: BorderSide.none),
          //             focusedBorder: OutlineInputBorder(
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(8),
          //                 ),
          //                 borderSide: BorderSide.none),
          //             filled: true,
          //             fillColor: customTheme.card,
          //             prefixIcon: Icon(
          //               FeatherIcons.search,
          //               size: 20,
          //               color: theme.colorScheme.onBackground.withAlpha(150),
          //             ),
          //             isDense: true,
          //             contentPadding: EdgeInsets.only(right: 16),
          //           ),
          //           textCapitalization: TextCapitalization.sentences,
          //         )),
          //         FxSpacing.width(16),
          //         FxContainer.bordered(
          //             onTap: () {
          //               homeController.openEndDrawer();
          //             },
          //             color: customTheme.homemadeSecondary.withAlpha(28),
          //             border: Border.all(
          //                 color: customTheme.homemadeSecondary.withAlpha(120)),
          //             borderRadiusAll: 8,
          //             paddingAll: 13,
          //             child: Icon(
          //               FeatherIcons.sliders,
          //               color: customTheme.homemadeSecondary,
          //               size: 18,
          //             )),
          //       ],
          //     ),
          //     FxSpacing.height(16),
          //     Column(
          //       children: _buildShopList(),
          //     ),
          //   ],
          // ),
          // )
        );
      }
    });
  }

  List<Widget> _buildPageIndicatorAnimated() {
    List<Widget> list = [];
    for (int i = 0; i < numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeController>(context);
    if (widget.notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      // SystemChrome.setSystemUIOverlayStyle(
      //     SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
    } else {
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //     statusBarColor: Colors.transparent.withOpacity(0.85), statusBarIconBrightness: Brightness.light));
    }

    // checkInternet(context);
    // return FxBuilder<HomeController>(
    //     controller: homeController,
    //     builder: (homeController) {
    return _buildBody();
    // });
  }
}
