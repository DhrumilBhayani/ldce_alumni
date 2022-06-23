import 'package:flutter/material.dart';
import 'package:ldce_alumni/models/digital_downloads/digital_downloads.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

class DigitalDownloadsController with ChangeNotifier {
  bool showLoading = true,
      uiLoading = true,
      hasMoreUpcomingData = true,
      hasMorePastData = true,
      exceptionCreated = false;
  late List<DigitalDownloads> mobileSkins;
  late List<DigitalDownloads> desktopWallpapers;
  late List<DigitalDownloads> calendars;
  late List<DigitalDownloads> campaignDownloads;
  late List<DigitalDownloads> otherMaterials;
  late DigitalDownloads singleDigitalDownload;

  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  DigitalDownloadsController() {
    fetchData();

    // getList();
  }

  onPageChanged(int page, {bool fromUser = false}) async {
    if (!fromUser) currentPage = page;
    notifyListeners();
    if (fromUser) {
      await pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
      );
    }
  }

  Future<dynamic> getSingleDigitalDownload(digitalDownloadId) async {
    print("getSingleEvent");
    print(digitalDownloadId);
    print("Has Mode data :");
    try {
      singleDigitalDownload = await DigitalDownloads.getOneEvent(eventId: digitalDownloadId);
      uiLoading = false;
      showLoading = false;
      return singleDigitalDownload;
    } on Exception catch (exception) {
      print("excep");

      print(exception);
      exceptionCreated = true;
      notifyListeners();
    } catch (error) {
      print("error");
      print(error);
      exceptionCreated = true;
      notifyListeners();
      // executed for errors of all types other than Exception
    }

    notifyListeners();
    print("uiLoading+ controller");
    print(uiLoading);
    return "singleEvent";
  }

  Future fetchData() async {
    mobileSkins = await DigitalDownloads.getMobileSkinsList();
    desktopWallpapers = await DigitalDownloads.getDesktopWallpaperList();
    calendars = await DigitalDownloads.getCalendarsList();
    campaignDownloads = await DigitalDownloads.getCampaignDownloadsList();
    otherMaterials = await DigitalDownloads.getOtherMList();

    showLoading = false;
    uiLoading = false;
    notifyListeners();
  }

  Future loadMore(int pageNumber, String screenName) async {
    if (hasMoreUpcomingData && screenName == 'mobile' && !globals.isAllMobileSkinsLoaded) {
      mobileSkins = await DigitalDownloads.getMobileSkinsList(pageNumber: pageNumber);
      if (mobileSkins.length <= 0) {
        hasMoreUpcomingData = false;
        globals.isAllMobileSkinsLoaded = true;
      }
    }
    if (hasMorePastData && screenName == 'desktop' && !globals.isAllDesktopWallsLoaded) {
      desktopWallpapers = await DigitalDownloads.getDesktopWallpaperList(pageNumber: pageNumber);
      if (desktopWallpapers.length <= 0) {
        print("object");
        globals.isAllDesktopWallsLoaded = true;
        hasMorePastData = false;
      }
    }
    if (hasMoreUpcomingData && screenName == 'calendar' && !globals.isAllCalendarsLoaded) {
      calendars = await DigitalDownloads.getCalendarsList(pageNumber: pageNumber);
      if (calendars.length <= 0) {
        print("object");
        hasMoreUpcomingData = false;
        globals.isAllCalendarsLoaded = true;
      }
    }
    if (hasMoreUpcomingData && screenName == 'campiagn' && !globals.isAllCampaingDLoaded) {
      campaignDownloads = await DigitalDownloads.getCampaignDownloadsList(pageNumber: pageNumber);
      if (campaignDownloads.length <= 0) {
        print("object");
        globals.isAllCampaingDLoaded = true;
        hasMorePastData = false;
      }
    }
    if (hasMorePastData && screenName == 'otherm' && !globals.isAllOtherMLoaded) {
      otherMaterials = await DigitalDownloads.getOtherMList(pageNumber: pageNumber);
      if (otherMaterials.length <= 0) {
        print("object");
        hasMoreUpcomingData = false;
        globals.isAllOtherMLoaded = true;
      }
    }
    print("In controller");
    print(mobileSkins);

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
