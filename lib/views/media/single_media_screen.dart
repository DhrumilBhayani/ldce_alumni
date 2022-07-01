// import 'package:ldce_alumni/screens/news/news_editor_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ldce_alumni/controllers/media/media_controller.dart';
import 'package:ldce_alumni/core/card.dart';
import 'package:ldce_alumni/core/text.dart';
// import 'package:flutkit/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:ldce_alumni/theme/themes.dart';
// import 'package:flutx/flutx.dart';
import 'package:provider/provider.dart';

class SingleMediaScreen extends StatefulWidget {
  final String title, description, shortDescription;
  final List<dynamic> imageList;
  SingleMediaScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.imageList,
  }) : super(key: key);

  @override
  _SingleMediaScreenState createState() => _SingleMediaScreenState();
}

class _SingleMediaScreenState extends State<SingleMediaScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  ScrollController thumbnailScrollController = ScrollController();
  late MediaController mediaController;
  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  List<Widget> _buildImage() {
    List<Widget> list = [];
    for (var i = 0; i < widget.imageList.length; i++) {
      list.add(Container(
          decoration: BoxDecoration(
              color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(4))),
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          // padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: CachedNetworkImage(
            imageUrl: 'https://' + widget.imageList[i]["Path"],
            fit: BoxFit.cover,
          )
          // Image(
          //   image: CachedNetworkImageProvider('https://' + widget.imageList[i]["Path"]),
          //   fit: BoxFit.cover,
          // ),
          ));
    }
    return list;
  }

  final double _height = 20.0;

  void _animateToIndex(int index, myController) {
    myController.animateTo(
      index * _height,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  List<Widget> _buildThumbnails(myController) {
    List<Widget> list = [];

    for (int i = 0; i < widget.imageList.length; i++) {
      bool selected = myController.currentPage == i;
      list.add(FxCard(
        onTap: () {
          myController.onPageChanged(i, fromUser: true);
          print(i);
          _animateToIndex(i, thumbnailScrollController);
          if (i > 6) {
            // thumbnailScrollController.animateTo(
            //   thumbnailScrollController.position.maxScrollExtent,
            //   duration: Duration(seconds: 1),
            //   curve: Curves.fastOutSlowIn,
            // );
          }
        },
        borderRadiusAll: 4,
        bordered: selected,
        border: selected ? Border.all(color: theme.primaryColor, width: 3) : null,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.transparent,
        paddingAll: 0,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: CachedNetworkImage(
          imageUrl: 'https://' + widget.imageList[i]["Path"],
          height: 40,
          width: 40,
          fit: BoxFit.fill,
        ),

        // Image(
        //   height: 40,
        //   width: 40,
        //   image: CachedNetworkImageProvider('https://' + widget.imageList[i]["Path"]),
        //   fit: BoxFit.fill,
        // ),
      ));
    }

    return list;
  }

  @override
  void dispose() {
    super.dispose();

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.black.withOpacity(0.85),
    //     statusBarIconBrightness: Brightness.light));
    mediaController.currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
    return Consumer2<AppNotifier, MediaController>(
        builder: (BuildContext context, AppNotifier value, mediaProvider, Widget? child) {
      mediaController = mediaProvider;
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: FxText.t1("Media Details"),
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
                    Column(children: <Widget>[
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
                                      decoration: BoxDecoration(
                                        color: Color(0xff07a44d),
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                      ),
                                      // color: Colors.red,
                                      padding: EdgeInsets.all(6),
                                      child: InkWell(
                                        child: Container(
                                            padding: EdgeInsets.only(),
                                            child: Column(children: [
                                              Icon(
                                                Icons.image,
                                                color: Colors.white,
                                              ),
                                              FxText.b2(
                                                "All Media",
                                                textAlign: TextAlign.center,
                                                color: Colors.white,
                                              )
                                            ])),
                                        onTap: () {
                                          Navigator.of(context).pushNamedAndRemoveUntil(
                                              'media_home', ModalRoute.withName('home'));
                                        },
                                      ))),
                            ],
                          )),
                      Container(
                        // padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        clipBehavior: Clip.hardEdge,
                        margin: EdgeInsets.all(0),
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: PageView(
                          allowImplicitScrolling: true,
                          pageSnapping: true,
                          physics: ClampingScrollPhysics(),
                          controller: mediaProvider.pageController,
                          onPageChanged: (int page) {
                            mediaProvider.onPageChanged(page);
                          },
                          children: _buildImage(),
                          // mediaProvider.images.map((ProductImage image) {
                          //   return Container(
                          //     decoration: BoxDecoration(
                          //         color: Colors.transparent,
                          //         borderRadius: BorderRadius.all(Radius.circular(4))),
                          //     // clipBehavior: Clip.antiAliasWithSaveLayer,
                          //     // padding: EdgeInsets.all(0),
                          //     margin: EdgeInsets.symmetric(
                          //         horizontal: mediaProvider.containerType == ImageResType.landscape
                          //             ? 0
                          //             : 5),
                          //     child: Image(
                          //       image: AssetImage(image.url),
                          //       fit: mediaProvider.containerType == ImageResType.landscape
                          //           ? BoxFit.fill
                          //           : BoxFit.cover,
                          //     ),
                          //   );
                          // }).toList(),
                        ),
                      ),
                      SizedBox(height: 16),
                      SingleChildScrollView(
                        controller: thumbnailScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _buildThumbnails(mediaProvider),
                        ),
                      ),
                    ]),
                    SizedBox(height: 16),
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
                                  child: FxText.h6(widget.title,
                                      color: theme.colorScheme.onBackground, fontWeight: 600),
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     print("object");
                                //     // Navigator.push(
                                //     //     context,
                                //     //     MaterialPageRoute(
                                //     //         builder: (context) =>
                                //     //             NewsEditorProfileScreen()));
                                //   },
                                //   child:

                                SizedBox(
                                  height: 10,
                                ),
                                widget.shortDescription != "null" && widget.description != "null"
                                    ? Container(
                                        child: FxText.caption(widget.shortDescription,
                                            color: theme.colorScheme.onBackground,
                                            fontWeight: 600,
                                            xMuted: true),
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
                            margin: EdgeInsets.only(top: 24), child: FxText(widget.shortDescription)),
                  ],
                )),
              ],
            ),
          ));
    });
  }
}



 /**
  * 


 List<Widget> _buildImage() {
    List<Widget> list = [];
    for (var i = 0; i < widget.imageList.length; i++) {
      list.add(Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(4))),
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        // padding: EdgeInsets.all(0),
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Image(
          image: NetworkImage('https://' + widget.imageList[i]["Path"]),
          fit: BoxFit.cover,
        ),
      ));
    }
    return list;
  }

  List<Widget> _buildThumbnails(myController) {
    List<Widget> list = [];

    for (int i = 0; i < widget.imageList.length; i++) {
      bool selected = myController.currentPage == i;
      list.add(FxCard(
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
          image: NetworkImage('https://' + widget.imageList[i]["Path"]),
          fit: BoxFit.fill,
        ),
      ));
    }

    return list;
  }


  Column(children: <Widget>[
                      Container(
                        // padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        clipBehavior: Clip.hardEdge,
                        margin: EdgeInsets.all(0),
                        height: mediaProvider.containerType == ImageResType.landscape ? 200 : 250,
                        width: MediaQuery.of(context).size.width,
                        child: PageView(
                          allowImplicitScrolling: true,
                          pageSnapping: true,
                          physics: ClampingScrollPhysics(),
                          controller: mediaProvider.pageController,
                          onPageChanged: (int page) {
                            mediaProvider.onPageChanged(page);
                          },
                          children: _buildImage(),
                          // mediaProvider.images.map((ProductImage image) {
                          //   return Container(
                          //     decoration: BoxDecoration(
                          //         color: Colors.transparent,
                          //         borderRadius: BorderRadius.all(Radius.circular(4))),
                          //     // clipBehavior: Clip.antiAliasWithSaveLayer,
                          //     // padding: EdgeInsets.all(0),
                          //     margin: EdgeInsets.symmetric(
                          //         horizontal: mediaProvider.containerType == ImageResType.landscape
                          //             ? 0
                          //             : 5),
                          //     child: Image(
                          //       image: AssetImage(image.url),
                          //       fit: mediaProvider.containerType == ImageResType.landscape
                          //           ? BoxFit.fill
                          //           : BoxFit.cover,
                          //     ),
                          //   );
                          // }).toList(),
                        ),
                      ),
                      SizedBox(height: 16),
                      SingleChildScrollView(
                        controller: thumbnailScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _buildThumbnails(mediaProvider),
                        ),
                      ),
                    ]),
  */