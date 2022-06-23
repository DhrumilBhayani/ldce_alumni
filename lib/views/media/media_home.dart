import 'package:ldce_alumni/theme/theme_type.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:flutter/material.dart';
// import 'package:flutx/flutx.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

import 'package:ldce_alumni/controllers/media/media_controller.dart';
import 'package:ldce_alumni/models/media/media.dart';
import 'package:ldce_alumni/views/media/single_media_screen.dart';
import 'package:ldce_alumni/views/widgets/app_bar_widget.dart';
import 'package:ldce_alumni/views/widgets/app_drawer_widget.dart';
import 'package:ldce_alumni/views/widgets/single_card_widget.dart';
import 'package:provider/provider.dart';
// import 'single_product_screen.dart';

class MediaHomeScreen extends StatefulWidget {
  const MediaHomeScreen({Key? key}) : super(key: key);

  @override
  _MediaHomeScreenState createState() => _MediaHomeScreenState();
}

class _MediaHomeScreenState extends State<MediaHomeScreen> {
  late CustomTheme customTheme;
  // late HomeController homeController;
  bool isDark = false;

  late MediaController mediaProvider;
  late List<Media> tempMedia;
  TextDirection textDirection = TextDirection.ltr;
  late ThemeData theme;

  // late SearchController searchController;

  late ScrollController _controller;

  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  int _page = 1;

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_loadMore);
  }

  @override
  void initState() {
    super.initState();

    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
    _controller = new ScrollController()..addListener(_loadMore);
    mediaProvider = MediaController();
  }

  Widget _buildSingleMedia(Media media) {
    return SingleCardWidget(
      imageUrl: media.coverPhoto,
      title: media.title,
      description: media.shortDescription,
      width: MediaQuery.of(context).size.width - 48,
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

  List<Widget> _buildMediaList() {
    final mediaProvider = Provider.of<MediaController>(context);

    List<Widget> list = [];

    for (Media media in mediaProvider.media) {
      list.add(_buildSingleMedia(media));
    }
    return list;
  }

  Widget _buildBody() {
    return Consumer2<AppNotifier, MediaController>(
        builder: (BuildContext context, AppNotifier value, mediaProvider, Widget? child) {
      globals.checkInternet(context);
      //inspect(value);
      isDark = AppTheme.themeType == ThemeType.dark;
      textDirection = AppTheme.textDirection;
      theme = AppTheme.theme;
      customTheme = AppTheme.customTheme;
      if (mediaProvider.uiLoading) {
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
        tempMedia = mediaProvider.media;
        if (_hasNextPage == false) {
          mediaProvider.hasMoreData = false;
        }
        return Scaffold(
            extendBodyBehindAppBar: true,
            key: _key,
            endDrawer: AppDrawerWidget(),
            // drawer: AppDrawerWidget(),
            appBar: AppBarWidget(
              scaffoldKey: _key,
              title: "Media Gallery",
            ),
            body: SafeArea(
                child: ListView(controller: _controller, children: [
              Container(
                margin: EdgeInsets.fromLTRB(24, AppBar().preferredSize.height * 0.3, 24, 16),
                child: Column(
                  children: _buildMediaList(),
                ),
              ),
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
                    child: Text('No More Media'),
                  ),
                ),
            ])));
      }
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isLoadMoreRunning == false &&
        mediaProvider.hasMoreData == true &&
        _controller.position.extentAfter < 300 &&
        !globals.isAllMediaLoaded) {
      print('Scrolled');
      print('Before PageNumber:' + _page.toString());
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1
      print('After PageNumber:' + _page.toString());
      print(' _loadmoreHas More Data:' + mediaProvider.hasMoreData.toString());

      await mediaProvider.loadMore(_page);
      try {
        if (mediaProvider.media.length > 0) {
          print("media list in media home:");
          print(mediaProvider.media);
          setState(() {
            tempMedia.addAll(mediaProvider.media);
          });
        } else {
          print("No data");
          // This means there is no more data
          // and therefore, we will not send another GET request
          mediaProvider.hasMoreData = false;
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

  @override
  Widget build(BuildContext context) {
    //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.black.withOpacity(0.85),
    //   statusBarIconBrightness: Brightness.light
    // ));
    return _buildBody();
  }
}
