import 'package:flutter/gestures.dart';
import 'package:ldce_alumni/controllers/news/news_controller.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:flutter/material.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TreePlantationScreen extends StatefulWidget {
  // String title, date, shortDescription, description, imageUrl;
  // final List<String>? attachmentList;

  TreePlantationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _TreePlantationScreenState createState() => _TreePlantationScreenState();
}

class _TreePlantationScreenState extends State<TreePlantationScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  ScrollController thumbnailScrollController = ScrollController();
  late NewsController newsController;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    //  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.white,
    //   statusBarIconBrightness: Brightness.dark
    // ));
  }

  @override
  void dispose() {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.black.withOpacity(0.85),
    //   statusBarIconBrightness: Brightness.light
    // ));
    super.dispose();
    newsController.currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    //     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor:Colors.white,
    //   statusBarIconBrightness: Brightness.dark
    // ));
    return Consumer2<AppNotifier, NewsController>(
        builder: (BuildContext context, AppNotifier value, newsProvider, Widget? child) {
      newsController = newsProvider;
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // leading: Container(
            //     padding: EdgeInsets.only(top: 6),
            //     child: InkWell(
            //         child: Column(children: [Icon(Icons.home), FxText.b2("Home")]),
            //         onTap: () {
            //           Navigator.of(context)
            //               .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
            //         })),
            title: FxText.t1("Project Details"),
            // actions: [
            //   InkWell(
            //     child: Container(
            //         padding: EdgeInsets.only(top: 6, right: 6),
            //         child: Column(children: [Icon(Icons.newspaper), FxText.b2("All News")])),
            //     onTap: () {
            //       Navigator.of(context)
            //           .pushNamedAndRemoveUntil('news_home', ModalRoute.withName('home'));
            //     },
            //   )
            // ],
          ),
          body: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: ListView(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    padding: EdgeInsets.only(top: 0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xffd32a27),
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                        ),
                                        // color: Colors.red,
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
                                            })))),
                            // Align(
                            //     alignment: Alignment.center,
                            //     child: InkWell(
                            //       child: Container(
                            //           padding: EdgeInsets.only(top: 6, right: 6),
                            //           child:
                            //               Column(children: [Icon(Icons.newspaper), FxText.b2("All News")])),
                            //       onTap: () {
                            //         Navigator.of(context)
                            //             .pushNamedAndRemoveUntil('news_home', ModalRoute.withName('home'));
                            //       },
                            //     )),
                          ],
                        )),
                    Container(
                      decoration: BoxDecoration(
                          color: customTheme.card,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          boxShadow: [
                            BoxShadow(
                                color: customTheme.shadowColor.withAlpha(120),
                                blurRadius: 24,
                                spreadRadius: 4)
                          ]),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                // Container(
                                //   margin: EdgeInsets.only(top: 16),
                                //   child: Row(
                                //     children: [
                                //       FxText.caption(widget.date,
                                //           fontSize: 15,
                                //           color: theme.colorScheme.onBackground,
                                //           fontWeight: 600,
                                //           xMuted: true),
                                //     ],
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Container(
                                  child: FxText.h6("Foundation Day Tree Plantation Drives",
                                      color: theme.colorScheme.onBackground, fontWeight: 600),
                                ),
                                // widget.shortDescription != "null" && widget.description != "null"
                                //     ? Container(
                                //         margin: EdgeInsets.only(top: 16),
                                //         child: Row(
                                //           children: [
                                //             Flexible(
                                //               child: FxText.caption(widget.shortDescription,
                                //                   fontSize: 15,
                                //                   color: theme.colorScheme.onBackground,
                                //                   fontWeight: 600,
                                //                   xMuted: true),
                                //             )
                                //           ],
                                //         ),
                                //       )
                                //     : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Row(
                        children: [
                          Flexible(
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                  text: "To kickstart "),
                              TextSpan(
                                  style: TextStyle(color: Color(0xffd32a27), fontSize: 16),
                                  text: "LDCE's Platinum Jubilee Celebrations"),
                              TextSpan(
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                  text:
                                      ", we are planning two Tree plantation drives on our upcoming foundation day – "),
                              TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                  text: "Monday, 20th June, 2022.\n\n"),
                              TextSpan(
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                  text:
                                      "We will be planting 75 trees on college campus and other 75 trees in hostel block & other surrounding area! And with this, we would like to extend an opportunity for alumni to pledge a tree and be part of college’s campus forever!\n\nThere are two options:\n\n1. Donation pledge of 51K each, for donating a tree on college main campus... to keep and enrich our college’s green cover further\n\n2. Donation pledge of 21k each, for donating a tree in hostel block and surrounding area of campus... to weave more greens in life of nextgen hostelers and campus as-a-whole"),
                            ])),
                            //  FxText(
                            //   "To kickstart LDCE's Platinum Jubilee Celebrations, we are planning two Tree plantation drives on our upcoming foundation day – Monday, 20th June, 2022.\n\nWe will be planting 75 trees on college campus and other 75 trees in hostel block & other surrounding area! And with this, we would like to extend an opportunity for alumni to pledge a tree and be part of college’s campus forever!\n\nThere are two options:\n\n1. Donation pledge of 51K each, for donating a tree on college main campus... to keep and enrich our college’s green cover further\n\n2. Donation pledge of 21k each, for donating a tree in hostel block and surrounding area of campus... to weave more greens in life of nextgen hostelers and campus as-a-whole",
                            //   textAlign: TextAlign.justify,
                            // ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Divider(),
                    Container(
                        // margin: EdgeInsets.only(top: 16),
                        child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              // backgroundColor: Colors.red,
                              initiallyExpanded: false,
                              title: FxText.h6("Please Note"),
                              children: <Widget>[
                                Container(
                                  // padding: EdgeInsets.all(16),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: FxText(
                                          "• This opportunity is available to all alumni, on first come basis.\n\n• Donation made through this pledge will be eligible to claim under 80C deduction.\n\n• NRIs can donate thru their own NRO or India account under their / close family's name. Account owner will be able to claim 80C benefit.\n\n• We will be recognising this kind gesture by putting donor's name plate on the tree.\n\n• Donation will be used for maintaining planted tree & landscaping and balance will be used towards LDCE75 activities encompassing our objective of college, student and faculty development.",
                                          textAlign: TextAlign.justify,
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ))),
                    Divider(),
                    Container(
                        // margin: EdgeInsets.only(top: 16),
                        child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              // backgroundColor: Colors.red,
                              initiallyExpanded: false,
                              title: FxText.h6("For any query, contact"),
                              children: <Widget>[
                                Container(
                                  // padding: EdgeInsets.all(16),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 0),
                                    child: Row(
                                      children: [
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
                                                  Icons.person,
                                                  size: 20,
                                                  color: theme.colorScheme.primary,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              FxText.caption("Prerak Shah (CE '94)",
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
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  // padding: EdgeInsets.all(16),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 0),
                                    child: Row(
                                      children: [
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
                                                  Icons.phone,
                                                  size: 20,
                                                  color: theme.colorScheme.primary,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              FxText.caption("94293 57390 Or 98987 89240",
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
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  // padding: EdgeInsets.all(16),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 0),
                                    child: Row(
                                      children: [
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
                                                  Icons.mail,
                                                  size: 20,
                                                  color: theme.colorScheme.primary,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              FxText.caption("portal.admin@ldcealumni.net",
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
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ))),
                    Divider(),
                    Container(
                        // margin: EdgeInsets.only(top: 16),
                        child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              // backgroundColor: Colors.red,
                              initiallyExpanded: false,
                              title: FxText.h6("How To Pledge"),
                              children: <Widget>[
                                Container(
                                  // padding: EdgeInsets.all(16),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: FxText(
                                          "If enrolled on LDCE Alumni Connect Portal:\n\n1. Visit :",
                                          textAlign: TextAlign.justify,
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: RichText(
                                        textAlign: TextAlign.start,
                                        text: TextSpan(
                                          style:
                                              TextStyle(color: theme.colorScheme.primary, fontSize: 15),
                                          text: "https://www.ldcealumni.net/Home/Login",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              final url = 'https://www.ldcealumni.net/Home/Login';
                                              if (await canLaunchUrl(Uri.parse(url))) {
                                                await launchUrl(Uri.parse(url));
                                              }
                                            },
                                        ))),
                                Row(
                                  children: [
                                    Flexible(
                                        child: FxText(
                                      "\n2. Login using credentials you would have received after enrolling in LD@75 Outreach Database\n\n3. Go to ‘Project Pledging’ from menu on the left. You will see multiple projects including two Tree Plantation projects. Please follow the project of your choice.\n\n4. You can either click on pledge icon appearing under that project OR click on view icon to view details AND then click on ‘Pledge Now’ button.\n\nIf not enrolled on Alumni Connect Portal\n\nOR having trouble logging in / enrolling:\n\nplease write to portal.admin@ldceadmin.net with following details and we will have you enrolled in LD@75 outreach database AND will also register the pledge on your behalf." +
                                          "\n\nFirst Name:\n\nLast Name:\n\nProgram: BE/ME\n\nBranch:\n\nPassout Year:\n\nEmail address:\n\nPhone Nbr [optional]:\n\nCountry of Residence:\n\nTree[s] You would like to pledge: 1 or above\n\nLocation Preference: Main Block / Other Area",
                                      textAlign: TextAlign.justify,
                                    )),
                                  ],
                                ),
                              ],
                            ))),
                    Divider(),
                  ],
                )),
              ],
            ),
          ));
    });
  }
}

/*

'Although the years 2020 and 2021 have been difficulties due to Corona, the placement in LD Engineering College has not been affected. From March 2020 to August 2021, 174 companies have offered job packages to 621 students while 554 students who passed in 2021 have been offered job packages ranging from Rs 5 lakh to Rs 7 lakh per annum. In the academic year 2019, approximately 104 companies from various sectors participated in the placement and offered jobs to 625 final year students of the college. But in 2020 and 2021 together companies from different sectors have offered jobs to 1175 students.\n\nAn average package of up to Rs 5 lakh per annum is being offered in placement. The number of students getting the job could go much higher as placements in LD Engineering are yet to run till December. L. D. Engineering\'s Placement Cell Coordinator Dr. Vinod Patel said, "Even during Corona, the placement cell of the college continued to operate online. All the placement process including aptitude test, group discussion, and personal interview was done online and online placement is still going on. "'
 */