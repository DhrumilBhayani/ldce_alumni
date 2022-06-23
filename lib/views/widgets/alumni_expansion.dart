import 'package:flutter/material.dart';
import 'package:ldce_alumni/theme/theme_type.dart';
import 'package:ldce_alumni/theme/themes.dart';


class AlumniDirectoryExpansionWidget extends StatefulWidget {
  final String name, passoutYear, program, branch, membership, profession;
  bool isExpanded;

  AlumniDirectoryExpansionWidget(
      {required this.name,
      required this.passoutYear,
      required this.program,
      required this.branch,
      required this.membership,
      required this.profession,
      // required this.email,
      Key? key,
      this.isExpanded = false})
      : super(key: key);
  @override
  _AlumniDirectoryExpansionWidgetState createState() => _AlumniDirectoryExpansionWidgetState();
}

class _AlumniDirectoryExpansionWidgetState extends State<AlumniDirectoryExpansionWidget> {
  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);
    late CustomTheme customTheme;
    bool isDark = false;
    customTheme = AppTheme.customTheme;
    isDark = AppTheme.themeType == ThemeType.dark;
    print(isDark);
    return Column(children: [
      Container(
          // padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 10.0),
          child: ExpansionPanelList(
            animationDuration: Duration(milliseconds: 300),
            // dividerColor: Colors.red,
            elevation: 1,
            children: [
              ExpansionPanel(
                canTapOnHeader: true,
                backgroundColor: isDark ? null : Colors.grey.shade100,
                body: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(),
                      Row(children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Branch",
                              // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              widget.branch == "null" || widget.branch == "" ? " " : widget.branch,
                              // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                            ),
                          ),
                        ),
                      ]),
                      Divider(),
                      Row(children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Membership",
                              // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              widget.membership == "null" || widget.membership == ""
                                  ? " "
                                  : widget.membership,
                              // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                            ),
                          ),
                        ),
                      ]),
                      Divider(),
                      Row(children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Profession",
                              // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              widget.profession == "null" || widget.profession == ""
                                  ? " "
                                  : widget.profession,
                              // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                            ),
                          ),
                        ),
                      ]),
                      // Divider(),
                      // Row(children: <Widget>[
                      //   Expanded(
                      //     flex: 1,
                      //     child: Container(
                      //       margin: const EdgeInsets.only(left: 10.0),
                      //       child: Text(
                      //         "Action",
                      //         // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                      //       ),
                      //     ),
                      //   ),
                      //   Expanded(
                      //     flex: 3,
                      //     child: Container(
                      //         margin: const EdgeInsets.only(left: 10.0),
                      //         child: Row(children: [
                      //           InkWell(
                      //               onTap: (() => {print('Mail')}),
                      //               child: Icon(
                      //                 Icons.mail,
                      //                 color: Colors.red,
                      //               )),
                      //           SizedBox(
                      //             width: 15,
                      //           ),
                      //           InkWell(
                      //               onTap: (() => {print('Send')}),
                      //               child: Icon(
                      //                 Icons.send,
                      //                 color: Colors.blue,
                      //               )),
                      //           SizedBox(
                      //             width: 15,
                      //           ),
                      //         ])),
                      //   ),
                      // ]),
                      // Divider(),

                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                ),
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Row(children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          widget.name == "null" || widget.name == "" ? " " : widget.name,
                          // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.passoutYear == "null" || widget.passoutYear == ""
                              ? " "
                              : widget.passoutYear,
                          // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 36),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.program == "null" || widget.program == "" ? " " : widget.program,
                            // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
                          ),
                        ),
                      ),
                    ),
                  ]);
                },
                isExpanded: widget.isExpanded,
              )
            ],
            expansionCallback: (int item, bool status) {
              setState(() {
                widget.isExpanded = !widget.isExpanded;
              });
            },
          )),
    ]);
  }
}
