import 'package:cached_network_image/cached_network_image.dart';
import 'package:ldce_alumni/controllers/news/news_controller.dart';
import 'package:ldce_alumni/core/card.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/models/news/news.dart';
import 'package:ldce_alumni/theme/app_notifier.dart';
import 'package:ldce_alumni/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:ldce_alumni/theme/theme_type.dart';
import 'package:ldce_alumni/utils/local_notification_service.dart';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:provider/provider.dart';
import 'package:ldce_alumni/core/globals.dart' as globals ;

class SingleInternetNewsScreen extends StatefulWidget {
  // final String? id;
  SingleInternetNewsScreen({
    Key? key,
    // this.id,
  }) : super(key: key);

  @override
  _SingleInternetNewsScreenState createState() => _SingleInternetNewsScreenState();
}

class _SingleInternetNewsScreenState extends State<SingleInternetNewsScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  bool isDark = false;
  late News singleNews;
  bool called = false;
  ScrollController thumbnailScrollController = ScrollController();
  late NewsController newsController;
  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.white,
    //   statusBarIconBrightness: Brightness.dark
    // ));
  }

  List<Widget> _buildImage(singleNews) {
    List<Widget> list = [];
    for (var i = 0; i < singleNews.attachmentList.length; i++) {
      list.add(Container(
        decoration:
            BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(4))),
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        // padding: EdgeInsets.all(0),
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: GestureDetector(
            onScaleEnd: (details) {
              globals.showFullImage(
                  'https://' + singleNews.attachmentList![i], 'imageTag-' + i.toString(), context);
            },
            onDoubleTap: () {
              globals.showFullImage(
                  'https://' + singleNews.attachmentList![i], 'imageTag-' + i.toString(), context);
            },
            onTap: () {
              globals.showFullImage(
                  'https://' + singleNews.attachmentList![i], 'imageTag-' + i.toString(), context);
            },
            child:Image(
          image: CachedNetworkImageProvider('https://' + singleNews.attachmentList[i]),
          fit: BoxFit.cover,
        ),
      )));
    }
    return list;
  }

  List<Widget> _buildThumbnails(myController, singleNews) {
    List<Widget> list = [];

    for (int i = 0; i < singleNews.attachmentList.length; i++) {
      bool selected = myController.currentPage == i;
      list.add(Container(
          padding: EdgeInsets.only(bottom: 10),
          child: FxCard(
            onTap: () {
              myController.onPageChanged(i, fromUser: true);
              print(i);
              if (i > 6) {
                thumbnailScrollController.animateTo(
                  thumbnailScrollController.position.maxScrollExtent,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              }
            },
            borderRadiusAll: 4,
            bordered: selected,
            border: selected ? Border.all(color: theme.primaryColor, width: 3) : null,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Colors.transparent,
            paddingAll: 0,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Image(
              height: 40,
              width: 40,
              image: CachedNetworkImageProvider('https://' + singleNews.attachmentList[i]),
              fit: BoxFit.fill,
            ),
          )));
    }

    return list;
  }

  @override
  void dispose() {
    super.dispose();
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.black.withOpacity(0.85), statusBarIconBrightness: Brightness.light));
    newsController.currentPage = 0;
  }

  void showSnackBarWithFloating() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FxText.sh2("Error Loading News", color: theme.colorScheme.onPrimary),
        backgroundColor: theme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildBody() {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.white,
    //   statusBarIconBrightness: Brightness.dark
    // ));
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Consumer2<AppNotifier, NewsController>(
        builder: (BuildContext context, AppNotifier value, newsProvider, Widget? child) {
      //inspect(value);
      newsController = newsProvider;
      // newsProvider.getSingleNews(widget.id);
      newsProvider.getSingleNews(args.id, context);
      if (!called) {}
      called = true;
      // print("0 HomeProvider");
      isDark = AppTheme.themeType == ThemeType.dark;
      // textDirection = AppTheme.textDirection;
      theme = AppTheme.theme;
      customTheme = AppTheme.customTheme;
      if (newsProvider.exceptionCreated) {
        print("Exception created block");
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          print("Exception created block 1");
          Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
          showSnackBarWithFloating();
        });
      }
      if (newsProvider.uiLoading) {
        // print("HomeProvider");
        print(args.id);
        print("uiLoading+ UI test");

        print(newsProvider.uiLoading);
        print(newsProvider.exceptionCreated);
        newsProvider.getSingleNews(args.id, context);
        // newsProvider.getSingleNews(widget.id).then((News newQuestions) {
        //   singleNews = newQuestions;
        // });

        // print(singleNews);
        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
            ),
            backgroundColor: customTheme.card,
            body: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
                child: LoadingEffect.getHomeLoadingScreen(
                  context,
                )));
      } else {
        // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        //     statusBarColor:Colors.white,
        //     statusBarIconBrightness: Brightness.dark
        // ));
        singleNews = newsProvider.singleNews;
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: FxText.t1("News Details"),
            ),
            body: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                children: <Widget>[
                  // Container(
                  //   margin: EdgeInsets.only(top:16),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       InkWell(
                  //         onTap: () {
                  //           Navigator.pop(context);
                  //         },
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //               color: customTheme.card,
                  //               shape: BoxShape.circle,
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                     color: customTheme.shadowColor,
                  //                     spreadRadius: 2,
                  //                     blurRadius: 8,
                  //                     offset: Offset(0, 4))
                  //               ]),
                  //           padding: EdgeInsets.all(12),
                  //           child: Icon(
                  //             MdiIcons.chevronLeft,
                  //             color: theme.colorScheme.onBackground,
                  //             size: 20,
                  //           ),
                  //         ),
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //             color: customTheme.card,
                  //             shape: BoxShape.circle,
                  //             boxShadow: [
                  //               BoxShadow(
                  //                   color: customTheme.shadowColor,
                  //                   spreadRadius: 2,
                  //                   blurRadius: 8,
                  //                   offset: Offset(0, 4))
                  //             ]),
                  //         padding: EdgeInsets.all(12),
                  //         child: Icon(
                  //           MdiIcons.bookmarkOutline,
                  //           color: theme.colorScheme.onBackground,
                  //           size: 20,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  Expanded(
                      child: ListView(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Color(0xffd32a27),
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  // color: Colors.red,
                                  padding: EdgeInsets.all(6),
                                  child: InkWell(
                                      child: Column(children: [
                                        Icon(
                                          Icons.home,
                                          color: Colors.white,
                                        ),
                                        FxText.b2(
                                          "Home",
                                          color: Colors.white,
                                        )
                                      ]),
                                      onTap: () {
                                        Navigator.of(context).pushNamedAndRemoveUntil(
                                            'home', (Route<dynamic> route) => false);
                                      }))),
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                  width: 90,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xffffca02),
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  // color: Colors.red,
                                  padding: EdgeInsets.all(6),
                                  child: InkWell(
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.newspaper,
                                                color: Colors.white,
                                              ),
                                              FxText.b2(
                                                "All News",
                                                color: Colors.white,
                                              )
                                            ])),
                                    onTap: () {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          'news_home', ModalRoute.withName('home'));
                                    },
                                  ))),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      singleNews.imageUrl != "null"
                          ? GestureDetector(
                            onScaleEnd: (details) {
                              globals.showFullImage('https://' + singleNews.imageUrl,
                                  'imageTag-' + singleNews.imageUrl, context);
                            },
                            onDoubleTap: () {
                              globals.showFullImage('https://' + singleNews.imageUrl,
                                  'imageTag-' + singleNews.imageUrl, context);
                            },
                            onTap: () {
                              globals.showFullImage('https://' + singleNews.imageUrl,
                                  'imageTag-' + singleNews.imageUrl, context);
                            },
                            child: ClipRRect(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: CachedNetworkImage(
                                imageUrl: 'https://' + singleNews.imageUrl,
                              ),
                            ))
                          : ClipRRect(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              borderRadius: BorderRadius.all(Radius.circular(24)),
                              child: Image(
                                image: AssetImage('./assets/images/no-image.jpg'),
                              ),
                            ),
                      Container(
                        decoration: BoxDecoration(
                            color: customTheme.card,
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            boxShadow: [
                              BoxShadow(
                                  color: customTheme.shadowColor.withAlpha(120),
                                  blurRadius: 24,
                                  spreadRadius: 4)
                            ]),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Row(
                                      children: [
                                        FxText.caption(singleNews.date,
                                            fontSize: 15,
                                            color: theme.colorScheme.onBackground,
                                            fontWeight: 600,
                                            xMuted: true),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: FxText.h6(singleNews.title,
                                        color: theme.colorScheme.onBackground, fontWeight: 600),
                                  ),
                                  singleNews.shortDescription != "null" &&
                                          singleNews.description != "null"
                                      ? Container(
                                          margin: EdgeInsets.only(top: 16),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: FxText.caption(singleNews.shortDescription,
                                                    fontSize: 15,
                                                    color: theme.colorScheme.onBackground,
                                                    fontWeight: 600,
                                                    xMuted: true),
                                              )
                                            ],
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      singleNews.description != "null"
                          ? Container(
                              margin: EdgeInsets.only(top: 24),
                              child: FxText(
                                singleNews.description,
                                textAlign: TextAlign.justify,
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: FxText(
                                      singleNews.shortDescription,
                                      textAlign: TextAlign.justify,
                                    ),
                                  )
                                ],
                              ),
                            ),
                      if (singleNews.attachmentList.isNotEmpty)
                        Container(
                          margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
                          child: FxText.sh1("News Images",
                              fontWeight: 700, color: theme.colorScheme.onBackground),
                        ),
                      if (singleNews.attachmentList.isNotEmpty) Divider(),
                      // SizedBox(height: 16),
                      if (singleNews.attachmentList.isNotEmpty)
                        Column(children: <Widget>[
                          Container(
                            // padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(Radius.circular(4))),
                            clipBehavior: Clip.hardEdge,
                            margin: EdgeInsets.all(0),
                            height: 250,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: PageView(
                              allowImplicitScrolling: true,
                              pageSnapping: true,
                              physics: ClampingScrollPhysics(),
                              controller: newsProvider.pageController,
                              onPageChanged: (int page) {
                                thumbnailScrollController.animateTo(40 * page.toDouble(),
                                    duration: Duration(milliseconds: 600), curve: Curves.ease);
                                newsProvider.onPageChanged(page);
                              },
                              children: _buildImage(singleNews),
                            ),
                          ),
                          SingleChildScrollView(
                            controller: thumbnailScrollController,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: _buildThumbnails(newsProvider, singleNews),
                            ),
                          ),
                        ]),
                    ],
                  )),
                ],
              ),
            ));
      }
    });
  }

  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
    return _buildBody();
  }
}



/*

'Although the years 2020 and 2021 have been difficulties due to Corona, the placement in LD Engineering College has not been affected. From March 2020 to August 2021, 174 companies have offered job packages to 621 students while 554 students who passed in 2021 have been offered job packages ranging from Rs 5 lakh to Rs 7 lakh per annum. In the academic year 2019, approximately 104 companies from various sectors participated in the placement and offered jobs to 625 final year students of the college. But in 2020 and 2021 together companies from different sectors have offered jobs to 1175 students.\n\nAn average package of up to Rs 5 lakh per annum is being offered in placement. The number of students getting the job could go much higher as placements in LD Engineering are yet to run till December. L. D. Engineering\'s Placement Cell Coordinator Dr. Vinod Patel said, "Even during Corona, the placement cell of the college continued to operate online. All the placement process including aptitude test, group discussion, and personal interview was done online and online placement is still going on. "'
 */