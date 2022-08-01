import 'package:ldce_alumni/controllers/events/events_controller.dart';
import 'package:ldce_alumni/models/events/events.dart';
import 'package:ldce_alumni/views/widgets/single_event_widget.dart';
import 'package:ldce_alumni/theme/app_theme.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

import 'package:flutter/material.dart';
// import 'package:flutx/flutx.dart';

class EventPastScreen extends StatefulWidget {
  const EventPastScreen(this.events, {Key? key}) : super(key: key);

  final List<Events> events;

  @override
  _EventPastScreenState createState() => _EventPastScreenState();
}

class _EventPastScreenState extends State<EventPastScreen> {
  late CustomTheme customTheme;
  late EventsController eventsProvider;
  int selectedCategory = 0;
  late List<Events> tempEvents;
  late ThemeData theme;

  late ScrollController _controller;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  int _page = 1;

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    //  print("Past");
    // print(widget.events);
    _controller = new ScrollController()
      ..addListener(_loadMore);
    eventsProvider = EventsController();
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.black.withOpacity(0.85), statusBarIconBrightness: Brightness.light));
  }

  Widget build(BuildContext context) {
    //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor:Colors.black.withOpacity(0.85),
    //     statusBarIconBrightness: Brightness.light
    //   ));
    tempEvents = widget.events;
    // print(_controller.position);
    return ListView(
      padding: EdgeInsets.only(top: 10),
      controller: _controller,
      //padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
      children: [
        // Container(
        //   margin: FxSpacing.fromLTRB(24, 0, 24, 0),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             FxText.b2("Today 24 Aug, 2020",
        //                 fontWeight: 400,
        //                 letterSpacing: 0,
        //                 color: theme.colorScheme.onBackground),
        //             Container(
        //               child: FxText.h5("Discover Events",
        //                   fontSize: 24,
        //                   fontWeight: 700,
        //                   letterSpacing: -0.3,
        //                   color: theme.colorScheme.onBackground),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Stack(
        //         children: [
        //           FxContainer(
        //             padding: FxSpacing.all(10),
        //             borderRadiusAll: 4,
        //             child: Icon(
        //               MdiIcons.bell,
        //               size: 18,
        //               color: theme.colorScheme.onBackground.withAlpha(160),
        //             ),
        //           ),
        //           Positioned(
        //             right: 4,
        //             top: 4,
        //             child: Container(
        //               width: 6,
        //               height: 6,
        //               decoration: BoxDecoration(
        //                   color: customTheme.colorError, shape: BoxShape.circle),
        //             ),
        //           )
        //         ],
        //       ),
        //       // FxContainer.none(
        //       //   margin: FxSpacing.left(16),
        //       //   borderRadiusAll: 4,
        //       //   clipBehavior: Clip.antiAliasWithSaveLayer,
        //       //   child: Image(
        //       //     image: AssetImage('./assets/images/profile/avatar_2.jpg'),
        //       //     width: 36,
        //       //     height: 36,
        //       //   ),
        //       // )
        //     ],
        //   ),
        // ),

        /* Find Events */
        // Container(
        //   margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: Container(
        //           padding: EdgeInsets.only(top: 4, bottom: 4),
        //           decoration: BoxDecoration(
        //               color: customTheme.card,
        //               border: Border.all(color: customTheme.border, width: 1),
        //               borderRadius: BorderRadius.all(Radius.circular(4))),
        //           child: Row(
        //             children: [
        //               Container(
        //                 margin: EdgeInsets.only(left: 12),
        //                 child: Icon(
        //                   MdiIcons.magnify,
        //                   color: theme.colorScheme.onBackground.withAlpha(200),
        //                   size: 16,
        //                 ),
        //               ),
        //               Expanded(
        //                 child: Container(
        //                   margin: EdgeInsets.only(left: 12),
        //                   child: TextFormField(
        //                     style: FxTextStyle.b2(
        //                         color: theme.colorScheme.onBackground, fontWeight: 500),
        //                     decoration: InputDecoration(
        //                       fillColor: customTheme.card,
        //                       hintStyle: FxTextStyle.b2(
        //                           color: theme.colorScheme.onBackground,
        //                           muted: true,
        //                           fontWeight: 500),
        //                       hintText: "Find Events...",
        //                       border: InputBorder.none,
        //                       enabledBorder: InputBorder.none,
        //                       focusedBorder: InputBorder.none,
        //                       isDense: true,
        //                     ),
        //                     textCapitalization: TextCapitalization.sentences,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       /* FxContainer(
        //               onTap: () {
        //                 // showDialog(
        //                 //     context: context,
        //                 //     builder: (BuildContext context) => EventFilterDialog());
        //               },
        //               margin: FxSpacing.left(16),
        //               padding: FxSpacing.all(12),
        //               borderRadiusAll: 4,
        //               color: theme.colorScheme.primary,
        //               child: Icon(
        //                 MdiIcons.tune,
        //                 size: 20,
        //                 color: theme.colorScheme.onPrimary,
        //               ),
        //             ),*/
        //     ],
        //   ),
        // ),
        // Container(
        //   margin: FxSpacing.top(8),
        //   padding: FxSpacing.vertical(8),
        //   child: SingleChildScrollView(
        //     scrollDirection: Axis.horizontal,
        //     child: Row(
        //       children: [
        //         Container(
        //           margin: FxSpacing.left(12),
        //           child: singleCategory(
        //               title: "All", iconData: MdiIcons.ballotOutline, index: 0),
        //         ),
        //         singleCategory(title: "Birthday", iconData: MdiIcons.cakeVariant, index: 1),
        //         singleCategory(title: "Party", iconData: MdiIcons.partyPopper, index: 2),
        //         singleCategory(title: "Talks", iconData: MdiIcons.chatOutline, index: 3),
        //         Container(
        //           margin: FxSpacing.right(24),
        //           child: singleCategory(title: "Food", iconData: MdiIcons.food, index: 4),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // Container(
        //   margin: FxSpacing.fromLTRB(24, 4, 24, 0),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: FxText.sh1("Popular",
        //             fontWeight: 700, color: theme.colorScheme.onBackground),
        //       ),
        //       //FxText.caption("View All", fontWeight: 600, color: theme.colorScheme.primary),
        //     ],
        //   ),
        // ),
        // Container(
        //   margin: FxSpacing.top(16),
        //   child: SingleChildScrollView(
        //     scrollDirection: Axis.horizontal,
        //     child: Row(
        //       children: [
        //         Container(
        //           margin: FxSpacing.left(24),
        //           child: SingleEventWidget(
        //               title: "Flutter Test",
        //               image: './assets/images/apps/event/pattern-1.png',
        //               date: "04",
        //               month: "May",
        //               subject: "California, US",
        //               time: "07:30 PM - 09:00 PM",
        //               width: MediaQuery.of(context).size.width * 0.6),
        //         ),
        //         Container(
        //           margin: FxSpacing.left(16),
        //           child: SingleEventWidget(
        //               title: "Flutter Dev",
        //               image: './assets/images/apps/social/post-l1.jpg',
        //               date: "29",
        //               month: "Feb",
        //               subject: "California, US",
        //               time: "07:30 PM - 09:00 PM",
        //               width: MediaQuery.of(context).size.width * 0.6),
        //         ),
        //         Container(
        //           margin: FxSpacing.fromLTRB(16, 0, 24, 0),
        //           child:SingleEventWidget (
        //               title: "Flutter Test",
        //               image: './assets/images/apps/event/pattern-1.png',
        //               date: "04",
        //               month: "May",
        //               subject: "California, US",
        //               time: "07:30 PM - 09:00 PM",
        //               width: MediaQuery.of(context).size.width * 0.6),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // Container(
        //   margin: FxSpacing.fromLTRB(24, 16, 24, 0),
        //   child: FxText.sh1("This Weekend",
        //       fontWeight: 700, color: theme.colorScheme.onBackground),
        // ),
        Container(
          margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Column(
            children: _buildEventsList(),
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
              child: Text('No More Events'),
            ),
          ),
      ],
    );
  }

  List<Widget> _buildEventsList() {
    // final eventsProvider = Provider.of<EventsController>(context);

    List<Widget> list = [];
    // newsController = FxControllerStore.putOrFind<NewsController>(NewsController());
    if (widget.events.isEmpty) {
      print("List Empty");
      list.add(Container(padding: EdgeInsets.only(top: 10), child: Text("There no Past Event.")));
    } else {
      for (Events singleNews in widget.events) {
        list.add(_singleEvent(singleNews));
      }
    }
    return list;
  }

  Widget _singleEvent(Events singleEvent) {
    // print("Image url: " + singleNews.imageUrl);
    // print("Date: " + singleNews.date);
    // print("Title: " + singleNews.title);
    // print("desc: " + singleNews.shortDescription);
    return SingleEventWidget(
        title: singleEvent.title,
        description: singleEvent.description,
        shortDescription: singleEvent.shortDescription,
        imageUrl: singleEvent.coverPhoto,
        startDate: singleEvent.startDate,
        endDate: singleEvent.endDate,
        venue: singleEvent.venue,
        contactPerson: singleEvent.contactPerson,
        attachmentList: singleEvent.attachmentList,
        width: MediaQuery.of(context).size.width - 50);
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isLoadMoreRunning == false &&
        eventsProvider.hasMorePastData == true &&
        _controller.position.extentAfter < 300 &&
        widget.events.isNotEmpty &&
        !globals.isAllPastEventsLoaded) {
      print('Scrolled');
      print('Before PageNumber:' + _page.toString());
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1
      print('After PageNumber:' + _page.toString());
      print(' _loadmoreHas More Data:' + eventsProvider.hasMoreUpcomingData.toString());

      await eventsProvider.loadMore(_page, 'past');
      try {
        if (eventsProvider.pastEvents.length > 0) {
          print("past list in News home:");
          print(eventsProvider.pastEvents);
          setState(() {
            tempEvents.addAll(eventsProvider.pastEvents);
          });
        } else {
          print("No data");
          // This means there is no more data
          // and therefore, we will not send another GET request
          eventsProvider.hasMorePastData = false;
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
}
