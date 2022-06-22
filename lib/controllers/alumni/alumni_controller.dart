import 'package:flutter/material.dart';
import 'package:ld_alumni/models/alumni/alumni.dart';
// import 'package:provider/provider.dart';

class AlumniDirectoryController with ChangeNotifier {
  bool showLoading = true, uiLoading = true, hasMoreData = true;
  late List<Alumni> alumni;

  late TextEditingController searchEditingController;
  late TextEditingController locationEditingController;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  List<String> selectedChoices = [];
  RangeValues selectedRange = const RangeValues(200, 800);

  AlumniDirectoryController() {
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

  double findAspectRatio(double width) {
    //Logic for aspect ratio of grid view
    return ((width - 64) / 2) / (201);
  }

  Future fetchData() async {
    // print("fetchData()");
    alumni = await Alumni.getDummyList();

    // await Future.delayed(Duration(seconds: 1));

    showLoading = false;
    uiLoading = false;
    // print("fetchData(ffff) done");
    notifyListeners();
  }

  Future getSearchResults({name, passoutYear, degree, branch, membershipType}) async {
    alumni = await Alumni.getSearchResult(
        name: name,
        passoutYear: passoutYear,
        degree: degree,
        branch: branch,
        membershipType: membershipType);
    notifyListeners();
  }

  Future loadMore(int pageNumber) async {
    print("loadMore");
    print(pageNumber);
    print("Has Mode data :");
    print(hasMoreData);
    if (hasMoreData) {
      alumni = await Alumni.getDummyList(pageNumber: pageNumber);
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
