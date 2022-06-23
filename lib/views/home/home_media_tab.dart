import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ldce_alumni/controllers/home/home_controller.dart';
import 'package:ldce_alumni/controllers/news/news_controller.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/models/news/news.dart';
import 'package:ldce_alumni/theme/theme_type.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:ldce_alumni/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutx/flutx.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

import 'package:ldce_alumni/controllers/media/media_controller.dart';
import 'package:ldce_alumni/models/media/media.dart';
import 'package:ldce_alumni/views/media/single_media_screen.dart';
import 'package:ldce_alumni/views/news/single_news_screen.dart';
import 'package:ldce_alumni/views/widgets/app_bar_widget.dart';
import 'package:ldce_alumni/views/widgets/app_drawer_widget.dart';
import 'package:ldce_alumni/views/widgets/single_card_widget.dart';
import 'package:ldce_alumni/views/widgets/single_news_card_widget..dart';
import 'package:ldce_alumni/views/widgets/single_news_home_card_widget.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'single_product_screen.dart';

class HomeMediaTab extends StatefulWidget {
  HomeMediaTab({Key? key}) : super(key: key);
  @override
  _HomeMediaTabState createState() => _HomeMediaTabState();
}

class _HomeMediaTabState extends State<HomeMediaTab> {
  late ThemeData theme;
  late CustomTheme customTheme;
  // late HomeController homeController;
  bool isDark = false;
  // TextDirection textDirection = TextDirection.ltr;
  late HomeController newsProvider;
  // late SearchController searchController;
  late ScrollController _controller;
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

  Widget _buildSingleMedia(Media media) {
    return SingleCardWidget(
      imageUrl: media.coverPhoto,
      title: media.title,
      description: media.shortDescription,
      width: MediaQuery.of(context).size.width - 50,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleMediaScreen(
                      shortDescription: media.shortDescription,
                      imageList: media.imageList,
                      title: media.title,
                      description: media.description,
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

  List<Widget> _buildNewsList(List<Media> tempNews) {
    List<Widget> list = [];

    for (Media news in tempNews) {
      list.add(_buildSingleMedia(news));
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
      if (homeProvider.mediaUiLoading) {
        // print("HomeProvider");
        // homeProvider.getNews();
        homeProvider.fetchMedia();
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
                        child: FxText.h6("Media Gallery", color: Color(0xffd32a27), fontWeight: 800),
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
                      children: [_buildSingleMedia(homeProvider.singleMedia[0])],
                    ),
                    Container(
                        // height: 10,
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('media_home', ModalRoute.withName('home'));
                            // Navigator.pushNamed(context, 'alumni_directory_home',
                            //     arguments: homeProvider.news);
                          },
                          child: FxText.b1("View All Media",
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
