import 'package:ldce_alumni/controllers/home/home_controller.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/models/digital_downloads/digital_downloads.dart';
import 'package:ldce_alumni/models/media/media.dart';
import 'package:ldce_alumni/theme/theme_type.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:flutter/material.dart';
import 'package:ldce_alumni/views/widgets/single_download_widget.dart';
// import 'package:flutx/flutx.dart';


import 'package:provider/provider.dart';
// import 'single_product_screen.dart';

class HomeDownloadsTab extends StatefulWidget {
  HomeDownloadsTab({Key? key}) : super(key: key);
  @override
  _HomeDownloadsTabState createState() => _HomeDownloadsTabState();
}

class _HomeDownloadsTabState extends State<HomeDownloadsTab> {
  late ThemeData theme;
  late CustomTheme customTheme;
  // late HomeController homeController;
  bool isDark = false;
  // TextDirection textDirection = TextDirection.ltr;
  late HomeController newsProvider;
  // late SearchController searchController;
  // late ScrollController _controller;
  late List<Media> tempNews;

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  void initState() {
    super.initState();

    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
    newsProvider = HomeController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _singleEvent(DigitalDownloads singleDesktopWall) {
    // print("Image url: " + singleNews.imageUrl);
    // print("Date: " + singleNews.date);
    // print("Title: " + singleNews.title);
    // print("desc: " + singleNews.shortDescription);
    return SingleDownloadWidget(
        pageTitle: singleDesktopWall.category,
        title: singleDesktopWall.title,
        // description: singleEvent.description,
        shortDescription: singleDesktopWall.description,
        imageUrl: singleDesktopWall.fileUrl,
        // startDate: singleEvent.startDate,
        // endDate: singleEvent.endDate,
        // venue: singleEvent.venue,
        // contactPerson: singleEvent.contactPerson,
        // attachmentList: singleEvent.attachmentList,
        width: MediaQuery.of(context).size.width * 0.9);
  }

  // List<Widget> _buildNewsList(List<DigitalDownloads> tempNews) {
  //   List<Widget> list = [];

  //   for (DigitalDownloads news in tempNews) {
  //     list.add(_singleEvent(news));
  //   }
  //   return list;
  // }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.black.withOpacity(0.3),
    //   statusBarIconBrightness: Brightness.light
    // ));
    return _buildBody();
  }

  Widget _buildBody() {
    return Consumer2<AppNotifier, HomeController>(
        builder: (BuildContext context, AppNotifier value, homeProvider, Widget? child) {
      //    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // statusBarColor: Colors.black.withOpacity(0.85),
      // statusBarIconBrightness: Brightness.light));
      //inspect(value);
      // print("0 HomeProvider");
      isDark = AppTheme.themeType == ThemeType.dark;

      theme = AppTheme.theme;
      customTheme = AppTheme.customTheme;
      if (homeProvider.digitalDownloadsUiLoading) {
        // print("HomeProvider");
        // homeProvider.getNews();
        homeProvider.fetchDownloads();
        return Scaffold(
            extendBodyBehindAppBar: true,
            // appBar: AppBar(
            //   automaticallyImplyLeading: false,
            //   elevation: 0,
            // ),
            backgroundColor: customTheme.card,
            body: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
                child: LoadingEffect.getHomeTabLoadingScreen(
                  context,
                )));
      } else {
        return Scaffold(
            key: _key,
            // extendBodyBehindAppBar: true,
            //  key: searchController.scaffoldKey,
            // endDrawer: AppDrawerWidget(),
            // drawer: AppDrawerWidget(),
            // appBar: AppBarWidget(
            //   scaffoldKey: _key,
            //   title: "News",
            // ),
            body: ListView(
                // controller: _controller,
                // padding: EdgeInsets.only(top: AppBar().preferredSize.height * 0.3),
                children: <Widget>[
                  Container(
                      // margin: EdgeInsets.fromLTRB(24, 50, 24, 16),
                      child: Column(children: <Widget>[
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: FxText.h6("Digital Downloads", color: Color(0xffd32a27), fontWeight: 800),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Divider(
                            height: 1.5,
                            color: theme.dividerColor,
                            thickness: 1,
                          ))
                    ]),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [_singleEvent(homeProvider.singleDigitalDownload[0])],
                    ),
                    Container(
                        // height: 10,
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('downloads_home', ModalRoute.withName('home'));
                            // Navigator.pushNamed(context, 'alumni_directory_home',
                            //     arguments: homeProvider.news);
                          },
                          child: FxText.b1("View All Downloads",
                              fontWeight: 600, color: theme.colorScheme.onPrimary),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
                        ))
                  ])),
                ]));
      }
    });
  }
}
