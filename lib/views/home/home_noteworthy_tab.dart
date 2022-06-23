import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ldce_alumni/controllers/home/home_controller.dart';
import 'package:ldce_alumni/controllers/news/news_controller.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/models/news/news.dart';
import 'package:ldce_alumni/models/noteworthy/noteworthy.dart';
import 'package:ldce_alumni/theme/theme_type.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:ldce_alumni/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutx/flutx.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

import 'package:ldce_alumni/controllers/media/media_controller.dart';
import 'package:ldce_alumni/models/news/news.dart';
import 'package:ldce_alumni/views/news/single_news_screen.dart';
import 'package:ldce_alumni/views/noteworthy/single_noteworthy_screen.dart';
import 'package:ldce_alumni/views/widgets/app_bar_widget.dart';
import 'package:ldce_alumni/views/widgets/app_drawer_widget.dart';
import 'package:ldce_alumni/views/widgets/single_alumni_card_widget..dart';
import 'package:ldce_alumni/views/widgets/single_card_widget.dart';
import 'package:ldce_alumni/views/widgets/single_home_alumni_card_widget.dart';
import 'package:ldce_alumni/views/widgets/single_news_card_widget..dart';
import 'package:ldce_alumni/views/widgets/single_news_home_card_widget.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'single_product_screen.dart';

class HomeNoteworthyTab extends StatefulWidget {
  HomeNoteworthyTab({Key? key}) : super(key: key);
  @override
  _HomeNoteworthyTabState createState() => _HomeNoteworthyTabState();
}

class _HomeNoteworthyTabState extends State<HomeNoteworthyTab> {
  late ThemeData theme;
  late CustomTheme customTheme;
  // late HomeController homeController;
  bool isDark = false;
  // TextDirection textDirection = TextDirection.ltr;
  late HomeController newsProvider;
  // late SearchController searchController;
  late ScrollController _controller;
  late List<News> tempNews;

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

  Widget _buildSingleNoteworthy(Noteworthy noteworthy) {
    print(noteworthy.coverPhoto);
    return SingleHomeAlumniCardWidget(
      imageUrl: noteworthy.coverPhoto,
      title: noteworthy.alumniName + ' - ' + noteworthy.title,
      shortDescription: noteworthy.shortDescription,
      passoutYear: noteworthy.alumniPassoutYear,
      branch: noteworthy.alumniBranch,
      width: MediaQuery.of(context).size.width - 85,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleNoteworthyScreen(
                      title: noteworthy.title,
                      description: noteworthy.description,
                      shortDescription: noteworthy.shortDescription,
                      coverPhoto: noteworthy.coverPhoto,
                      alumniName: noteworthy.alumniName,
                      alumniBranch: noteworthy.alumniBranch,
                      alumniPassoutYear: noteworthy.alumniPassoutYear,
                    )));
        print("Noteworthy");
      },
    );
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
      if (homeProvider.noteworthyUiLoading) {
        // print("HomeProvider");
        // homeProvider.getNews();
        homeProvider.fetchNoteworthy();
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
                        child:
                            FxText.h6("Noteworthy Mentions", color: Color(0xffd32a27), fontWeight: 800),
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
                      children: [_buildSingleNoteworthy(homeProvider.singleNoteworthy[0])],
                    ),
                    Container(
                        // height: 10,
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('noteworthy_home', ModalRoute.withName('home'));
                            // Navigator.pushNamed(context, 'alumni_directory_home',
                            //     arguments: homeProvider.news);
                          },
                          child: FxText.b1("View All Noteworthy Mentions",
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
