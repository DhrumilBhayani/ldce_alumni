import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ldce_alumni/controllers/alumni/alumni_controller.dart';
import 'package:ldce_alumni/controllers/digital_downloads/digital_downloads_controller.dart';
import 'package:ldce_alumni/controllers/events/events_controller.dart';
import 'package:ldce_alumni/controllers/home/home_controller.dart';
import 'package:ldce_alumni/controllers/media/media_controller.dart';
import 'package:ldce_alumni/controllers/news/news_controller.dart';
import 'package:ldce_alumni/controllers/noteworthy/noteworthy_controller.dart';
import 'package:ldce_alumni/theme/app_notifier.dart';
import 'package:ldce_alumni/theme/app_theme.dart';
import 'package:ldce_alumni/utils/local_notification_service.dart';
import 'package:ldce_alumni/views/alumni_directory/alumni_directory_home.dart';
import 'package:ldce_alumni/views/digital_downloads/downloads_home_screen.dart';
import 'package:ldce_alumni/views/events/event_home_screen.dart';
import 'package:ldce_alumni/views/events/single_internet_event_screen..dart';
import 'package:ldce_alumni/views/general/about_us.dart';
import 'package:ldce_alumni/views/general/membership_types.dart';
import 'package:ldce_alumni/views/general/no_internet_screen.dart';
import 'package:ldce_alumni/views/general/something_wrong_screen.dart';
import 'package:ldce_alumni/views/home/home_screen.dart';
import 'package:ldce_alumni/views/media/media_home.dart';
import 'package:ldce_alumni/views/news/news_home.dart';
import 'package:ldce_alumni/views/news/single_notification_news_screen.dart';
import 'package:ldce_alumni/views/noteworthy/noteworthy_home.dart';
import 'package:ldce_alumni/views/projects/at_hackathon.dart';
import 'package:ldce_alumni/views/projects/tree_plantation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ldce_alumni/localizations/app_localization_delegate.dart';
import 'package:ldce_alumni/localizations/language.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

final navKey = new GlobalKey<NavigatorState>();
String? selectedNotificationPayload;
NotificationAppLaunchDetails? notificationAppLaunchDetails;
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

// flutter local notification
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// firebase background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A Background message just showed up :  ${message.messageId}');
  print('A Background message just showed up :  ${message.data}');
  LocalNotificationService.createAndDisplayNotification(message);
  // print('A Background message just showed up :  ${message.notification}');
}

Future<void> main() async {
  // firebase App initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

// Firebase local notification plugin
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  LocalNotificationService.initialize(navKey);
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload = notificationAppLaunchDetails!.payload;
    print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    print(selectedNotificationPayload);
    // Map jsonPayload = json.decode(selectedNotificationPayload!);
    // if (jsonPayload["type"].toString().toLowerCase().contains('news')) {
    //   print("NEWSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
    //   navKey.currentState!.pushNamed('single_internet_news_screen',arguments:ScreenArguments(jsonPayload['id']) );
    // }
    // if (jsonPayload["type"].toString().toLowerCase().contains('event') ||
    //     jsonPayload["type"].toString().toLowerCase().contains('events')) {
    //   print("EVENTSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
    //   navKey.currentState!.pushNamed('single_internet_events_screen',arguments:ScreenArguments(jsonPayload['id']) );
    // }
    print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
  }
//Firebase messaging
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  if (Platform.isAndroid) {
    FirebaseMessaging.instance.subscribeToTopic('all-android');
  }
  if (Platform.isIOS) {
    FirebaseMessaging.instance.subscribeToTopic('all-ios');
  }

  FirebaseMessaging.instance.subscribeToTopic('all-dhrumil');
  if (kDebugMode) {
    FirebaseMessaging.instance.subscribeToTopic('all-dhrumil-dev-11');
    FirebaseMessaging.instance.subscribeToTopic('all');
  }
  if (kReleaseMode) {
    // print = (Object object) {};
  }
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppNotifier()),
    ChangeNotifierProvider(create: (context) => HomeController()),
    ChangeNotifierProvider(create: (context) => EventsController()),
    ChangeNotifierProvider(create: (context) => MediaController()),
    ChangeNotifierProvider(create: (context) => NoteworthyController()),
    ChangeNotifierProvider(create: (context) => AlumniDirectoryController()),
    ChangeNotifierProvider(create: (context) => NewsController()),
    ChangeNotifierProvider(create: (context) => DigitalDownloadsController()),
    // ChangeNotifierProvider(create: (context) => SingleProductController()),
    //  ListenableProvider(create: (context) => Repo()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    print(token);
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

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (BuildContext context, AppNotifier value, Widget? child) {
        return MaterialApp(
          builder: (context, child) {
            getToken();
            final mediaQueryData = MediaQuery.of(context);
            final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.2);
            return MediaQuery(
              child: child!,
              data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
            );
          },
          navigatorKey: navKey,
          initialRoute: 'home',
          routes: {
            'home': (context) => HomeScreen(
                  notificationAppLaunchDetails: notificationAppLaunchDetails,
                ),
            'events_home': (context) => EventHomeScreen(),
            'media_home': (context) => MediaHomeScreen(),
            'news_home': (context) => NewsHomeScreen(),
            'noteworthy_home': (context) => NoteworthyHomeScreen(),
            'alumni_directory_home': (context) => AlumniDirectoryHome(),
            'single_internet_news_screen': (context) => SingleInternetNewsScreen(),
            'single_internet_events_screen': (context) => SingleInternetEventScreen(),
            'downloads_home': (context) => DownloadsHomeScreen(),
            'no_internet_screen': (context) => SingleInternetNewsScreen(),
            'tree_plantation': (context) => TreePlantationScreen(),
            'at_hackathon': (context) => ATHackathon(),
            'about_us': (context) => AboutUsScreen(),
            'membership_types': (context) => MemberShipTypes(),
            'something_wrong': (context) => SomethingWrongScreen(),
          },
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          // builder: (context, child) {
          //   return Directionality(
          //     textDirection: AppTheme.textDirection,
          //     child: child!,
          //   );
          // },
          localizationsDelegates: [
            AppLocalizationsDelegate(context),
            // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: Language.getLocales(),
          // home: IntroScreen(),
          // home: SplashScreen(),
          home: HomeScreen(
            notificationAppLaunchDetails: notificationAppLaunchDetails,
          ),
          // home: HomesScreen(),
        );
      },
    );
  }
}
