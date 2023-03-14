import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:quickalert/models/quickalert_animtype.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../HomeScreen.dart';
import '../../../../main.dart';
import '../../../constants.dart';
import 'custom_button.dart';
import 'custom_input_field.dart';
import 'fade_slide_transition.dart';

class LoginForm extends StatefulWidget {
  final Animation<double> animation;

  const LoginForm({
    required this.animation,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String userName = '', passWord = '';
  String instance = '',
      plant = '',
      roleId = '',
      locale = '',
      env = '',
      orgn = '';
  bool userError = false, showPasswordField = false, passError = false;
  final userNameText = TextEditingController();
  final passWordText = TextEditingController();
  bool _visible = true;
  bool islogin = false;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
var userDetails;

  clearText() {
    userNameText.clear();
    passWordText.clear();
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameText.dispose();
    passWordText.dispose();
   /* subscription.cancel();*/
    super.dispose();
  }
  var newuser;
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  initState() {check_if_already_login();
    super.initState();
    userName = 'SASI_MGR';
    userNameText.text = 'SASI_MGR';
    passWord = 'P@ssw0rd';
    passWordText.text = 'P@ssw0rd';

    /* WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HighLevelMenu(
            {},
          ),
        ),
      );
    });*/
  }
  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height*3 - MediaQuery.of(context).padding.top;
    final space = height > 650 ? kSpaceM : kSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        children: <Widget>[
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: 0.0,
            child:  TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  userName = value;
                  userError = false;
                  passError = false;
                });
              },
              controller: userNameText,
              //controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(kPaddingM),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                ),
                hintText: 'UserName',
                hintStyle: TextStyle(
                  color: kBlack.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(
                  Icons.person,
                  color: kBlack.withOpacity(0.5),
                ),
              ),
            )
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: space,
            child:  TextFormField(
              onChanged: (value) {
                passWord = value;
                setState(() {
                  userError = false;
                  passError = false;
                });
              },
              obscureText: _visible,
              controller: passWordText,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(kPaddingM),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: kBlack.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: kBlack.withOpacity(0.5),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _visible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Theme.of(context)
                        .primaryColorDark,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _visible = !_visible;
                    });
                  },
                ),
              ),
            )
          ),

          SizedBox(height: space),
          (userError
              ? ListTile(
            title: Text(
              'Invalid credentials',
              style: TextStyle(color: Colors.red),
            ),
            subtitle: Text(
              'Please check username and try again',
              style: TextStyle(color: Colors.red),
            ),
          )
              : Container(height: 0)),
          (passError
              ? ListTile(
            title: Text(
              'Invalid credentials',
              style: TextStyle(color: Colors.red),
            ),
            subtitle: Text(
              'Please check password and try again',
              style: TextStyle(color: Colors.red),
            ),
          )
              : Container(height: 0)),
          InkWell(
              onTap: () async {
                try {
                  final result =
                  await InternetAddress.lookup(
                      'example.com');
                  if (result.isNotEmpty &&
                      result[0].rawAddress.isNotEmpty) {
                    setState(() {
                      userError = false;
                      passError = false;
                    });
                    var res = await post(
                        Uri.parse(rootUrl + '/user/login'),
                        body: jsonEncode({
                          "rsUsername": userNameText.text,
                          "rsPassword": passWordText.text
                        }).toString(),
                        headers: {
                          'Content-Type':
                          'application/json',
                        });
                    var response = jsonDecode(res.body);
                    if (response['error'] ==
                        "Username Incorrect")
                      setState(() {
                        userError = true;
                        islogin = false;
                      });
                    else if (response['error'] ==
                        "Password Incorrect" &&
                        !showPasswordField)
                      setState(
                              () { showPasswordField = true;
                          islogin = false;
                          });
                    else if (response['error'] ==
                        "Password Incorrect" &&
                        showPasswordField)
                      setState(() {passError = true;
                      islogin = false;
                      });
                    else {
                      var login = response['message'] ?? '';
                      if (login == 'success') {
                        islogin = true;
                        //  userDetails = {
                        //   'userName': userNameText.text,
                        //   'instance': response['instance'],
                        //   'plant': response['plant'],
                        //   'env': response['env'],
                        //   'orgn': response['orgn'],
                        //   'roleId': response['roleId'],
                        //   'locale': response['locale']
                        // };
                        print(res);
                        print(userDetails);
                        String username = userNameText.text;
                        String password = passWordText.text;
                        if (username != '' && password != '') {
                          print('Successfull');
                          logindata.setBool('login', false);
                          logindata.setString('username', username.toUpperCase());
                          logindata.setString('roleId', response['roleId']);
                          logindata.setString('password', password);

                          await Fluttertoast.showToast(
                              msg: "Welcome",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.SNACKBAR,
                              backgroundColor: Color(0xff29378f),
                              textColor: Colors.white,
                              fontSize: 16.0);
                          setState(() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: ((context) => HomeScreen())));
                          });
                        }

                        // await Fluttertoast.showToast(
                        //     msg: "Welcome",
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.SNACKBAR,
                        //     backgroundColor:
                        //     Color(0xff29378f),
                        //     textColor: Colors.white,
                        //     fontSize: 16.0);
                        // await Timer(Duration(seconds: 3),
                        //         () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (_) =>
                        //                   HomeScreen(
                        //                       userDetails
                        //                   ))
                        //       ).then((value) {
                        //         setState((){    islogin=false;});
                        //
                        //       });
                        //     });

                        setState(() {
                          userName = '';
                          passWord = '';
                          userError = false;
                          passError = false;
                        });
                      } else
                        setState(() {
                          userError = true;
                          islogin = false;
                        });
                    }
                  }
                } on SocketException catch (_) {
                  islogin = false;
                  print('not connected');
                  return await QuickAlert.show(
                    animType: QuickAlertAnimType.slideInUp,
                    backgroundColor: Colors.white,
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Oops...',
                    text: 'Please Check Your Internet!!',
                    confirmBtnColor: Color(0xff5163da),
                  );
                }

                /* print("Sign in click");
                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SmartSearch())); */
              },
              child: Center(
                child: islogin == true
                    ? CircularProgressIndicator(
                  color: Color(0xff00186a),
                )
                    : Container(
                  width: MediaQuery.of(context)
                      .size
                      .width *
                      0.5,
                  height: MediaQuery.of(context)
                      .size
                      .height *
                      0.07,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(50)),
                    color: Color(0xFF306EFF),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              )),
          /*FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: 2 * space,
            child: CustomButton(
              color: kBlue,
              textColor: kWhite,
              text: 'Login',
              onPressed: () {},
            ),
          ),*/
          SizedBox(height: 2 * space),
          /*FadeSlideTransition(
            animation: animation,
            additionalOffset: 3 * space,
            child: CustomButton(
              color: kWhite,
              textColor: kBlack.withOpacity(0.5),
              text: 'Continue with Google',
              image: const Image(
                image: AssetImage(kGoogleLogoPath),
                height: 48.0,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 4 * space,
            child: CustomButton(
              color: kBlack,
              textColor: kWhite,
              text: 'Create a Bubble Account',
              onPressed: () {},
            ),
          ),*/
        ],
      ),
    );
  }
}
