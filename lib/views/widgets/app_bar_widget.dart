import 'package:flutter/services.dart';
import 'package:ldce_alumni/controllers/profile/profile_controller.dart';
import 'package:ldce_alumni/core/text.dart';
import 'package:ldce_alumni/theme/app_notifier.dart';
import 'package:ldce_alumni/theme/app_theme.dart';
import 'package:ldce_alumni/theme/theme_type.dart';
import 'package:flutter/material.dart';
import 'package:ldce_alumni/views/loading_effect.dart';
import 'package:provider/provider.dart';
import 'package:ldce_alumni/core/globals.dart' as globals;

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  // var token;
  Future<String?> _getToken() async {
    // token = await globals.FlutterSecureStorageObj.read(key: "access_token");
    return await globals.FlutterSecureStorageObj.read(key: "access_token");
    // return token;
  }

  final String? title;
  final GlobalKey<ScaffoldState> scaffoldKey; // Create a key
  final PreferredSizeWidget? bottom;
  AppBarWidget({Key? key, this.title, required this.scaffoldKey, this.bottom}) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    late ThemeData theme;
    late CustomTheme customTheme;
    bool isDark = false;
    TextDirection textDirection = TextDirection.ltr;
    // return Consumer<AppNotifier>(builder: (BuildContext context, AppNotifier value, Widget? child) {
    return Consumer2<AppNotifier, ProfileController>(builder: (BuildContext context, AppNotifier value, profileProvider, Widget? child) {
      isDark = AppTheme.themeType == ThemeType.dark;
      textDirection = AppTheme.textDirection;
      theme = AppTheme.theme;
      customTheme = AppTheme.customTheme;
      // return SafeArea(
      //   child:
      // Column(children: <Widget>[
      // Text("data"),
      // SizedBox(height: 10),
      return AppBar(
        automaticallyImplyLeading:  false,
        // backwardsCompatibility: false,
        //   bottom: PreferredSize(
        // child: Container(
        //               color: Colors.black.withAlpha(200),
        //               height: 43,
        //               alignment: Alignment.center,
        //               // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        //               // child: ElevatedButton(
        //               //   onPressed: () {
        //               //     Navigator.of(context).pushNamedAndRemoveUntil(
        //               //         'alumni_directory_home', ModalRoute.withName('home'));
        //               //     // Navigator.pushNamed(context, 'alumni_directory_home',
        //               //     //     arguments: homeProvider.news);
        //               //   },
        //               child: FxText.b1("ALUMNI DIRECTORY",
        //                   // fontSize: currentIndex == 0 ? 20 : null,
        //                   textAlign: TextAlign.center,
        //                   fontWeight: 600,
        //                   color: theme.colorScheme.onPrimary),
        //             ),
        //             preferredSize: Size.fromHeight(1),
        //             ),
        // toolbarHeight: AppBar().preferredSize.height,
        iconTheme: IconThemeData(color: Color.fromRGBO(255, 255, 255, 1)),
        backgroundColor: Colors.black.withOpacity(0.8),
        // backgroundColor: Colors.black.withOpacity(0.5),
        systemOverlayStyle: SystemUiOverlayStyle(
            // systemNavigationBarColor: Colors.red,
            // systemNavigationBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent.withOpacity(0.0),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark),
        flexibleSpace: SafeArea(
            child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (ModalRoute.of(context)!.settings.name != 'home') {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamedAndRemoveUntil('home', ModalRoute.withName('home'));
                  }
                },
                child: Column(children: [
                  Expanded(
                      child: Row(children: [
                    Container(
                        padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 10),
                        child: Image.asset(
                          "./assets/images/laa_logo.png",
                          height: 60,
                        )),
                    // SizedBox(
                    //   width: 10,
                    // ),

                    Container(
                        padding: EdgeInsets.only(top: 5),
                        child: FxText.t1(
                          "LDCE Connect",
                          // title ?? "",
                          textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.3),
                          color: Colors.white,
                          fontWeight: 600,
                        )),
                  ])),
                ]))),
        // leading:  Row(children: [
        //       Image.asset("./assets/images/laa_logo_notext.png",height: 100,),
        //       SizedBox(
        //         width: 5,
        //       ),
        //       if (title == null)
        //         FxText.t1(
        //           "LDCE Alumni Portal",
        //           // title ?? "",
        //           color: Colors.white,
        //           fontWeight: 600,
        //         ),
        //       if (title != null)
        //         FxText.t1(
        //           "LDCE Alumni Portal\n"+title!,
        //           // title ?? "",
        //           color: Colors.white,
        //           fontWeight: 600,
        //         ),
        //     ]),
        actions: [
          // Column(children: [
          //   Expanded(child: Row(children: [],))
          // ],)

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              profileProvider.showLoading
                  ? Container()
                  : FutureBuilder<String?>(
                      future: _getToken(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(
                            color: Colors.white,
                          );
                        } else if (snapshot.hasError || snapshot.data == null) {
                          // return Text('Error fetching token: ${snapshot.error}');
                          return SizedBox();
                        } else {
                          final token = snapshot.data;
                          print('token 160 $token');
                          if (token != null)
                            return SizedBox(
                                width: 50,
                                height: 40,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamedAndRemoveUntil('profile', ModalRoute.withName('home'));
                                    },
                                    child: profileProvider.profileResponse.Result.ProfilePicPath.toString().isNotEmpty
                                        ? CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 100,
                                            backgroundImage:
                                                NetworkImage('https://' + profileProvider.profileResponse.Result.ProfilePicPath.toString()),
                                          )
                                        : Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          )));
                          // if (token == null)
                          //   return SizedBox(
                          //       width: 50,
                          //       child: CircleAvatar(
                          //           backgroundColor: Colors.transparent,
                          //           radius: 100,
                          //           child: Icon(
                          //             Icons.person,
                          //             color: Colors.white,
                          //           )));
                        }
                        return Text('');
                      },
                    ),
              // if (token != null)
              //   SizedBox(
              //       width: 50,
              //       child: CircleAvatar(
              //         backgroundColor: Colors.transparent,
              //         radius: 100,
              //         backgroundImage: NetworkImage(
              //             'https://media.istockphoto.com/id/1393750072/vector/flat-white-icon-man-for-web-design-silhouette-flat-illustration-vector-illustration-stock.jpg?s=612x612&w=0&k=20&c=s9hO4SpyvrDIfELozPpiB_WtzQV9KhoMUP9R9gVohoU='),
              //         // NetworkImage('https://' + profileCtrl!.profileResponse.Result.ProfilePicPath.toString()),
              //         // Text(
              //         //   'GeeksForGeeks',
              //         //   style: TextStyle(fontSize: 10, color: Colors.white),
              //         // ), //Text
              //       )),
              // if (token == null)
              //   SizedBox(
              //       width: 50,
              //       child: CircleAvatar(
              //           backgroundColor: Colors.transparent,
              //           radius: 100,
              //           child: Icon(
              //             Icons.person,
              //             color: Colors.white,
              //           ))),
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      print("object");
                      print(scaffoldKey);
                      scaffoldKey.currentState!.openEndDrawer();
                    },
                    tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
            ],
          )
        ],

        // toolbar0Height: 40,
        elevation: 0.1,
      );
      // Row(
      //   children: <Widget>[
      //     Expanded(
      //         child: Container(
      //       padding: EdgeInsets.only(top: 10, left: 12),
      //       height: 40,
      //       // color: Theme.of(context).cardColor,
      //       child: Row(children: [
      //         Text(
      //           "Home > ",
      //           style: TextStyle(
      //             color: Theme.of(context).primaryColor,
      //           ),
      //         ),
      //         Text(
      //           "News",
      //           style:
      //               TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
      //         )
      //       ]),
      //     )),
      //   ],
      // ),
      // ])
      // );
      // AppBar(
      //   elevation: 0,
      //   title: FxText.t1(
      //     title ?? "",
      //     fontWeight: 600,
      //   ),
      // );
    });
  }
}
