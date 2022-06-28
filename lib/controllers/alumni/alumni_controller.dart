import 'package:flutter/material.dart';
import 'package:ldce_alumni/models/alumni/alumni.dart';
// import 'package:provider/provider.dart';

class AlumniDirectoryController with ChangeNotifier {
  bool showLoading = true, uiLoading = true, hasMoreData = true, exceptionCreated = false;
  late List<Alumni> alumni;

  late TextEditingController searchEditingController;
  late TextEditingController locationEditingController;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  List<String> selectedChoices = [];
  RangeValues selectedRange = const RangeValues(200, 800);

  AlumniDirectoryController() {
    // fetchData();

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

  double findAspectRatio(double width) {
    //Logic for aspect ratio of grid view
    return ((width - 64) / 2) / (201);
  }

  Future fetchData() async {
    // print("fetchData()");
    try {
      alumni = await Alumni.getDummyList();
      showLoading = false;
      uiLoading = false;
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
    }
    // print("fetchData(ffff) done");
    notifyListeners();
  }

  Future getSearchResults({name, passoutYear, degree, branch, membershipType}) async {
    try {
      alumni = await Alumni.getSearchResult(
          name: name,
          passoutYear: passoutYear,
          degree: degree,
          branch: branch,
          membershipType: membershipType);
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
    }
    notifyListeners();
  }

  Future loadMore(int pageNumber) async {
    print("loadMore");
    print(pageNumber);
    print("Has Mode data :");
    print(hasMoreData);
    if (hasMoreData) {
      try {
        alumni = await Alumni.getDummyList(pageNumber: pageNumber);
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
      }
    }
    print("In controller");
    print(alumni);
    if (alumni.length <= 0) {
      print("object");
      hasMoreData = false;
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
