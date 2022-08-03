// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ldce_alumni/controllers/alumni/alumni_controller.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/models/alumni/alumni.dart';
import 'package:ldce_alumni/theme/theme_type.dart';
import 'package:ldce_alumni/theme/themes.dart';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:ldce_alumni/views/widgets/alumni_expansion.dart';
import 'package:ldce_alumni/views/widgets/app_bar_widget.dart';
import 'package:ldce_alumni/views/widgets/app_drawer_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'package:provider/provider.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

class AlumniDirectoryHome extends StatefulWidget {
  @override
  _AlumniDirectoryHomeState createState() => _AlumniDirectoryHomeState();
}

class _AlumniDirectoryHomeState extends State<AlumniDirectoryHome> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  late ThemeData theme;
  late CustomTheme customTheme;

  bool isDark = false;
  bool isOpen = false;
  bool isLoading = false;
  bool searchPressed = false;
  int currentPageNumber = 1;
  late TextEditingController searchEditingController;
  late AlumniDirectoryController _alumniDirectoryController;
  String? selectedProgramValue;
  String? selectedBranchValue;
  String? selectedYearValue;
  List<String> years = List<String>.generate(76, (counter) => (counter - 2026).abs().toString());

  List<String> items = [];
  List<String> programs = [
    'B.E.',
    'M.E.',
    'MCA',
  ];
  List<String> beBranches = [
    'ALL',
    'Automobile Engineering',
    'Bio-Medical Engineering',
    'Chemical Engineering',
    'Civil Engineering',
    'Computer Engineering',
    'Electrical Engineering',
    'Electronics and Communication Engineering',
    'Environmental Engineering',
    'Information Technology',
    'Instrumentation and Control Engineering',
    'Mechanical Engineering',
    'Plastic Engineering',
    'Rubber Engineering',
    'Textile Engineering',
  ];
  List<String> meBranches = [
    'All',
    'Applied Instrumentation',
    'Applied Mechanics',
    'CASAD',
    'Communication Systems',
    'Computer Aided Design & Manufacturing',
    'Computer Aided Process Design',
    'Computer Science & Technology',
    'Cryogenic Engineering',
    'Electrical Engineering',
    'Environmental Engineering',
    'Geotechnical Engineering',
    'Information Technology',
    'Internal Combustion Engines & Automobile',
    'Rubber Engineering',
    'Structural Engineering',
    'Textile Engineering',
    'Transportation Engineering',
    'Water Resources and Management',
  ];
  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
    searchEditingController = TextEditingController();
    years.insert(0, "All");
  }

  @override
  void dispose() {
    super.dispose();
    _alumniDirectoryController.uiLoading = true;
  }

  Widget _buildSingleAlumni(Alumni alumni) {
    return Container(
        child: AlumniDirectoryExpansionWidget(
      name: alumni.name,
      passoutYear: alumni.passoutYear,
      program: alumni.program,
      branch: alumni.branch,
      membership: alumni.membership,
      profession: alumni.profession,
      // email: alumni.email,
    ));
  }

  List<Widget> _buildAlumniList(AlumniDirectoryController alumniProvider) {
    List<Widget> list = [];

    for (Alumni alumni in alumniProvider.alumni) {
      list.add(_buildSingleAlumni(alumni));
    }
    if (alumniProvider.alumni.isNotEmpty) {
      list.add(!searchPressed
          ? Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    onPressed: currentPageNumber <= 1
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                              currentPageNumber -= 1;
                            });
                            await alumniProvider.loadMore(currentPageNumber);
                            setState(() {
                              isLoading = false;
                            });
                            // Navigator.pushNamed(context, 'alumni_directory_home',
                            print("Previous");
                            //     arguments: homeProvider.news);
                          },
                    child: FxText.b2("Previous", fontWeight: 600, color: theme.colorScheme.onBackground),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(theme.colorScheme.onPrimary),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
                  )),
              SizedBox(width: 20),
              Container(
                padding: EdgeInsets.all(10),
                // color: Colors.grey.shade100,
                child: Text(
                  currentPageNumber.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 20),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      print('1 Isloading: ' + isLoading.toString());
                      setState(() {
                        isLoading = true;
                        currentPageNumber += 1;
                      });
                      print('2 Isloading: ' + isLoading.toString());

                      await alumniProvider.loadMore(currentPageNumber);
                      // alumniProvider.alumni = [];
                      setState(() {
                        isLoading = false;
                      });
                      print('3 Isloading: ' + isLoading.toString());
                      print("next");
                    },
                    child: FxText.b2("Next", fontWeight: 600, color: theme.colorScheme.onBackground),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(theme.colorScheme.onPrimary),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0))),
                  )),
            ])
          : Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    onPressed: currentPageNumber <= 1
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                              currentPageNumber -= 1;
                            });
                            await alumniProvider.loadMoreSearch(currentPageNumber,
                                name: searchEditingController.text,
                                branch: selectedBranchValue,
                                passoutYear: selectedYearValue,
                                degree: selectedProgramValue);
                            setState(() {
                              isLoading = false;
                            });
                            // Navigator.pushNamed(context, 'alumni_directory_home',
                            print("Previous");
                            //     arguments: homeProvider.news);
                          },
                    child: FxText.b2("Previous", fontWeight: 600, color: theme.colorScheme.onBackground),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(theme.colorScheme.onPrimary),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
                  )),
              SizedBox(width: 20),
              Container(
                padding: EdgeInsets.all(10),
                // color: Colors.grey.shade100,
                child: Text(
                  currentPageNumber.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 20),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    onPressed: !alumniProvider.hasMoreSearchData
                        ? null
                        : () async {
                            print('1 Isloading: ' + isLoading.toString());
                            setState(() {
                              isLoading = true;
                              currentPageNumber += 1;
                            });
                            print('2 Isloading: ' + isLoading.toString());

                            await alumniProvider.loadMoreSearch(currentPageNumber,
                                name: searchEditingController.text,
                                branch: selectedBranchValue,
                                passoutYear: selectedYearValue,
                                degree: selectedProgramValue);
                            // alumniProvider.alumni = [];
                            setState(() {
                              isLoading = false;
                            });
                            print('3 Isloading: ' + isLoading.toString());
                            print("next");
                          },
                    child: FxText.b2("Next", fontWeight: 600, color: theme.colorScheme.onBackground),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(theme.colorScheme.onPrimary),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0))),
                  )),
            ]));
    } else {
      list.add(Container(
          alignment: Alignment.center, padding: EdgeInsets.only(top: 18), child: Text("No Records")));
    }

    return list;
  }

  // int _radioValue1 = -1;
  int correctScore = 0;

  // void _handleRadioValueChange1(int? value) {
  //   setState(() {
  //     _radioValue1 = value!;

  //     switch (_radioValue1) {
  //       case 0:
  //         // Fluttertoast.showToast(msg: 'Correct !',toastLength: Toast.LENGTH_SHORT);
  //         correctScore++;
  //         break;
  //       case 1:
  //         // Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
  //         break;
  //       case 2:
  //         // Fluttertoast.showToast(msg: 'Try again !',toastLength: Toast.LENGTH_SHORT);
  //         break;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.black.withOpacity(0.85), statusBarIconBrightness: Brightness.light));
    return Consumer2<AppNotifier, AlumniDirectoryController>(
        builder: (BuildContext context, AppNotifier value, alumniProvider, Widget? child) {
      //inspect(value);
      globals.checkInternet(context);

      isDark = AppTheme.themeType == ThemeType.dark;
      _alumniDirectoryController = alumniProvider;
      theme = AppTheme.theme;
      customTheme = AppTheme.customTheme;
      if (alumniProvider.exceptionCreated) {
        print("Exception created block");
        // Navigator.pushNamedAndRemoveUntil(context, 'something_wrong', (route) => false);
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          print("Exception created block 1");
          Navigator.pushNamedAndRemoveUntil(context, 'something_wrong', (route) => false);
          alumniProvider.uiLoading = false;
          // showSnackBarWithFloating();
        });
      }
      if (alumniProvider.uiLoading && !alumniProvider.exceptionCreated) {
        alumniProvider.fetchData();
        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
            ),
            backgroundColor: customTheme.card,
            body: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
                child: LoadingEffect.getSearchLoadingScreen(
                  context,
                )));
      } else {
        return Scaffold(
            key: _key,
            endDrawer: AppDrawerWidget(),
            // drawer: AppDrawerWidget(),
            appBar: AppBarWidget(
              title: 'Alumni Directory',
              scaffoldKey: _key,
            ),
            body: Column(children: <Widget>[
              // AlumniDirectoryExpansionWidget(
              //     "name", "passoutYear", "program", "branch", "membership", "profession", "email"),
              // AlumniDirectoryExpansionWidget(
              //     "name", "passoutYear", "program", "branch", "membership", "profession", "email"),
              // Padding(padding: EdgeInsets.only(top: AppBar().preferredSize.height)),
              MaterialBanner(
                  content: FxText.b1("Alumni Directory",
                      // fontSize: currentIndex == 0 ? 20 : null,
                      textAlign: TextAlign.left,
                      fontWeight: 600,
                      color: theme.colorScheme.onPrimary),
                  // contentTextStyle: const TextStyle(color: Colors.black, fontSize: 30),
                  backgroundColor: Colors.black.withAlpha(200),
                  // leadingPadding: const EdgeInsets.only(right: 30),
                  actions: [
                    TextButton(onPressed: () {}, child: const Text('')),
                  ]),

              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: ListView(shrinkWrap: true, children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: <Widget>[
                        //     Radio(
                        //       value: 0,
                        //       groupValue: _radioValue1,
                        //       onChanged: _handleRadioValueChange1,
                        //     ),
                        //     Text(
                        //       'Patron',
                        //       style: new TextStyle(fontSize: 16.0),
                        //     ),
                        //     Radio(
                        //       value: 1,
                        //       groupValue: _radioValue1,
                        //       onChanged: _handleRadioValueChange1,
                        //     ),
                        //     Text(
                        //       'Donor',
                        //       style: new TextStyle(
                        //         fontSize: 16.0,
                        //       ),
                        //     ),
                        //     Radio(
                        //       value: 2,
                        //       groupValue: _radioValue1,
                        //       onChanged: _handleRadioValueChange1,
                        //     ),
                        //     Text(
                        //       'All',
                        //       style: new TextStyle(fontSize: 16.0),
                        //     ),
                        //   ],
                        // ),

                        Divider(),
                        Container(
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: AppBar().preferredSize.height * 0.3),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: theme.backgroundColor,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Text(
                                  'Passout Year',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: years
                                    .map((year) => DropdownMenuItem<String>(
                                          value: year,
                                          child: Text(
                                            year,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedYearValue,
                                onChanged: (value) {
                                  currentPageNumber = 1;

                                  setState(() {
                                    print(value);
                                    selectedYearValue = value as String;
                                  });
                                },
                                buttonHeight: 40,
                                buttonWidth: MediaQuery.of(context).size.width * 0.89,
                                itemHeight: 40,
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: theme.backgroundColor,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Text(
                                  'Program',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: programs
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedProgramValue,
                                onChanged: (value) {
                                  currentPageNumber = 1;
                                  switch (value) {
                                    case 'B.E.':
                                      setState(() {
                                        items = beBranches;
                                      });
                                      print("BE");
                                      break;
                                    case 'M.E.':
                                      setState(() {
                                        items = meBranches;
                                      });
                                      print("ME");
                                      break;
                                    case 'MCA':
                                      setState(() {
                                        items = ['ALL', 'Computer Engineering'];
                                      });
                                      print("ME");
                                      break;
                                    default:
                                  }
                                  setState(() {
                                    selectedProgramValue = value as String;
                                  });
                                },
                                buttonHeight: 40,
                                buttonWidth: MediaQuery.of(context).size.width * 0.89,
                                itemHeight: 40,
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: theme.backgroundColor,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Text(
                                  'Branch',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: items
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedBranchValue,
                                onChanged: (value) {
                                  setState(() {
                                    currentPageNumber = 1;
                                    selectedBranchValue = value as String;
                                  });
                                },
                                buttonHeight: 40,
                                buttonWidth: MediaQuery.of(context).size.width * 0.89,
                                itemHeight: 40,
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        Container(
                            padding: EdgeInsets.only(left: 10, bottom: 20, right: 20, top: 10),
                            child: TextFormField(
                              controller: searchEditingController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Name",
                                enabledBorder: theme.inputDecorationTheme.border,
                                focusedBorder: theme.inputDecorationTheme.focusedBorder,
                                // prefixIcon: Icon(Icons.person),
                              ),
                              // controller: TextEditingController(text: "Natalia Dyer"),
                            )),
                        Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                            child: ElevatedButton(
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();

                                print('Name: ' + searchEditingController.text);
                                print('Year : ' + selectedYearValue.toString());
                                print('Program : ' + selectedProgramValue.toString());
                                print('Branch: ' + selectedBranchValue.toString());
                                // print(membershipType);
                                print(currentPageNumber);
                                if (searchEditingController.text.isNotEmpty ||
                                    selectedYearValue != null ||
                                    selectedProgramValue != null ||
                                    selectedBranchValue != null) {
                                  setState(() {
                                    isLoading = true;
                                    searchPressed = true;
                                    // currentPageNumber -= 1;
                                  });
                                  await alumniProvider.getSearchResults(
                                    name: searchEditingController.text,
                                    branch: selectedBranchValue,
                                    passoutYear: selectedYearValue,
                                    degree: selectedProgramValue,
                                    pageNumber: currentPageNumber,
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  setState(() {
                                    isLoading = true;
                                    // currentPageNumber += 1;
                                  });
                                  await alumniProvider.fetchData();
                                  // await alumniProvider.getSearchResults(
                                  //     name: searchEditingController.text,
                                  //     branch: selectedBranchValue,
                                  //     passoutYear: selectedYearValue,
                                  //     degree: selectedProgramValue);
                                  // await alumniProvider.loadMore(1);
                                  setState(() {
                                    currentPageNumber = 1;
                                    searchPressed = false;

                                    isLoading = false;
                                  });
                                }

                                // Navigator.pushNamed(context, 'alumni_directory_home',
                                print("Previous");
                                //     arguments: homeProvider.news);
                              },
                              child: FxText.b2("Search",
                                  fontWeight: 600, color: theme.colorScheme.onPrimary),
                              style: ButtonStyle(
                                  // backgroundColor: MaterialStateProperty.all<Color>(Colors.wh),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0))),
                            )),
                        if (isLoading)
                          Center(
                              child: Padding(
                                  padding: EdgeInsets.all(10), child: CircularProgressIndicator())),
                        if (!isLoading)
                          StickyHeader(
                            header: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              color: theme.backgroundColor,
                              // padding: EdgeInsets.symmetric(horizontal: 16.0),
                              alignment: Alignment.centerLeft,
                              child: Container(
                                // color: Colors.white,
                                padding: EdgeInsets.only(left: 10.0),
                                child: Table(
                                  // border: TableBorder.all(color: Colors.black),
                                  children: [
                                    TableRow(children: [
                                      Text('Name'),
                                      // SizedBox(width: 5,),
                                      Container(
                                        child: Text('Passout Year'),
                                        padding: EdgeInsets.only(left: 35),
                                      ),
                                      Container(
                                        child: Text('Program'),
                                        padding: EdgeInsets.only(left: 20),
                                      ),
                                      // Text('Program'),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                            content: !alumniProvider.exceptionCreated
                                ? Column(children: _buildAlumniList(alumniProvider))
                                : Container(),

                            //  Column(children: <Widget>[
                            // if (isLoading)
                            // isLoading
                            //     ? Center(
                            //         child: Padding(
                            //             padding: EdgeInsets.all(10),
                            //             child: Text("Test")))
                            //     : Column(children: _buildAlumniList()),
                            // if (!isLoading) Column(children: _buildAlumniList())
                            // : Center(
                            //     child: Padding(
                            //         padding: EdgeInsets.all(10),
                            //         child: CircularProgressIndicator()))
                            // Container(
                            //   // color: Colors.white,
                            //   padding: EdgeInsets.only(left: 20.0),
                            //   child: Table(
                            //     // border: TableBorder.all(color: Colors.black),
                            //     children: [
                            //       TableRow(children: [
                            //         Text('Name'),
                            //         // SizedBox(width: 5,),
                            //         Container(
                            //           child: Text('Passout Year'),
                            //           padding: EdgeInsets.only(left: 35),
                            //         ),
                            //         Container(
                            //           child: Text('Program'),
                            //           padding: EdgeInsets.only(left: 15),
                            //         ),
                            //         // Text('Program'),
                            //       ]),
                            //     ],
                            //   ),
                            // ),
                            // ])
                          )
                      ])))
            ]));
      }
    });
  }
}
              // ListView.builder(
              //   itemCount: itemData.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return Container(
              //         margin: EdgeInsets.only(bottom: 10.0),
              //         child: ExpansionPanelList(
              //           animationDuration: Duration(milliseconds: 300),
              //           // dividerColor: Colors.red,
              //           elevation: 1,
              //           children: [
              //             ExpansionPanel(
              //               canTapOnHeader: true,
              //               backgroundColor: Colors.white,
              //               body: Container(
              //                 padding: EdgeInsets.only(left: 10),
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: <Widget>[
              //                     Row(children: <Widget>[
              //                       Expanded(
              //                         flex: 1,
              //                         child: Container(
              //                           margin: const EdgeInsets.only(left: 10.0),
              //                           child: Text(
              //                             "Branch",
              //                             // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
              //                           ),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         flex: 3,
              //                         child: Container(
              //                           margin: const EdgeInsets.only(left: 10.0),
              //                           child: Text(
              //                             "Information and Technology",
              //                             // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
              //                           ),
              //                         ),
              //                       ),
              //                     ]),
              //                     Divider(),
              //                     Row(children: <Widget>[
              //                       Expanded(
              //                         flex: 1,
              //                         child: Container(
              //                           margin: const EdgeInsets.only(left: 10.0),
              //                           child: Text(
              //                             "Membership",
              //                             // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
              //                           ),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         flex: 3,
              //                         child: Container(
              //                           margin: const EdgeInsets.only(left: 10.0),
              //                           child: Text(
              //                             "Student",
              //                             // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
              //                           ),
              //                         ),
              //                       ),
              //                     ]),
              //                     Divider(),
              //                     Row(children: <Widget>[
              //                       Expanded(
              //                         flex: 1,
              //                         child: Container(
              //                           margin: const EdgeInsets.only(left: 10.0),
              //                           child: Text(
              //                             "Profession",
              //                             // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
              //                           ),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         flex: 3,
              //                         child: Container(
              //                           margin: const EdgeInsets.only(left: 10.0),
              //                           child: Text(
              //                             "Student",
              //                             // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
              //                           ),
              //                         ),
              //                       ),
              //                     ]),
              //                     Divider(),
              //                     Row(children: <Widget>[
              //                       Expanded(
              //                         flex: 1,
              //                         child: Container(
              //                           margin: const EdgeInsets.only(left: 10.0),
              //                           child: Text(
              //                             "Action",
              //                             // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
              //                           ),
              //                         ),
              //                       ),
              //                       Expanded(
              //                         flex: 3,
              //                         child: Container(
              //                             margin: const EdgeInsets.only(left: 10.0),
              //                             child: Row(children: [
              //                               InkWell(
              //                                   onTap: (() => {print('Mail')}),
              //                                   child: Icon(
              //                                     Icons.mail,
              //                                     color: Colors.red,
              //                                   )),
              //                               SizedBox(
              //                                 width: 15,
              //                               ),
              //                               InkWell(
              //                                   onTap: (() => {print('Send')}),
              //                                   child: Icon(
              //                                     Icons.send,
              //                                     color: Colors.blue,
              //                                   )),
              //                               SizedBox(
              //                                 width: 15,
              //                               ),
              //                             ])),
              //                       ),
              //                     ]),
              //                     // Divider(),

              //                     SizedBox(
              //                       height: 10,
              //                     )
              //                   ],
              //                 ),
              //               ),
              //               headerBuilder: (BuildContext context, bool isExpanded) {
              //                 return Row(children: <Widget>[
              //                   Expanded(
              //                     flex: 2,
              //                     child: Container(
              //                       margin: const EdgeInsets.only(left: 10.0),
              //                       child: Text(
              //                         "Dhrumil Deepak Bhayani",
              //                         // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
              //                       ),
              //                     ),
              //                   ),
              //                   Expanded(
              //                     flex: 1,
              //                     child: Container(
              //                       margin: const EdgeInsets.only(left: 0),
              //                       child: FittedBox(
              //                         fit: BoxFit.scaleDown,
              //                         alignment: Alignment.centerLeft,
              //                         child: Text(
              //                           "2023",
              //                           // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                   Expanded(
              //                     flex: 1,
              //                     child: Container(
              //                       margin: const EdgeInsets.only(left: 36),
              //                       child: FittedBox(
              //                         fit: BoxFit.scaleDown,
              //                         alignment: Alignment.centerLeft,
              //                         child: Text(
              //                           "B.E.",
              //                           // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ]);
              //               },
              //               isExpanded: itemData[index].expanded,
              //             )
              //           ],
              //           expansionCallback: (int item, bool status) {
              //             setState(() {
              //               itemData[index].expanded = !itemData[index].expanded;
              //             });
              //           },
              //         ));
              //   },
              // ),

              // Row(children: <Widget>[
              //   Expanded(
              //     flex: 1,
              //     child: Container(
              //       margin: const EdgeInsets.only(left: 36.0),
              //       child: Text(
              //         "Name",
              //         // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
              //       ),
              //     ),
              //   ),

              //   Expanded(
              //     flex: 1,
              //     child: Container(
              //       margin: const EdgeInsets.only(left: 36),
              //       child: FittedBox(
              //         fit: BoxFit.scaleDown,
              //         alignment: Alignment.centerLeft,
              //         child: Text(
              //           "Passout Year",
              //           // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
              //         ),
              //       ),
              //     ),
              //   ),
              //   Expanded(
              //     flex: 1,
              //     child: Container(
              //       margin: const EdgeInsets.only(left: 5),
              //       child: FittedBox(
              //         fit: BoxFit.scaleDown,
              //         alignment: Alignment.centerLeft,
              //         child: Text(
              //           "Program",
              //           // style: textTheme.bodyText2!.copyWith(fontSize: 15.0),
              //         ),
              //       ),
              //     ),
              //   ),
              //   // Text(
              //   //   'Click To Expand',
              //   //   style: TextStyle(color: Colors.black),
              //   // ),
              //   // Text(
              //   //   'Click To Expand',
              //   //   style: TextStyle(color: Colors.black),
              //   // ),
              //   // Text(
              //   //   'Click To Expand',
              //   //   style: TextStyle(color: Colors.black),
              //   // ),
              // ]),
        
