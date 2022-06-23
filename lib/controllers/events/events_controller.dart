import 'package:flutter/material.dart';
import 'package:ldce_alumni/models/events/events.dart';
// import 'package:provider/provider.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

class EventsController with ChangeNotifier {
  bool showLoading = true,
      uiLoading = true,
      hasMoreUpcomingData = true,
      hasMorePastData = true,
      exceptionCreated = false;
  late List<Events> upcomingEvents;
  late List<Events> pastEvents;
  late Events singleEvent;

  late TextEditingController searchEditingController;
  late TextEditingController locationEditingController;
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> selectedChoices = [];
  EventsController() {
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

  Future<dynamic> getSingleEvent(eventId) async {
    print("getSingleEvent");
    print(eventId);
    print("Has Mode data :");
    try {
      singleEvent = await Events.getOneEvent(eventId: eventId);
      uiLoading = false;
      showLoading = false;
      return singleEvent;
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
    print("fetchData()");
    upcomingEvents = await Events.getUpcomingDummyList();
    pastEvents = await Events.getPastDummyList();

    // await Future.delayed(Duration(seconds: 1));

    showLoading = false;
    uiLoading = false;
    // print("fetchData(ffff) done");
    notifyListeners();
  }

  Future loadMore(int pageNumber, String screenName) async {
    print("loadMore");
    print(pageNumber);
    print("Has Upcoming Mode data :");
    print(hasMoreUpcomingData);
    print("Has Past Mode data :");
    print(hasMorePastData);
    if (hasMoreUpcomingData && screenName == 'upcoming' && !globals.isAllUpcomingEventsLoaded) {
      upcomingEvents = await Events.getUpcomingDummyList(pageNumber: pageNumber);
    }
    if (hasMorePastData && screenName == 'past' && !globals.isAllPastEventsLoaded) {
      pastEvents = await Events.getPastDummyList(pageNumber: pageNumber);
    }
    print("In controller");
    print(upcomingEvents);
    if (upcomingEvents.length <= 0) {
      print("object");
      hasMoreUpcomingData = false;
      globals.isAllUpcomingEventsLoaded = true;
    }
    if (pastEvents.length <= 0) {
      print("object");
      globals.isAllPastEventsLoaded = true;
      hasMorePastData = false;
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
