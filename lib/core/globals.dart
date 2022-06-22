library ld_alumni.globals;

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ld_alumni/views/general/no_internet_screen.dart';

bool isAllUpcomingEventsLoaded = false;
bool isAllPastEventsLoaded = false;
bool isAllNewsLoaded = false;
bool isAllMediaLoaded = false;
bool isAllNoteworthyLoaded = false;

bool isAllMobileSkinsLoaded = false;
bool isAllDesktopWallsLoaded = false;
bool isAllCalendarsLoaded = false;
bool isAllCampaingDLoaded = false;
bool isAllOtherMLoaded = false;

const String BASE_API_URL = 'https://ldcealumniapi.devitsandbox.com/api/';
int timeout = 40;

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
    Navigator.of(buildContext).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => NoInternetScreen()), (Route<dynamic> route) => false);
  } on Error catch (e) {
    print('General Error: $e');
  } on HandshakeException catch (e) {
    print('HandshakeException Error: $e');
    Navigator.of(buildContext).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => NoInternetScreen()), (Route<dynamic> route) => false);
  }
}
