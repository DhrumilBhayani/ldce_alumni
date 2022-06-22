import 'package:ld_alumni/models/digital_downloads/digital_downloads.dart';
import 'package:ld_alumni/models/events/events.dart';
import 'package:ld_alumni/models/home/home.dart';
import 'package:ld_alumni/models/media/media.dart';
import 'package:ld_alumni/models/news/news.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:ld_alumni/core/globals.dart' as globals;
import 'package:ld_alumni/models/noteworthy/noteworthy.dart';

class HomeController with ChangeNotifier {
  bool showLoading = true,
      uiLoading = true,
      hasMoreData = true,
      preloadDone = false,
      newsUiLoading = true,
      eventUiLoading = true,
      mediaUiLoading = true,
      noteworthyUiLoading = true,
      digitalDownloadsUiLoading = true;
  late List<News> news;
  late List<News> singleNews;
  late List<Events> singleEvent;
  late List<Media> singleMedia;
  late List<Home> home;
  late List<Events> events;
  late List<Media> media;
  late List<Noteworthy> noteworthy;
  late List<Noteworthy> singleNoteworthy;
  late List<DigitalDownloads> singleDigitalDownload;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> selectedChoices = [];

  HomeController() {
    // fetchData();

    // getList();
  }
  Future fetchNews() async {
    singleNews = await News.getDummyList(pageSize: 1, pageNumber: 1);
    newsUiLoading = false;
    notifyListeners();
  }

  Future fetchEvents() async {
    singleEvent = await Events.getDummyList(pageSize: 1, pageNumber: 1);
    eventUiLoading = false;
    notifyListeners();
  }

  Future fetchMedia() async {
    singleMedia = await Media.getDummyList(pageSize: 1, pageNumber: 1);
    mediaUiLoading = false;
    notifyListeners();
  }

  Future fetchNoteworthy() async {
    singleNoteworthy = await Noteworthy.getDummyList(pageSize: 1, pageNumber: 1);
    noteworthyUiLoading = false;
    notifyListeners();
  }

  Future fetchDownloads() async {
    singleDigitalDownload = await DigitalDownloads.getDesktopWallpaperList(pageSize: 1, pageNumber: 1);
    digitalDownloadsUiLoading = false;
    notifyListeners();
  }

  Future fetchData() async {
    print("fetchData()");
    home = await Home.getDummyList();
    showLoading = false;
    uiLoading = false;
    notifyListeners();

    // notifyListeners();
    //update();
    // preloadAllData();
  }

  Future preloadAllData() async {
    print("GetNews()");
    //print(home.length);
    news = await News.getDummyList();
    // await Future.delayed(Duration(milliseconds: 500));
    showLoading = false;
    uiLoading = false;
    notifyListeners();
    // events = await Events.getUpcomingDummyList();
    // media = await Media.getDummyList();
    // noteworthy = await Noteworthy.getDummyList();
    // preloadDone = true;
    // notifyListeners();
    //print("fetchData(ffff) done");
  }

  Future loadMore(int pageNumber) async {
    print("loadMore");
    print(pageNumber);
    print("Has Mode data :");
    print(hasMoreData);
    if (hasMoreData && !globals.isAllNewsLoaded) {
      news = await News.getDummyList(pageNumber: pageNumber);
    }
    print("In controller");
    print(news);
    if (news.length <= 0) {
      print("object");
      hasMoreData = false;
      globals.isAllNewsLoaded = true;
    }
    notifyListeners();
  }
  // void getList() async {
  //   searchEditingController = TextEditingController();
  //   locationEditingController = TextEditingController();
  //   await Future.delayed(Duration(seconds: 1));
  //   shops = await Shop.getDummyList();

  //   showLoading = false;
  //   uiLoading = false;
  //   update();
  // }

}
