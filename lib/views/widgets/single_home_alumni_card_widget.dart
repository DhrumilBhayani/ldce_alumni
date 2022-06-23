import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ldce_alumni/views/events/single_event_screen.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/theme/app_theme.dart';
import 'package:flutter/material.dart';
// import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SingleHomeAlumniCardWidget extends StatelessWidget {
  //final String? imageUrl, date, title, shortDescription;
  final String? imageUrl;
  final String title, shortDescription, passoutYear, branch;
  final double? width;
  final VoidCallback onTap;
  const SingleHomeAlumniCardWidget(
      {@required this.imageUrl,
      required this.title,
      required this.shortDescription,
      required this.passoutYear,
      required this.branch,
      required this.onTap,
      this.width,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl != "null") {
      // print(imageUrl);
    }
    ThemeData theme = Theme.of(context);
    late CustomTheme customTheme;
    customTheme = AppTheme.customTheme;
    // inspect(theme);
    bool isDark = false;
    TextDirection textDirection = TextDirection.ltr;
    // return Consumer<AppNotifier>(builder: (BuildContext context, AppNotifier value, Widget? child) {
    //   isDark = AppTheme.themeType == ThemeType.dark;
    //   textDirection = AppTheme.textDirection;
    //   theme = AppTheme.theme;
    //   customTheme = AppTheme.customTheme;
    return InkWell(
      onTap: onTap,

      // () {
      /*  if (imageUrl != "null") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SingleEventScreen(
                       
                        title: title,
                        description: description,
                     
                        imageUrl: imageUrl,
                        time: time,
                      )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SingleEventScreen(
                        startDate: startDate,
                        endDate: endDate,
                        title: title,
                        description: description,
                        venue: venue,
                        contactPerson: contactPerson,
                        time: time,
                      )));
        }*/
      // },
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
                            fit: BoxFit.contain,
                            width: width,
                            height: width! * 0.6,
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
              padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.b1(title, color: theme.colorScheme.onBackground, fontWeight: 600),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FxText.caption(shortDescription,
                                  fontSize: 14,
                                  color: theme.colorScheme.onBackground,
                                  fontWeight: 600,
                                  xMuted: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1),
                              SizedBox(
                                height: 10,
                              ),
                              FxText.caption(passoutYear + ' - ' + branch,
                                  fontSize: 14,
                                  color: theme.colorScheme.onBackground,
                                  fontWeight: 600,
                                  xMuted: true),
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
                              // venue != "null"
                              //     ? FxText.caption(venue,
                              //         fontSize: 14,
                              //         color: theme.colorScheme.onBackground,
                              //         fontWeight: 600,
                              //         xMuted: true)
                              //     : const SizedBox(),
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
