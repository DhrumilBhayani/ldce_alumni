import 'package:flutter/material.dart';
import 'package:ldce_alumni/controllers/auth/auth_controller.dart';
import 'package:ldce_alumni/views/auth/Login/constants.dart';
import 'package:provider/provider.dart';

import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(builder: (BuildContext context, authProvider, Widget? child) {
      return Scaffold(
        appBar: AppBar(shadowColor: Colors.transparent,),
        body: SafeArea(child: SingleChildScrollView(child: MobileLoginScreen()),
      ));
    });
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(builder: (BuildContext context, authProvider, Widget? child) {
      return
          // SingleChildScrollView(

          //   child:
          Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           SizedBox(
            height: defaultPadding * 6,
          ),
          const LoginScreenTopImage(),
          SizedBox(
            height: defaultPadding * 2,
          ),
          Row(
            children: [
              Spacer(),
              Expanded(
                flex: 8,
                child: LoginForm(
                  authProvider: authProvider,
                ),
              ),
              Spacer(),
            ],
          ),
        ],
      );
    });
  }
}
