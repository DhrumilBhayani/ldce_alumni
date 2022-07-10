import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:ldce_alumni/controllers/events/events_controller.dart';
import 'package:ldce_alumni/core/card.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:flutter/material.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ldce_alumni/core/readmore.dart';
import 'package:provider/provider.dart';

class SingleEventScreen extends StatefulWidget {
  final String startDate, endDate, title, description, venue, contactPerson;
  final String? imageUrl, time;
  final List<String>? attachmentList;

  const SingleEventScreen(
      {Key? key,
      required this.startDate,
      required this.endDate,
      required this.title,
      required this.description,
      required this.venue,
      required this.contactPerson,
      this.time,
      this.imageUrl,
      this.attachmentList})
      : super(key: key);
  @override
  _SingleEventScreenState createState() => _SingleEventScreenState();
}

class _SingleEventScreenState extends State<SingleEventScreen> {
  final String pageTitle = "Event Details";
  late CustomTheme customTheme;
  late ThemeData theme;
  ScrollController thumbnailScrollController = ScrollController();
  late EventsController eventsController;
  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    // print("Attachments:");
    // print(widget.attachmentList);
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

          // image: NetworkImage('https://' + widget.attachmentList![i]),
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
    super.dispose();
    eventsController.currentPage = 0;
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.black.withOpacity(0.85),
    //     statusBarIconBrightness: Brightness.light));
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.white,
    //     statusBarIconBrightness: Brightness.dark));
    var startDateTime, endDateTime;
    int difference = 0;
    if (widget.startDate != 'null') {
      DateTime dateTime = DateTime.parse(widget.startDate);

      print("dateTime");
      print(dateTime);
      startDateTime = DateTime.parse(widget.startDate);
    }
    if (widget.endDate != 'null') {
      endDateTime = DateTime.parse(widget.endDate);
      // DateTime startDateDt = DateFormat('d/M/y').parse(widget.startDate);
      // DateTime endDateDt = DateFormat('d/M/y').parse(widget.endDate);
      difference = endDateTime.difference(startDateTime).inDays;
      print(difference);
    }
    return Consumer2<AppNotifier, EventsController>(
        builder: (BuildContext context, AppNotifier value, eventsProvider, Widget? child) {
      eventsController = eventsProvider;
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: FxText.t1(pageTitle),
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
                padding: EdgeInsets.only(top: 0, bottom: 16),
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
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
                                    color: Color(0xff1692d0),
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  // color: Colors.red,
                                  padding: EdgeInsets.all(6),
                                  child: InkWell(
                                    child: Container(
                                        padding: EdgeInsets.only(),
                                        child: Column(children: [
                                          Icon(
                                            Icons.event,
                                            color: Colors.white,
                                          ),
                                          FxText.b2(
                                            "All Events",
                                            color: Colors.white,
                                          )
                                        ])),
                                    onTap: () {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                          'events_home', ModalRoute.withName('home'));
                                    },
                                  ))),
                        ],
                      )),
                  widget.imageUrl != null
                      ? Container(
                          margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                          child: Image(
                            image: CachedNetworkImageProvider('https://' + widget.imageUrl!),
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.5,
                          ))
                      : Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Image(
                            image: AssetImage('./assets/images/no-image.jpg'),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.55,
                          )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: FxText.h5(widget.title,
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
                                    widget.time != "null"
                                        ? Container(
                                            margin: EdgeInsets.only(top: 2),
                                            child: FxText.caption(widget.time!,
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
                                      FxText.caption(widget.venue,
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
                                        child: FxText.caption(widget.contactPerson,
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
                  widget.description != "null"
                      ? Container(
                          margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
                          child: FxText.sh1("About This Event",
                              fontWeight: 700, color: theme.colorScheme.onBackground),
                        )
                      : Container(),
                  widget.description != "null"
                      ? Container(
                          margin: EdgeInsets.fromLTRB(24, 12, 24, 0),
                          child: ReadMoreText(
                            widget.description,
                            textAlign: TextAlign.justify,
                            style: FxTextStyle.sh2(
                                color: theme.colorScheme.onBackground, muted: true, fontWeight: 500),
                            trimLines: 10,
                            colorClickableText: theme.colorScheme.onPrimary,
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
                  if (widget.attachmentList!.isNotEmpty)
                    Container(
                      margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
                      child: FxText.sh1("Event Images",
                          fontWeight: 700, color: theme.colorScheme.onBackground),
                    ),
                  if (widget.attachmentList!.isNotEmpty) Divider(),
                  // SizedBox(height: 16),
                  if (widget.attachmentList!.isNotEmpty)
                    Row(children: <Widget>[
                      SingleChildScrollView(
                        controller: thumbnailScrollController,
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: _buildThumbnails(eventsProvider),
                        ),
                      ),
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
                          controller: eventsProvider.pageController,
                          onPageChanged: (int page) {
                             thumbnailScrollController.animateTo(40 * page.toDouble(),
                                duration: Duration(milliseconds: 600), curve: Curves.ease);
                            eventsProvider.onPageChanged(page);
                          },
                          children: _buildImage(),
                        ),
                      ),
                    ]),
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
