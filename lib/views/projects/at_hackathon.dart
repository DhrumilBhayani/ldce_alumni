// import 'package:ldce_alumni/screens/news/news_editor_profile_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:ldce_alumni/controllers/news/news_controller.dart';
import 'package:ldce_alumni/core/text.dart';
// import 'package:flutkit/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:ldce_alumni/theme/themes.dart';
// import 'package:flutx/flutx.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ATHackathon extends StatefulWidget {
  // String title, date, shortDescription, description, imageUrl;
  // final List<String>? attachmentList;

  ATHackathon({
    Key? key,
  }) : super(key: key);

  @override
  _ATHackathonState createState() => _ATHackathonState();
}

class _ATHackathonState extends State<ATHackathon> {
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
                    Row(
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
                    ),
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
                                  child: FxText.h6("AT Hackathon",
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
                                Container(
                                  margin: EdgeInsets.only(top: 16),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: FxText.caption(
                                            "Hackathon on Assistive Technology organized by L.D. College of Engineering in association with VOSAP.",
                                            fontSize: 15,
                                            color: theme.colorScheme.onBackground,
                                            fontWeight: 600,
                                            xMuted: true),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 16),
                    //   child: Row(
                    //     children: [
                    //       Flexible(
                    //         child: FxText(
                    //           "To kickstart LDCE's Platinum Jubilee Celebrations, we are planning two Tree plantation drives on our upcoming foundation day – Monday, 20th June, 2022.\n\nWe will be planting 75 trees on college campus and other 75 trees in hostel block & other surrounding area! And with this, we would like to extend an opportunity for alumni to pledge a tree and be part of college’s campus forever!\n\nThere are two options:\n\n1. Donation pledge of 51K each, for donating a tree on college main campus... to keep and enrich our college’s green cover further\n\n2. Donation pledge of 21k each, for donating a tree in hostel block and surrounding area of campus... to weave more greens in life of nextgen hostelers and campus as-a-whole",
                    //           textAlign: TextAlign.justify,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                              initiallyExpanded: true,
                              title: FxText.h6("Background"),
                              children: <Widget>[
                                Container(
                                  // padding: EdgeInsets.all(16),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: FxText(
                                          "Vision of L.D.College of Engineering:\n\n • To contribute for sustainable development of nation through achieving excellence in technical education and research while facilitating transformation of students into responsible citizens and competent professionals.\n\n• To keep up with the vision, L.D.College of Engineering always believes in nurturing the young talents to work for Engineering solutions that is useful to community. LDCE is entering into 75th year so as part of “AmrutArarambh” has an idea to work for specially abled people. The world has witnessed Stephen Hawking, who inspite of disabilities gave the best of Physics theories/learnings with the use of assistive technologies.",
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
                              title: FxText.h6("About Voice of SAP"),
                              children: <Widget>[
                                Container(
                                  // padding: EdgeInsets.all(16),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: FxText(
                                          "• Voice of SAP (www.voiceofsap.org) is a US based organization with a mission to redefine the idea of a disabled person focusing on opportunities by harnessing Special Abilities to live with Dignity and Empowerment.\n\n• VOSAP is changing the narrative of ‘DISABILITY’ and is promoting accessibility, inclusion, and adoption of Assistive Technology with VOSAP Digital Tools such as VOSAP Mobile App, Art Platform and VOSAP AT Exhibition.\n\nIn the last 5 years more than 12,000 lives of specially abled people has been changed FOREVER.\n\nVOSAP has been granted highest level of Affiliation as an organization in Special Consultative Status with UN ECOSOC (Economic and Social Council)\n\nTHE NEED :\n\nThere are 15% people with disabilities in our society per WHO. 1 out of 10 only has Assistive Device as of now. For affordable solutions, there is need to promote innovations. This AT Hackathon encourages innovators (AT Hackathon participants) to build patentable product in assistive technologies.\n\nSUPPORT IS NEEDED FOR\n\n• Association of Company\n\n\t1. Having footprints in assistive technologies\n\t2. Provide APIs for development of products\n\t3. Components/equipment support\n\n•   Awarding prizes\n\n•   Providing innovation support by mentoring\n\n• Funding for purchase of equipments/components/services for prototype building  ",
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
                              title: FxText.h6("Themes"),
                              children: <Widget>[
                                Container(
                                  // padding: EdgeInsets.all(16),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: FxText(
                                          "Themes:\n\n1. MOBILITY : Many types of orthopedic or neuromuscular impairments can impact mobility. These include but are not limited to amputation, paralysis, cerebral palsy, stroke, multiple sclerosis etc. Specially abled people or SAPs in this case needs mobility solutions to perform daily tasks that involve indoor and outdoor movement.\n\nExamples : -\n\n• Outdoor Mobility Technologies like Smart Tricycle with Solar Charging, Smart Wheelchair, etc should be enhanced keeping road safety, battery, weather and road conditions in mind.\n\n• Indoor Mobility Devices like Self propelled Wheelchair, Knee Scooters, etc should be enhanced with emergency response and communication systems and technologies like realtime fall detection alerts, emergency messaging/calling etc.\n\n2. COMMUNICATION : SAPs with vision, hearing or speech impairments may experience difficulties communicating and interacting with those around them. Limited information of what is happening may affect their ability to understand and make sense of their environment.\n\nExamples : -\n\n• Wearable devices like Smart bands to sense fall detections, make calls, guide indoor and outdoor map etc.\n\n• Smart assistance apps like apps for reading and translating written for a visually impaired person with excellent efficiency in real time.\n\n• Smart converting apps to convert sign language, braille etc to normal english language for a non-SAP to understand and communicate better -Smart softwares that provides and translates subtitles on a live video call.\n\n3. LEARNING : SAPs face different kinds of learning challenges with different types of disabilities that not just increases illiteracy but also unemployment among them. Right to education is a right for all, and SAPs shouldn’t be excluded as well.\n\nExamples : -\n\n• Smart softwares that teaches 21st century skills like Coding, etc to a visually impaired person, etc.\n\n• Smart content consumption softwares that makes online education like youtube learning easier for someone who has hearing impairment.\n\n• Learning for special kind that targets and help people with that particular disability to learn better - For example Smart learning apps for Autism etc.",
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
                              title: FxText.h6("Register Now"),
                              children: <Widget>[
                                Container(
                                  // padding: EdgeInsets.all(16),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: FxText(
                                          "Visit :",
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
                                          text: "https://www.voiceofsap.org/athackathon",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              final url = 'https://www.voiceofsap.org/athackathon';
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              }
                                            },
                                        ))),
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
                              title: FxText.h6("Organizing Team"),
                              children: <Widget>[
                                Divider(),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: FxText.t2("CHIEF PATRON", fontWeight: 600)),
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

                                              FxText.caption(
                                                  "Dr. R.K.Gajjar \n(Principal, L.D.College of Engineering)",
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
                                SizedBox(height: 20),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: FxText.t2("PATRON", fontWeight: 600)),
                                Container(
                                  // padding: EdgeInsets.all(16),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 0),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
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

                                              FxText.caption("Mr. Pranav Desai",
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
                                          margin: EdgeInsets.only(top: 10),
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

                                              FxText.caption("Mr. Prerak Shah",
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
                                SizedBox(height: 20),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: FxText.t2("PROGRAM COMMITTEE", fontWeight: 600)),
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
                                              FxText.caption("Dr. H.M.Diwanji",
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
                                                  Icons.person,
                                                  size: 20,
                                                  color: theme.colorScheme.primary,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              FxText.caption("Dr. C.H.Vithlani",
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
                                                  Icons.person,
                                                  size: 20,
                                                  color: theme.colorScheme.primary,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              FxText.caption("Dr. Chirag Thaker",
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
                                                  Icons.person,
                                                  size: 20,
                                                  color: theme.colorScheme.primary,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              FxText.caption("Prof. Mahendrasinh Gadhvi",
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
                                SizedBox(height: 20),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: FxText.t2("For any query, contact", fontWeight: 600)),
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
                                              FxText.caption("LDCE75@ldce.ac.in",
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
                              title: FxText.h6("Timeline"),
                              children: <Widget>[
                                Container(
                                  // padding: EdgeInsets.all(16),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: FxText(
                                          "•  June 20 : Launch\n\n•  June 20 to August 31 : Online Idea Submission with Proper concept details  \n\n•  September till October 30 : Presentations of selected entries\n\n•  October 31 - Selection of top 10 entries to start working on the prototype\n\n•  Dec 3 event : Public announcement of top 10 teams\n\n•  Jan 6- Top 3 winner announcement",
                                          textAlign: TextAlign.left,
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
                              title: FxText.h6("Prizes and Awards"),
                              children: <Widget>[
                                Container(
                                  // padding: EdgeInsets.all(16),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: FxText(
                                          "Top 3 awards by VOSAP:\n\n•  First : \$1000\n\n•  Second : \$500\n\n•  Third : \$300\n\nMentorship support\n\nIndustry sponsorship\n\n‘Top few ideas will also get a booth at VOSAP AT exhibition to present their ideas globally’",
                                          textAlign: TextAlign.left,
                                        )),
                                      ],
                                    ),
                                  ),
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