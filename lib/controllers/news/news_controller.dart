import 'package:flutter/material.dart';
import 'package:ldce_alumni/models/news/news.dart';

class NewsController with ChangeNotifier {
  bool showLoading = true, uiLoading = true, hasMoreData = true, exceptionCreated = false;
  late News singleNews;
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  late List<News> news;

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

  NewsController() {
    getNews();
  }
  Future getNews() async {
    print("GetNews()");
    //print(home.length);
    try {
      
    news = await News.getDummyList();
    // await Future.delayed(Duration(milliseconds: 500));
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
    notifyListeners();
    // events = await Events.getUpcomingDummyList();
    // media = await Media.getDummyList();
    // noteworthy = await Noteworthy.getDummyList();
    // preloadDone = true;
    // notifyListeners();
    //print("fetchData(ffff) done");
  }

  Future<dynamic> getSingleNews(newsId, context) async {
    print("getSingleNews");
    print(newsId);
    print("Has Mode data :");

    // try {
    //   singleNews = await News.getOneNews(newsId: newsId);
    // } catch (e){
    //
    // }
    try {
      singleNews = await News.getOneNews(newsId: newsId);
      uiLoading = false;
      showLoading = false;
      return singleNews;
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
    return "singleNews";
  }

  // print("In controller");
  // print(news);
  // if (singleNews.length <= 0) {
  //   print("object");
  //   hasMoreData = false;
  // }
}
