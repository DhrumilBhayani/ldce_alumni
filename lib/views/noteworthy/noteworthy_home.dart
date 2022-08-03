import 'package:ldce_alumni/controllers/noteworthy/noteworthy_controller.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/models/noteworthy/noteworthy.dart';
import 'package:ldce_alumni/theme/theme_type.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:flutter/material.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;
import 'package:ldce_alumni/views/noteworthy/single_noteworthy_screen.dart';
import 'package:ldce_alumni/views/widgets/app_bar_widget.dart';
import 'package:ldce_alumni/views/widgets/app_drawer_widget.dart';
import 'package:ldce_alumni/views/widgets/single_alumni_card_widget..dart';
import 'package:provider/provider.dart';
// import 'single_product_screen.dart';

class NoteworthyHomeScreen extends StatefulWidget {
  const NoteworthyHomeScreen({Key? key}) : super(key: key);

  @override
  _NoteworthyHomeScreenState createState() => _NoteworthyHomeScreenState();
}

class _NoteworthyHomeScreenState extends State<NoteworthyHomeScreen> {
  late CustomTheme customTheme;
  // late HomeController homeController;
  bool isDark = false;

  late NoteworthyController noteworthyProvider;
  late List<Noteworthy> tempNoteworthy;
  TextDirection textDirection = TextDirection.ltr;
  late ThemeData theme;

  // late SearchController searchController;
  late ScrollController _controller;

  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  int _page = 1;

  @override
  void initState() {
    super.initState();

    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
    _controller = new ScrollController()..addListener(_loadMore);
    noteworthyProvider = NoteworthyController();
  }

  Widget _buildSingleNoteworthy(Noteworthy noteworthy) {
    print(noteworthy.coverPhoto);
    return SingleAlumniCardWidget(
      imageUrl: noteworthy.coverPhoto,
      title: noteworthy.alumniName + ' - ' + noteworthy.title,
      shortDescription: noteworthy.shortDescription,
      passoutYear: noteworthy.alumniPassoutYear,
      branch: noteworthy.alumniBranch,
      width: MediaQuery.of(context).size.width - 48,
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

  List<Widget> _buildNoteworthyList() {
    final noteworthyProvider = Provider.of<NoteworthyController>(context);

    List<Widget> list = [];

    for (Noteworthy noteworthy in noteworthyProvider.noteworthy) {
      list.add(_buildSingleNoteworthy(noteworthy));
    }
    return list;
  }

  Widget _buildBody() {
    return Consumer2<AppNotifier, NoteworthyController>(
        builder: (BuildContext context, AppNotifier value, noteworthyProvider, Widget? child) {
      //inspect(value);
      globals.checkInternet(context);
      isDark = AppTheme.themeType == ThemeType.dark;
      textDirection = AppTheme.textDirection;
      theme = AppTheme.theme;
      customTheme = AppTheme.customTheme;
      if (noteworthyProvider.exceptionCreated) {
        print("Exception created block");
        // Navigator.pushNamedAndRemoveUntil(context, 'something_wrong', (route) => false);
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          print("Exception created block 1");
          Navigator.pushNamedAndRemoveUntil(context, 'something_wrong', (route) => false);
          noteworthyProvider.uiLoading = false;
          // showSnackBarWithFloating();
        });
      }
      if (noteworthyProvider.uiLoading) {
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
        tempNoteworthy = noteworthyProvider.noteworthy;
        if (_hasNextPage == false) {
          noteworthyProvider.hasMoreData = false;
        }
        return !noteworthyProvider.exceptionCreated
            ? Scaffold(
               
                key: _key,
                endDrawer: AppDrawerWidget(),
                // drawer: AppDrawerWidget(),
                appBar: AppBarWidget(
                  scaffoldKey: _key,
                  title: "Noteworthy Mentions",
                ),
                body: Column(children: [
                  MaterialBanner(
                        content: FxText.b1("Noteworthy Mentions",
                            // fontSize: currentIndex == 0 ? 20 : null,
                            textAlign: TextAlign.left,
                            fontWeight: 600,
                            color: theme.colorScheme.onPrimary),
                        // contentTextStyle: const TextStyle(color: Colors.black, fontSize: 30),
                        backgroundColor:  Colors.black.withAlpha(200),
                        // leadingPadding: const EdgeInsets.only(right: 30),
                        actions: [
                          TextButton(onPressed: () {}, child: const Text('')),
                        ]),
                  Expanded(
                      child: ListView(controller: _controller, children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(24, AppBar().preferredSize.height * 0.3, 24, 16),
                      child: Column(
                        children: _buildNoteworthyList(),
                      ),
                    ),
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
                          child: Text('No More Noteworthy Mentions'),
                        ),
                      ),
                  ]))
                ]))
            : Scaffold(
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
      }
    });
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isLoadMoreRunning == false &&
        noteworthyProvider.hasMoreData == true &&
        _controller.position.extentAfter < 300 &&
        !globals.isAllNoteworthyLoaded) {
      print('Scrolled');
      print('Before PageNumber:' + _page.toString());
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1
      print('After PageNumber:' + _page.toString());
      print(' _loadmoreHas More Data:' + noteworthyProvider.hasMoreData.toString());

      await noteworthyProvider.loadMore(_page);
      try {
        if (noteworthyProvider.noteworthy.length > 0) {
          print("media list in media home:");
          print(noteworthyProvider.noteworthy);
          setState(() {
            tempNoteworthy.addAll(noteworthyProvider.noteworthy);
          });
        } else {
          print("No data");
          // This means there is no more data
          // and therefore, we will not send another GET request
          noteworthyProvider.hasMoreData = false;
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
