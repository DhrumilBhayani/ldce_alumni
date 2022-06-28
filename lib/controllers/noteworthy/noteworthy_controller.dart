import 'package:flutter/material.dart';
import 'package:ldce_alumni/models/noteworthy/noteworthy.dart';
// import 'package:provider/provider.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

class NoteworthyController with ChangeNotifier {
  bool showLoading = true, uiLoading = true, hasMoreData = true, exceptionCreated = false;
  late List<Noteworthy> noteworthy;

  late TextEditingController searchEditingController;
  late TextEditingController locationEditingController;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> selectedChoices = [];

  NoteworthyController() {
    fetchData();

    // getList();
  }
  double findAspectRatio(double width) {
    //Logic for aspect ratio of grid view
    return ((width - 64) / 2) / (201);
  }

  Future fetchData() async {
    // print("fetchData()");
    try {
      noteworthy = await Noteworthy.getDummyList();
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

  Future loadMore(int pageNumber) async {
    print("loadMore");
    print(pageNumber);
    print("Has Mode data :");
    print(hasMoreData && !globals.isAllNoteworthyLoaded);
    if (hasMoreData) {
      try {
        noteworthy = await Noteworthy.getDummyList(pageNumber: pageNumber);
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
    print(noteworthy);
    if (noteworthy.length <= 0) {
      print("object");
      hasMoreData = false;
      globals.isAllNoteworthyLoaded = true;
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
