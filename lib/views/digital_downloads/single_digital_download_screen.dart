import 'package:cached_network_image/cached_network_image.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:ldce_alumni/controllers/events/events_controller.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:flutter/material.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:provider/provider.dart';
import 'package:ldce_alumni/core/globals.dart' as globals ;

class SingleDigitalDownloadScreen extends StatefulWidget {
  final String title;
  final String? imageUrl, pageTitle;
  // final List<String>? attachmentList;

  const SingleDigitalDownloadScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.pageTitle,
  }) : super(key: key);
  @override
  _SingleDigitalDownloadScreenState createState() => _SingleDigitalDownloadScreenState();
}

class _SingleDigitalDownloadScreenState extends State<SingleDigitalDownloadScreen> {
  final String pageTitle = "Digital Download Details";
  late CustomTheme customTheme;
  late ThemeData theme;
  ScrollController thumbnailScrollController = ScrollController();
  late EventsController eventsController;
  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  void dispose() {
    super.dispose();
    eventsController.currentPage = 0;
    //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor:Colors.black.withOpacity(0.85),
    //     statusBarIconBrightness: Brightness.light
    //   ));
  }

  void showSnackBarWithFloating(String msg, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FxText.sh2(msg, color: theme.colorScheme.onPrimary),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _download(String url) async {
    showSnackBarWithFloating("Downloading.....", theme.primaryColor);
    GallerySaver.saveImage(url).then((value) {
      showSnackBarWithFloating("Saved To Gallery!", Colors.green);

      print(value);
      setState(() {
        print('Image is saved');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.white,
    //   statusBarIconBrightness: Brightness.dark
    // ));

    // DateTime startDateDt = DateFormat('d/M/y').parse(widget.startDate);
    // DateTime endDateDt = DateFormat('d/M/y').parse(widget.endDate);

    return Consumer2<AppNotifier, EventsController>(
        builder: (BuildContext context, AppNotifier value, eventsProvider, Widget? child) {
      eventsController = eventsProvider;
      return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.download),
            backgroundColor: theme.colorScheme.primary,
            onPressed: () {
              _download('https://' + widget.imageUrl!);
            },
          ),
          appBar: AppBar(
            title: widget.pageTitle != 'null' ? FxText.t1(widget.pageTitle!) : Text(""),
          ),
          body: Column(children: [
            // widget.imageUrl != null
            //     ? Stack(
            //         children: [

            //           // Positioned(
            //           //   child: Container(
            //           //     margin: EdgeInsets.fromLTRB(24, 48, 24, 0),
            //           //     child: Row(
            //           //       mainAxisAlignment: MainAxisAlignment.end,
            //           //       children: [
            //           //         // InkWell(
            //           //         //   onTap: () {
            //           //         //     Navigator.pop(context);
            //           //         //   },
            //           //         //   child: Container(
            //           //         //     padding: EdgeInsets.all(8),
            //           //         //     decoration: BoxDecoration(
            //           //         //       color: customTheme.card,
            //           //         //       border: Border.all(color: customTheme.border, width: 1),
            //           //         //       borderRadius: BorderRadius.all(Radius.circular(8)),
            //           //         //     ),
            //           //         //     child: Icon(MdiIcons.chevronLeft,
            //           //         //         color: theme.colorScheme.onBackground.withAlpha(220), size: 20),
            //           //         //   ),
            //           //         // ),
            //           //         // Container(
            //           //         //   padding: EdgeInsets.all(8),
            //           //         //   decoration: BoxDecoration(
            //           //         //     color: customTheme.card,
            //           //         //     border: Border.all(color: customTheme.border, width: 1),
            //           //         //     borderRadius: BorderRadius.all(Radius.circular(8)),
            //           //         //   ),
            //           //         //   child: Icon(MdiIcons.shareOutline,
            //           //         //       color: theme.colorScheme.onBackground.withAlpha(220), size: 20),
            //           //         // ),
            //           //       ],
            //           //     ),
            //           //   ),
            //           // )
            //         ],
            //       )
            //     : Container(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 10, bottom: 16),
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  width: 110,
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
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: Color(0xff1692d0),
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  padding: EdgeInsets.all(6),
                                  child: InkWell(
                                    child: Container(
                                        padding: EdgeInsets.only(top: 6, right: 6),
                                        child: Column(children: [
                                          Icon(
                                            Icons.download,
                                            color: Colors.white,
                                          ),
                                          FxText.b2(
                                            "All Downloads",
                                            color: Colors.white,
                                            fontSize: 12,
                                          )
                                        ])),
                                    onTap: () {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          'downloads_home', ModalRoute.withName('home'));
                                    },
                                  ))),
                        ],
                      )),
                  widget.imageUrl != null
                      ? GestureDetector(
                            onScaleEnd: (details) {
                              globals.showFullImage('https://' + widget.imageUrl!,
                                  'imageTag-' + widget.imageUrl!, context);
                            },
                            onDoubleTap: () {
                              globals.showFullImage('https://' + widget.imageUrl!,
                                  'imageTag-' + widget.imageUrl!, context);
                            },
                            onTap: () {
                              globals.showFullImage('https://' + widget.imageUrl!,
                                  'imageTag-' + widget.imageUrl!, context);
                            },
                            child: CachedNetworkImage(
                          imageUrl: 'https://' + widget.imageUrl!,
                          fit: widget.pageTitle == "Mobile Skins" ? BoxFit.fill : BoxFit.contain,
                          width: MediaQuery.of(context).size.width,
                          height: widget.pageTitle == "Mobile Skins"
                              ? MediaQuery.of(context).size.height * 0.75
                              : null,
                        ))
                      : Image(
                          image: AssetImage('./assets/images/no-image.jpg'),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * 0.55,
                        ),
                  SizedBox(
                    height: 15,
                  ),
                  // Container(
                  //   // margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //           margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  //           child: ElevatedButton(
                  //             onPressed: () {
                  //               _download('https://' + widget.imageUrl!);
                  //               // LocalNotificationService.showStaticNotification(
                  //               //     123456789, "Test Notification", "BOdy of Notification");
                  //             },
                  //             child: FxText.b1("Download",
                  //                 fontWeight: 600, color: theme.colorScheme.onPrimary),
                  //             style: ButtonStyle(
                  //                 padding: MaterialStateProperty.all(
                  //                     EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
                  //           )),
                  //       // Expanded(
                  //       //   child: FxText.h5(widget.title,
                  //       //       fontSize: 22, color: theme.colorScheme.onBackground, fontWeight: 600),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: Column(
                      children: [
                        // Container(
                        //   margin: EdgeInsets.only(top: 16),
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         padding: EdgeInsets.all(8),
                        //         decoration: BoxDecoration(
                        //             color: theme.colorScheme.primary.withAlpha(24),
                        //             borderRadius: BorderRadius.all(Radius.circular(8))),
                        //         child: Icon(
                        //           MdiIcons.tagOutline,
                        //           size: 18,
                        //           color: theme.colorScheme.primary,
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: Container(
                        //           margin: EdgeInsets.only(left: 16),
                        //           child: FxText.b2("\$99",
                        //               fontWeight: 600,
                        //               letterSpacing: 0.3,
                        //               color: theme.colorScheme.onBackground),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),

                  // Container(
                  //   margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
                  //   child: FxText.sh1("Location",
                  //       fontWeight: 700, color: theme.colorScheme.onBackground),
                  // ),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(24, 16, 24, 0),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.all(Radius.circular(8)),
                  //     child: Image(
                  //       image: AssetImage('./assets/other/map-md-snap.png'),
                  //       height: 200,
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),

                  // Container(
                  //   margin: EdgeInsets.fromLTRB(24, 16, 24, 0),
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     child: FxText.b2("More Info",
                  //         fontWeight: 600, color: theme.colorScheme.onPrimary),
                  //     style: ButtonStyle(
                  //         padding: MaterialStateProperty.all(
                  //             EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
                  //   ),
                  // )
                ],
              ),
            )
          ]));
    });
  }
}
