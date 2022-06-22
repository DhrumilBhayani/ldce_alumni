import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:ld_alumni/views/digital_downloads/single_digital_download_screen.dart';
import 'package:ld_alumni/views/events/single_event_screen.dart';
import 'package:ld_alumni/core/text.dart';
import 'package:ld_alumni/theme/app_theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleDownloadWidget extends StatelessWidget {
  //final String? imageUrl, date, title, shortDescription;
  final String? imageUrl, pageTitle;
  final String title, shortDescription;
  final double? width;
  // final List<String>? attachmentList;
  const SingleDownloadWidget(
      {@required this.imageUrl,
      required this.title,
      required this.shortDescription,
      this.pageTitle,
      this.width,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl != "null") {
      // debugPrint(imageUrl);
    }
    ThemeData theme = Theme.of(context);
    late CustomTheme customTheme;
    customTheme = AppTheme.customTheme;
    // inspect(theme);
    bool isDark = false;
    // TextDirection textDirection = TextDirection.ltr;
    // DateTime startDateTime = DateTime.parse(startDate);
    // DateTime endDateTime = DateTime.parse(endDate);
    // // DateTime dt = DateFormat('y/M/d').parse(jsonArray["Result"][i]['StartDate']);
    // var dateFormat = DateFormat('dd MMM yyyy');
    // var timeFormat = DateFormat('hh:mm a');
    // var outputStartDate = dateFormat.format(startDateTime);
    // var outputStartTime = timeFormat.format(startDateTime);
    // var outputEndDate = dateFormat.format(endDateTime);
    // var outputEndTime = timeFormat.format(endDateTime);
    // return Consumer<AppNotifier>(builder: (BuildContext context, AppNotifier value, Widget? child) {
    //   isDark = AppTheme.themeType == ThemeType.dark;
    //   textDirection = AppTheme.textDirection;
    //   theme = AppTheme.theme;
    //   customTheme = AppTheme.customTheme;
    return InkWell(
      onTap: () {
        if (imageUrl != "null") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SingleDigitalDownloadScreen(
                        imageUrl: imageUrl,
                        title: title,
                        pageTitle: pageTitle,
                      )));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => SingleEventScreen(
          //               startDate: startDate,
          //               endDate: endDate,
          //               time: outputStartTime,
          //               title: title,
          //               description: description,
          //               venue: venue,
          //               contactPerson: contactPerson,
          //               imageUrl: imageUrl,
          //               attachmentList: attachmentList,
          //             )));
          debugPrint(title);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SingleDigitalDownloadScreen(
                        imageUrl: imageUrl,
                        title: title,
                        pageTitle: pageTitle,
                      )));
          debugPrint(title);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => SingleEventScreen(
          //               startDate: startDate,
          //               endDate: endDate,
          //               time: outputStartTime,
          //               title: title,
          //               description: description,
          //               venue: venue,
          //               contactPerson: contactPerson,
          //               attachmentList: attachmentList,
          //             )));
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: customTheme.card,
            border: Border.all(color: customTheme.border, width: 0.8),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUrl != "null"
                ? Container(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2), topRight: Radius.circular(2)),
                          child: CachedNetworkImage(
                            imageUrl: 'https://' + imageUrl!,
                            fit: BoxFit.cover,
                            width: width,
                            height: width! * 0.55,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2), topRight: Radius.circular(2)),
                          child: Image(
                            image: AssetImage('./assets/images/no-image.jpg'),
                            fit: BoxFit.cover,
                            width: width,
                            height: width! * 0.55,
                          ),
                        ),
                      ],
                    ),
                  ),
            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FxText.b1(title, color: theme.colorScheme.onBackground, fontWeight: 600),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // Icon(
                                  //   MdiIcons.calendar,
                                  //   size: 20,
                                  //   color: theme.colorScheme.primary,
                                  // ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  FxText.caption(title,
                                      fontSize: 14,
                                      color: theme.colorScheme.onBackground,
                                      fontWeight: 600,
                                      xMuted: false),
                                ],
                              ),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // time != "null"
                              //     ? Row(children: [
                              //         Icon(
                              //           MdiIcons.clockOutline,
                              //           size: 20,
                              //           color: theme.colorScheme.primary,
                              //         ),
                              //         SizedBox(
                              //           width: 10,
                              //         ),
                              //         Container(
                              //           margin: EdgeInsets.only(top: 2),
                              //           child: FxText.caption(time!,
                              //               fontSize: 14,
                              //               color: theme.colorScheme.onBackground,
                              //               fontWeight: 600,
                              //               xMuted: true),
                              //         )
                              //       ])
                              //     : Container(),
                              // time != "null"
                              //     ? Container(
                              //         margin: EdgeInsets.only(top: 2),
                              //         child: FxText.caption(time!,
                              //             fontSize: 14,
                              //             color: theme.colorScheme.onBackground,
                              //             fontWeight: 600,
                              //             xMuted: true),
                              //       )
                              //     : const SizedBox(),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              // venue != "null"
                              //     ? Row(children: [
                              //         Icon(
                              //           MdiIcons.mapMarker,
                              //           size: 20,
                              //           color: theme.colorScheme.primary,
                              //         ),
                              //         SizedBox(
                              //           width: 10,
                              //         ),
                              //         Flexible(
                              //             child: FxText.caption(venue,
                              //                 softWrap: true,
                              //                 fontSize: 14,
                              //                 color: theme.colorScheme.onBackground,
                              //                 fontWeight: 600,
                              //                 xMuted: true))
                              //       ])
                              //     : Container(),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (imageUrl != "null") {
                                      debugPrint(title);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SingleDigitalDownloadScreen(
                                                    imageUrl: imageUrl,
                                                    title: title,
                                                    pageTitle: pageTitle,
                                                  )));
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => SingleEventScreen(
                                      //               startDate: startDate,
                                      //               endDate: endDate,
                                      //               time: outputStartTime,
                                      //               title: title,
                                      //               description: description,
                                      //               venue: venue,
                                      //               contactPerson: contactPerson,
                                      //               imageUrl: imageUrl,
                                      //                    attachmentList: attachmentList,
                                      //             )));
                                    } else {
                                      debugPrint(title);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SingleDigitalDownloadScreen(
                                                    imageUrl: "",
                                                    title: title,
                                                    pageTitle: pageTitle,
                                                  )));
                                    }
                                  },
                                  child: FxText.b3("View / Download",
                                      fontWeight: 600, color: theme.colorScheme.onPrimary),
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0))),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Container(
                        //   child: Icon(
                        //     MdiIcons.heartOutline,
                        //     color: theme.colorScheme.primary,
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // );
  // }
}
