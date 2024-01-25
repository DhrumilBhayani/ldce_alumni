import 'package:intl/intl.dart';
import 'package:ldce_alumni/controllers/events/events_controller.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/core/text_style.dart';
import 'package:ldce_alumni/models/events/events.dart';
import 'package:ldce_alumni/theme/app_notifier.dart';
import 'package:ldce_alumni/theme/app_theme.dart';
import 'package:flutter/material.dart';
// import 'package:ldce_alumni/utils/local_notification_service.dart.bk';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:ldce_alumni/views/widgets/screen_arguments.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ldce_alumni/core/readmore.dart';
import 'package:provider/provider.dart';

class SingleInternetEventScreen extends StatefulWidget {
  // final String startDate, endDate, title, description, venue, contactPerson;
  // final String? id;

  const SingleInternetEventScreen({
    Key? key,
    // required this.startDate,
    // required this.endDate,
    // required this.title,
    // required this.description,
    // required this.venue,
    // required this.contactPerson,
    // this.time,
    // this.imageUrl,
    // this.id
  }) : super(key: key);
  @override
  _SingleInternetEventScreenState createState() => _SingleInternetEventScreenState();
}

class _SingleInternetEventScreenState extends State<SingleInternetEventScreen> {
  final String pageTitle = "Event Details";
  late CustomTheme customTheme;
  late ThemeData theme;
  late Events singleEvents;
  bool called = false;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor:Colors.white,
    //     statusBarIconBrightness: Brightness.dark
    // ));
  }

  @override
  void dispose() {
    super.dispose();
    // eventsController.currentPage = 0;
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor:Colors.black.withOpacity(0.85),
    //     statusBarIconBrightness: Brightness.light
    // ));
  }

  void showSnackBarWithFloating() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FxText.sh2("Error Loading Event", color: theme.colorScheme.onPrimary),
        backgroundColor: theme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildBody() {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor:Colors.white,
    //     statusBarIconBrightness: Brightness.dark
    // ));
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Consumer2<AppNotifier, EventsController>(
        builder: (BuildContext context, AppNotifier value, eventsProvider, Widget? child) {
      if (!called) {
        eventsProvider.getSingleEvent(args.id);
      }
      called = true;
      // print("0 HomeProvider");
      // isDark = AppTheme.themeType == ThemeType.dark;
      // textDirection = AppTheme.textDirection;
      theme = AppTheme.theme;
      customTheme = AppTheme.customTheme;
      if (eventsProvider.exceptionCreated) {
        print("Exception created block");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          print("Exception created block 1");
          Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
          showSnackBarWithFloating();
        });
      }
      if (eventsProvider.uiLoading) {
        // print("HomeProvider");
        print(args.id);
        print("uiLoading+ UI");

        print(eventsProvider.uiLoading);

        // newsProvider.getSingleNews(widget.id).then((News newQuestions) {
        //   singleNews = newQuestions;
        // });

        // print(singleNews);
        return Scaffold(
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
        singleEvents = eventsProvider.singleEvent;
        DateTime dateTime = DateTime.parse(singleEvents.startDate);
        print("dateTime");
        print(dateTime);
        DateTime startDateTime = DateTime.parse(singleEvents.startDate);
        DateTime endDateTime = DateTime.parse(singleEvents.endDate);
        // DateTime startDateDt = DateFormat('d/M/y').parse(singleEvents.startDate);
        // DateTime endDateDt = DateFormat('d/M/y').parse(singleEvents.endDate);
        var timeFormat = DateFormat('hh:mm a');
        var outputStartTime = timeFormat.format(startDateTime);
        final difference = endDateTime.difference(startDateTime).inDays;
        print(difference);

        return Scaffold(
            appBar: AppBar(
              title: FxText.t1(pageTitle),
            ),
            body: Column(
              children: [
                // singleEvents.imageUrl != null
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
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    children: [
                      singleEvents.coverPhoto != 'null'
                          ? Image(
                              image: NetworkImage('https://' + singleEvents.coverPhoto),
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.5,
                            )
                          : Image(
                              image: AssetImage('./assets/images/no-image.jpg'),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width * 0.55,
                            ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: FxText.h5(singleEvents.title,
                                  fontSize: 22, color: theme.colorScheme.onBackground, fontWeight: 600),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(24, 16, 24, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: theme.colorScheme.primary.withAlpha(24),
                                      borderRadius: BorderRadius.all(Radius.circular(8))),
                                  child: Icon(
                                    MdiIcons.calendar,
                                    size: 20,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        (difference > 0)
                                            ? FxText.caption(
                                                DateFormat('dd MMM, yyyy').format(startDateTime) +
                                                    ' to ' +
                                                    DateFormat('dd MMM, yyyy').format(endDateTime),
                                                fontSize: 14,
                                                fontWeight: 600,
                                                color: theme.colorScheme.onBackground)
                                            : FxText.caption(
                                                DateFormat('EEEE, dd MMM, yyyy').format(startDateTime),
                                                fontSize: 14,
                                                fontWeight: 600,
                                                color: theme.colorScheme.onBackground),
                                        outputStartTime != "null"
                                            ? Container(
                                                margin: EdgeInsets.only(top: 2),
                                                child: FxText.caption(outputStartTime,
                                                    fontSize: 14,
                                                    fontWeight: 600,
                                                    color: theme.colorScheme.onBackground,
                                                    xMuted: true),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: [
                                //     // InkWell(
                                //     //   onTap: () {
                                //     //     Navigator.pop(context);
                                //     //   },
                                //     //   child: Container(
                                //     //     padding: EdgeInsets.all(8),
                                //     //     decoration: BoxDecoration(
                                //     //       color: customTheme.card,
                                //     //       border: Border.all(color: customTheme.border, width: 1),
                                //     //       borderRadius: BorderRadius.all(Radius.circular(8)),
                                //     //     ),
                                //     //     child: Icon(MdiIcons.chevronLeft,
                                //     //         color: theme.colorScheme.onBackground.withAlpha(220), size: 20),
                                //     //   ),
                                //     // ),
                                //     Container(
                                //       padding: EdgeInsets.all(8),
                                //       decoration: BoxDecoration(
                                //         color: customTheme.card,
                                //         border: Border.all(color: customTheme.border, width: 1),
                                //         borderRadius: BorderRadius.all(Radius.circular(8)),
                                //       ),
                                //       child: Icon(MdiIcons.shareOutline,
                                //           color: theme.colorScheme.onBackground.withAlpha(220),
                                //           size: 20),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: theme.colorScheme.primary.withAlpha(24),
                                        borderRadius: BorderRadius.all(Radius.circular(8))),
                                    child: Icon(
                                      MdiIcons.mapMarker,
                                      size: 20,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FxText.caption(singleEvents.venue,
                                              fontSize: 14,
                                              fontWeight: 600,
                                              color: theme.colorScheme.onBackground),
                                          // Container(
                                          //   margin: EdgeInsets.only(top: 2),
                                          //   child: FxText.caption("SEAS, Ahmedabad University",
                                          //       fontWeight: 500,
                                          //       color: theme.colorScheme.onBackground,
                                          //       xMuted: true),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: theme.colorScheme.primary.withAlpha(24),
                                        borderRadius: BorderRadius.all(Radius.circular(8))),
                                    child: Icon(
                                      MdiIcons.contacts,
                                      size: 20,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FxText.caption("Contact Person",
                                              fontSize: 16,
                                              fontWeight: 500,
                                              color: theme.colorScheme.onBackground),
                                          Container(
                                            margin: EdgeInsets.only(top: 2),
                                            child: FxText.caption(singleEvents.contactPerson,
                                                fontSize: 14,
                                                fontWeight: 600,
                                                color: theme.colorScheme.onBackground,
                                                xMuted: true),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
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
                      singleEvents.description != "null"
                          ? Container(
                              margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
                              child: FxText.sh1("About This Event",
                                  fontWeight: 700, color: theme.colorScheme.onBackground),
                            )
                          : Container(),
                      singleEvents.description != "null"
                          ? Container(
                              margin: EdgeInsets.fromLTRB(24, 12, 24, 0),
                              child: ReadMoreText(
                                singleEvents.description,
                                textAlign: TextAlign.justify,
                                style: FxTextStyle.sh2(
                                    color: theme.colorScheme.onBackground, muted: true, fontWeight: 500),
                                trimLines: 5,
                                colorClickableText: Colors.black,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ), // RichText(
                              //   text: TextSpan(children: <TextSpan>[
                              //     TextSpan(
                              //         text:
                              //             "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                              // style: FxTextStyle.sh2(
                              //     color: theme.colorScheme.onBackground, muted: true, fontWeight: 500)),
                              //     TextSpan(
                              //         text: " Read More",
                              //         style:
                              //             FxTextStyle.caption(color: theme.colorScheme.primary, fontWeight: 600))
                              //   ]),
                              // ),
                            )
                          : Container(),
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
              ],
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor:Colors.white,
    //     statusBarIconBrightness: Brightness.dark
    // ));
    return _buildBody();
  }
}

