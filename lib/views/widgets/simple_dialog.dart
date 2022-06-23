import 'package:flutter/material.dart';
import 'package:ldce_alumni/core/button.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:ldce_alumni/utils/local_notification_service.dart';

class SimpleDialogWidget extends StatefulWidget {
  SimpleDialogWidget({required this.id, required this.type, required this.title, Key? key})
      : super(key: key);
  String title, type, id;
  @override
  State<SimpleDialogWidget> createState() => _SimpleDialogWidgetState();
}

class _SimpleDialogWidgetState extends State<SimpleDialogWidget> {
  late ThemeData themeData;
  @override
  void initState() {
    super.initState();

    themeData = AppTheme.theme;
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeData.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FxText.h6(
              "NEW " + widget.type.toUpperCase(),
              fontWeight: 500,
            ),
            SizedBox(
              height: 10,
            ),
            FxText.sh1(
              widget.title,
              fontWeight: 600,
            ),
            Container(
                alignment: AlignmentDirectional.centerEnd,
                child: FxButton(
                    onPressed: () {
                      if (widget.type.toLowerCase() == "event") {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, 'single_internet_events_screen',
                            arguments: ScreenArguments(widget.id));
                      }
                      if (widget.type.toLowerCase() == "news") {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, 'single_internet_news_screen',
                            arguments: ScreenArguments(widget.id));
                      }
                    },
                    borderRadiusAll: 4,
                    elevation: 0,
                    child:
                        FxText.b2("SHOW", letterSpacing: 0.3, color: themeData.colorScheme.onPrimary))),
          ],
        ),
      ),
    );
  }
}

class _SimpleDialog extends StatelessWidget {
  late String title, type, id;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeData.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FxText.h6(
              "Title",
              fontWeight: 700,
            ),
            FxText.sh1(
              "Description...",
              fontWeight: 500,
            ),
            Container(
                alignment: AlignmentDirectional.centerEnd,
                child: FxButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    borderRadiusAll: 4,
                    elevation: 0,
                    child:
                        FxText.b2("SHOW", letterSpacing: 0.3, color: themeData.colorScheme.onPrimary))),
          ],
        ),
      ),
    );
  }
}
