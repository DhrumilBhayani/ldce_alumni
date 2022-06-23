import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ldce_alumni/core/button.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:ldce_alumni/views/home/home_screen.dart';
// import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;

class NoInternetScreen extends StatefulWidget {
  @override
  _NoInternetScreenState createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  checkInternet(buildContext) async {
    int timeout = 40;
    try {
      http.Response response =
          await http.get(Uri.parse('https://google.com')).timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        // Navigator.pop(context);
        Navigator.of(buildContext).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()), (Route<dynamic> route) => false);
      } else {
        // handle it
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: $e');
    } on SocketException catch (e) {
      print('Socket Error: $e');
      setState(() {
        isLoading = false;
      });
      // Navigator.push(
      //     buildContext, MaterialPageRoute(builder: (buildContext) => NoInternetScreen()));
    } on Error catch (e) {
      print('General Error: $e');
    } on HandshakeException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(elevation: 0, automaticallyImplyLeading: false),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Icon(
                MdiIcons.wifiStrengthOffOutline,
                size: 64,
                color: theme.colorScheme.primary,
              )),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: FxText.h6("Whoops",
                    color: theme.colorScheme.onBackground, fontWeight: 600, letterSpacing: 0.2),
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: Column(
                  children: <Widget>[
                    FxText.b1(
                      "Slow or no internet connection",
                      letterSpacing: 0,
                      fontWeight: 500,
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: FxText.b1(
                        "Please check your internet settings",
                        letterSpacing: 0,
                        fontWeight: 500,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: FxButton(
                    elevation: 0,
                    borderRadiusAll: 4,
                    onPressed: () {
                      checkInternet(context);
                      setState(() {
                        isLoading = true;
                      });
                    },
                    child: FxText.button("Try again",
                        fontWeight: 600, color: theme.colorScheme.onPrimary, letterSpacing: 0.5)),
              ),
              if (isLoading) CircularProgressIndicator(),
            ],
          ),
        ));
  }
}
