
import 'package:ldce_alumni/controllers/home/home_controller.dart';
import 'package:ldce_alumni/controllers/news/news_controller.dart';
import 'package:ldce_alumni/models/news/news.dart';
import 'package:ldce_alumni/theme/theme_type.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:flutter/material.dart';
// import 'package:flutx/flutx.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;
import 'package:ldce_alumni/views/news/single_news_screen.dart';
import 'package:ldce_alumni/views/widgets/app_bar_widget.dart';
import 'package:ldce_alumni/views/widgets/app_drawer_widget.dart';
import 'package:ldce_alumni/views/widgets/single_news_card_widget..dart';
import 'package:provider/provider.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  _NewsHomeScreenState createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  late ThemeData theme;
  late CustomTheme customTheme;
  // late HomeController homeController;
  bool isDark = false;
  // TextDirection textDirection = TextDirection.ltr;
  late HomeController newsProvider;
  // late SearchController searchController;
  late ScrollController _controller;
  late List<News> tempNews;

  int _page = 1;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  void initState() {
    super.initState();

    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
    _controller = new ScrollController()..addListener(_loadMore);
    newsProvider = HomeController();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  Widget _buildSingleNews(News news) {
    return SingleNewsCardWidget(
      imageUrl: news.imageUrl,
      title: news.title,
      description: news.shortDescription,
      date: news.date,
      attachmentList: news.attachmentList,
      width: MediaQuery.of(context).size.width - 48,
      onTap: () {
        // print("news");

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleNewsScreen(
                      title: news.title,
                      imageUrl: news.imageUrl,
                      date: news.date,
                      shortDescription: news.shortDescription,
                      description: news.description,
                      attachmentList: news.attachmentList,
                    )));
      },
    );

    // return InkWell(
    //   child: Container(
    //       padding: EdgeInsets.all(0),
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.all(Radius.circular(8)), border: Border.all()),
    //       clipBehavior: Clip.hardEdge,
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: <Widget>[
    //           Stack(
    //             children: [
    //               Image.asset(
    //                 media.imageUrl,
    //                 width: MediaQuery.of(context).size.width,
    //                 fit: BoxFit.cover,
    //                 height: 140,
    //               ),
    //             ],
    //           ),
    //           Container(
    //             padding: EdgeInsets.all(8),
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 FxText.t3(
    //                   media.title,
    //                   fontWeight: 700,
    //                   fontSize: 16,
    //                 ),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: <Widget>[
    //                     FxText.caption(
    //                       media.shortDescription.toString(),
    //                       fontWeight: 500,
    //                       fontSize: 15,
    //                     ),
    //                     // Container(
    //                     //   padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    //                     //   decoration: BoxDecoration(
    //                     //       color: customTheme.homemadeSecondary.withAlpha(36),
    //                     //       borderRadius: BorderRadius.all(Radius.circular(4))),
    //                     //   child: Row(
    //                     //     children: <Widget>[
    //                     //       Icon(
    //                     //         FeatherIcons.star,
    //                     //         color: customTheme.homemadeSecondary,
    //                     //         size: 10,
    //                     //       ),
    //                     //       SizedBox(
    //                     //         width: 4,
    //                     //       ),
    //                     //       FxText.b3(media.rating.toString(),
    //                     //           fontSize: 10,
    //                     //           color: customTheme.homemadeSecondary,
    //                     //           fontWeight: 600),
    //                     //     ],
    //                     //   ),
    //                     // ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       )),
    //   onTap: () {
    //     print("Push");
    //     // Navigator.push(
    //     //   context,
    //     //   MaterialPageRoute(builder: (context) => SingleProductScreen()),
    //     // );
    //   },
    // );
  }

  List<Widget> _buildNewsList(List<News> tempNews) {
    List<Widget> list = [];

    for (News news in tempNews) {
      list.add(_buildSingleNews(news));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.black.withOpacity(0.3),
    //   statusBarIconBrightness: Brightness.light
    // ));
    return _buildBody();
  }

  Widget _buildBody() {
    return Consumer2<AppNotifier, NewsController>(
        builder: (BuildContext context, AppNotifier value, newsProvider, Widget? child) {
      //inspect(value);
      globals.checkInternet(context);

      isDark = AppTheme.themeType == ThemeType.dark;
      // textDirection = AppTheme.textDirection;
      theme = AppTheme.theme;
      customTheme = AppTheme.customTheme;
      print("Has More Data NH:");
      print(newsProvider.hasMoreData);
      if (newsProvider.uiLoading) {
        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
            ),
            backgroundColor: customTheme.card,
            body: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
                child: LoadingEffect.getMediaHomeLoadingScreen(
                  context,
                )));
      } else {
        tempNews = newsProvider.news;
        if (_hasNextPage == false) {
          newsProvider.hasMoreData = false;
        }
        return Scaffold(
            key: _key,
            // extendBodyBehindAppBar: true,
            //  key: searchController.scaffoldKey,
            endDrawer: AppDrawerWidget(),
            // drawer: AppDrawerWidget(),
            appBar: AppBarWidget(
              scaffoldKey: _key,
              title: "News",
            ),
            body: ListView(
                controller: _controller,
                padding: EdgeInsets.only(top: AppBar().preferredSize.height * 0.3),
                children: <Widget>[
                  Container(
                      // margin: EdgeInsets.fromLTRB(24, 50, 24, 16),
                      child: Column(children: <Widget>[
                    Column(
                      children: _buildNewsList(tempNews),
                    ),
                  ])),

                  // when the _loadMore function is running
                  if (_isLoadMoreRunning == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),

                  // When nothing else to load
                  if (_hasNextPage == false)
                    Container(
                      padding: const EdgeInsets.only(top: 0, bottom: 40),
                      // color: Colors.amber,
                      child: Center(
                        child: Text('No More News'),
                      ),
                    ),
                ]));
      }
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isLoadMoreRunning == false &&
        newsProvider.hasMoreData == true &&
        _controller.position.extentAfter < 300 &&
        !globals.isAllNewsLoaded) {
      print('Scrolled');
      print('Before PageNumber:' + _page.toString());
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1
      print('After PageNumber:' + _page.toString());
      print(' _loadmoreHas More Data:' + newsProvider.hasMoreData.toString());

      await newsProvider.loadMore(_page);
      try {
        if (newsProvider.news.length > 0) {
          print("News list in News home:");
          print(newsProvider.news);
          setState(() {
            tempNews.addAll(newsProvider.news);
          });
        } else {
          print("No data");
          // This means there is no more data
          // and therefore, we will not send another GET request
          newsProvider.hasMoreData = false;
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong! $err');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
    // else {
    //   setState(() {
    //     _hasNextPage = false;
    //   });
    // }
  }
}
