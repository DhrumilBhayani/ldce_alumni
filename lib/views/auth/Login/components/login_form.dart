import 'package:flutter/material.dart';
import 'package:ldce_alumni/controllers/auth/auth_controller.dart';
// import '../../../components/already_have_an_account_acheck.dart';
import '../constants.dart';

class LoginForm extends StatefulWidget {
  final AuthController authProvider;
  const LoginForm({super.key, required this.authProvider});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool showPassword = true;
  bool isLoading = false;
  final _PasswordKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const Text(
            "Login to your Account",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: defaultPadding),
          Form(
              key: _emailKey,
              child: TextFormField(
                controller: widget.authProvider.emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
                onSaved: (email) {},
                decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.person),
                  ),
                  filled: true,
                  fillColor: kPrimaryLightColor,
                  iconColor: kPrimaryColor,
                  prefixIconColor: kPrimaryColor,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide.none,
                  ),
                ),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: Form(
                key: _PasswordKey,
                child: TextFormField(
                  controller: widget.authProvider.passwordController,
                  scrollPadding: const EdgeInsets.only(bottom: 40),
                  textInputAction: TextInputAction.done,
                  obscureText: showPassword,
                  cursorColor: kPrimaryColor,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid password!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.lock),
                    ),
                    filled: true,
                    fillColor: kPrimaryLightColor,
                    iconColor: kPrimaryColor,
                    prefixIconColor: kPrimaryColor,
                    // contentPadding:
                    //     EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Padding(
                        padding: EdgeInsets.all(0),
                        child: showPassword
                            ? IconButton(
                                onPressed: () {
                                  print("object");
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                icon: Icon(Icons.visibility))
                            : IconButton(
                                onPressed: () {
                                  print("object");
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                icon: Icon(Icons.visibility_off))),
                  ),
                ),
              )),
          const SizedBox(height: defaultPadding),
          isLoading
              ? const CircularProgressIndicator()
              : Hero(
                  tag: "login_btn",
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (_emailKey.currentState!.validate() && _PasswordKey.currentState!.validate()) {
                        await widget.authProvider.login();

                        if (widget.authProvider.loginResponse.access_token.isNotEmpty) {
                          setState(() {
                            isLoading = false;
                          });
                          var snackBar = SnackBar(
                            content: Text('Login Successful'),
                            backgroundColor: Theme.of(context).primaryColor,
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(milliseconds: 1500),
                            margin: EdgeInsets.all(50),
                          );

                         await ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('home', ModalRoute.withName('home'));
                        } else {
                           var snackBar = SnackBar(
                            content: Text('Invalid Email or Password'),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(milliseconds: 1500),
                            margin: EdgeInsets.all(50),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                           setState(() {
                          isLoading = false;
                        });
                        }
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Text(
                      "Login".toUpperCase(),
                    ),
                  ),
                ),
          // const SizedBox(height: defaultPadding),
          // AlreadyHaveAnAccountCheck(
          //   press: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) {
          //           return SignUpScreen();
          //         },
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
