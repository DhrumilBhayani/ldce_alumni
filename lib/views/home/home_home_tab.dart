import 'package:flutter/material.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/theme/themes.dart';

class HomeTab extends StatefulWidget {
  HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late ThemeData theme;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = AppTheme.theme;
    // customTheme = AppTheme.customTheme;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            child: Padding(
      padding: EdgeInsets.all(24),
      child: Column(children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: 0),
              child: FxText.h6("Welcome to LDCE Connect", color: Color(0xffd32a27), fontWeight: 800),
            )),
        Divider(
          height: 1.5,
          color: theme.dividerColor,
          thickness: 1,
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text("Transforming Engineering For Human Happiness",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )
                  // style: AppTheme.getTextStyle(
                  //     themeData.textTheme.bodyText2,
                  //     color: themeData.colorScheme.onBackground,
                  //     fontWeight: 600,
                  //     muted: true),
                  ),
            )),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            "To promote fellowship among alumni, exchange ideas, spread knowledge, stimulate thinking and help L.D. College of Engineering to provide excellence in the field of Engineering",
            textAlign: TextAlign.justify,
            // style: AppTheme.getTextStyle(
            //     themeData.textTheme.bodyText2,
            //     color: themeData.colorScheme.onBackground,
            //     fontWeight: 600,
            //     muted: true),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(top: 0),
            child:
                FxText.h6("Maintain Contact", fontSize: 18, color: Color(0xffd32a27), fontWeight: 800),
          ),
        ),

        Divider(
          height: 1.5,
          color: theme.dividerColor,
          thickness: 1,
        ),
        // Container(
        //   margin: EdgeInsets.only(top: 20),
        //   child: Text("Transforming Engineering For Human Happiness           ",
        //       textAlign: TextAlign.start,
        //       style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //       )
        //       // style: AppTheme.getTextStyle(
        //       //     themeData.textTheme.bodyText2,
        //       //     color: themeData.colorScheme.onBackground,
        //       //     fontWeight: 600,
        //       //     muted: true),
        //       ),
        // ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            "To establish and maintain contact among past students, present students and the teaching staff of LDCE Alumni.",
            textAlign: TextAlign.justify,
            // style: AppTheme.getTextStyle(
            //     themeData.textTheme.bodyText2,
            //     color: themeData.colorScheme.onBackground,
            //     fontWeight: 600,
            //     muted: true),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(top: 0),
            child:
                FxText.h6("Global Standards", fontSize: 18, color: Color(0xffd32a27), fontWeight: 800),
          ),
        ),

        Divider(
          height: 1.5,
          color: theme.dividerColor,
          thickness: 1,
        ),
        // Container(
        //   margin: EdgeInsets.only(top: 20),
        //   child: Text("Transforming Engineering For Human Happiness           ",
        //       textAlign: TextAlign.start,
        //       style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //       )
        //       // style: AppTheme.getTextStyle(
        //       //     themeData.textTheme.bodyText2,
        //       //     color: themeData.colorScheme.onBackground,
        //       //     fontWeight: 600,
        //       //     muted: true),
        //       ),
        // ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            "To raise and maintain high standards of education by interaction commerce.",
            textAlign: TextAlign.justify,
            // style: AppTheme.getTextStyle(
            //     themeData.textTheme.bodyText2,
            //     color: themeData.colorScheme.onBackground,
            //     fontWeight: 600,
            //     muted: true),
          ),
        )
      ]),
    )));
  }
}
