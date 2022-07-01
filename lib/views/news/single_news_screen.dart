// import 'package:ldce_alumni/screens/news/news_editor_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ldce_alumni/controllers/news/news_controller.dart';
import 'package:ldce_alumni/core/card.dart';
import 'package:ldce_alumni/core/text.dart';
// import 'package:flutkit/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:ldce_alumni/theme/themes.dart';
// import 'package:flutx/flutx.dart';
import 'package:provider/provider.dart';

class SingleNewsScreen extends StatefulWidget {
  final String title, date, shortDescription, description, imageUrl;
  final List<String>? attachmentList;

  SingleNewsScreen(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.date,
      required this.shortDescription,
      required this.description,
      this.attachmentList})
      : super(key: key);

  @override
  _SingleNewsScreenState createState() => _SingleNewsScreenState();
}

class _SingleNewsScreenState extends State<SingleNewsScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  ScrollController thumbnailScrollController = ScrollController();
  late NewsController newsController;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.white,
    //   statusBarIconBrightness: Brightness.dark
    // ));
  }

  List<Widget> _buildImage() {
    List<Widget> list = [];
    for (var i = 0; i < widget.attachmentList!.length; i++) {
      list.add(Container(
        decoration:
            BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(4))),
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        // padding: EdgeInsets.all(0),
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: CachedNetworkImage(
          imageUrl: 'https://' + widget.attachmentList![i],
          fit: BoxFit.contain,
        ),
      ));
    }
    return list;
  }

  List<Widget> _buildThumbnails(myController) {
    List<Widget> list = [];

    for (int i = 0; i < widget.attachmentList!.length; i++) {
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
              image: CachedNetworkImageProvider('https://' + widget.attachmentList![i]),
              fit: BoxFit.fill,
            ),
          )));
    }

    return list;
  }

  @override
  void dispose() {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.black.withOpacity(0.85),
    //   statusBarIconBrightness: Brightness.light
    // ));
    super.dispose();
    newsController.currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    //     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.white,
    //   statusBarIconBrightness: Brightness.dark
    // ));
    return Consumer2<AppNotifier, NewsController>(
        builder: (BuildContext context, AppNotifier value, newsProvider, Widget? child) {
      newsController = newsProvider;
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // leading: Container(
            //     padding: EdgeInsets.only(top: 6),
            //     child: InkWell(
            //         child: Column(children: [Icon(Icons.home), FxText.b2("Home")]),
            //         onTap: () {
            //           Navigator.of(context)
            //               .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
            //         })),
            title: FxText.t1("News Details"),
            // actions: [
            //   InkWell(
            //     child: Container(
            //         padding: EdgeInsets.only(top: 6, right: 6),
            //         child: Column(children: [Icon(Icons.newspaper), FxText.b2("All News")])),
            //     onTap: () {
            //       Navigator.of(context)
            //           .pushNamedAndRemoveUntil('news_home', ModalRoute.withName('home'));
            //     },
            //   )
            // ],
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
                Container(
                    child: Expanded(
                        child: ListView(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 20),
                        child: Row(
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
                        )),
                    widget.imageUrl != "null"
                        ? ClipRRect(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl: 'https://' + widget.imageUrl,
                            ),
                          )
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
                                      FxText.caption(widget.date,
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
                                  child: FxText.h6(widget.title,
                                      color: theme.colorScheme.onBackground, fontWeight: 600),
                                ),
                                widget.shortDescription != "null" && widget.description != "null"
                                    ? Container(
                                        margin: EdgeInsets.only(top: 16),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: FxText.caption(widget.shortDescription,
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
                    widget.description != "null"
                        ? Container(
                            margin: EdgeInsets.only(top: 24),
                            child: FxText(
                              widget.description,
                              textAlign: TextAlign.justify,
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Row(
                              children: [
                                Flexible(
                                  child: FxText(
                                    widget.shortDescription,
                                    textAlign: TextAlign.justify,
                                  ),
                                )
                              ],
                            ),
                          ),
                    if (widget.attachmentList!.isNotEmpty)
                      Container(
                        margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
                        child: FxText.sh1("News Images",
                            fontWeight: 700, color: theme.colorScheme.onBackground),
                      ),
                    if (widget.attachmentList!.isNotEmpty) Divider(),
                    // SizedBox(height: 16),
                    if (widget.attachmentList!.isNotEmpty)
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
                            children: _buildImage(),
                          ),
                        ),
                        SingleChildScrollView(
                          controller: thumbnailScrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _buildThumbnails(newsProvider),
                          ),
                        ),
                      ]),
                  ],
                ))),
              ],
            ),
          ));
    });
  }
}

/*

'Although the years 2020 and 2021 have been difficulties due to Corona, the placement in LD Engineering College has not been affected. From March 2020 to August 2021, 174 companies have offered job packages to 621 students while 554 students who passed in 2021 have been offered job packages ranging from Rs 5 lakh to Rs 7 lakh per annum. In the academic year 2019, approximately 104 companies from various sectors participated in the placement and offered jobs to 625 final year students of the college. But in 2020 and 2021 together companies from different sectors have offered jobs to 1175 students.\n\nAn average package of up to Rs 5 lakh per annum is being offered in placement. The number of students getting the job could go much higher as placements in LD Engineering are yet to run till December. L. D. Engineering\'s Placement Cell Coordinator Dr. Vinod Patel said, "Even during Corona, the placement cell of the college continued to operate online. All the placement process including aptitude test, group discussion, and personal interview was done online and online placement is still going on. "'
 */