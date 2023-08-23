import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intellensense/HomeScreen_Pages/HomeScreen.dart';
import 'package:intellensense/Constants/constants.dart';
import 'package:intellensense/LoginPages/login.dart';
import 'package:intellensense/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../LoginPages/mainLoginScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // create some values
  // Color pickerColor = Color(0xff443a49);
  // Color currentColor = Color(0xffd2dfff);

// ValueChanged<Color> callback
  // void changeColor(Color color) {
  //   setState(() => HomeColor = color);
  //   print(pickerColor);
  // }
  
  @override
  Widget build(BuildContext context) {
     final themeMode = Provider.of<DarkMode>(context);
    return Scaffold(
        // backgroundColor: Color(0xffd2dfff),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),

            child: Column(children: [
              Row(children: [IconButton(onPressed: (){

                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios))],),
              Image.asset(
                'assets/icons/IntelliSense-Logo-Finall.gif',
                height: 55,
              ),
              SizedBox(height: 10),
              Text(
                'Settings',
                style: GoogleFonts.nunitoSans(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    ),
              ),
              SizedBox(height: 10),
             
              // Padding(
              //   padding: const EdgeInsets.all(4.0),
              //   child: ListTile(
              //     tileColor: Color(0xff86a8e7),
              //     leading: Icon(Icons.format_color_fill_rounded),
              //     title: const Text('Change Background Color'),
              //     onTap: () async {
              //       await showDialog(
              //           context: context,
              //           builder: (context) {
              //             return AlertDialog(
              //                 title: const Text('Pick a color!'),
              //                 content: SingleChildScrollView(
              //                   child: ColorPicker(
              //                     showLabel: true,
              //                     pickerColor: HomeColor,
              //                     onColorChanged: changeColor,
              //                   ),
              //                 ));
              //           });
              //     },
              //   ),
              // ),
        
               Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: ListTile(
                  tileColor: Color(0xff86a8e7),
                    leading: const Icon(Icons.dark_mode, size: 35),
                    title: const Text("Dark Mode"),
                    subtitle: const Text("Here you can change you're theme."),
                    trailing: CupertinoSwitch(
                      focusColor: Color.fromARGB(255, 89, 216, 255),
                      value: themeMode.darkMode,
                      //activeTrackColor: const Color.fromARGB(255, 89, 216, 255),
                      activeColor: Colors.green,
                      onChanged: (value) {
                        themeMode.changeMode();
                      },
                    ),
                  ),
               ),
                 Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: ListTile(
                  tileColor: Color(0xff86a8e7),
                    leading: const Icon(Icons.lock, size: 35),
                    title: const Text("App Lock"),
                    subtitle: const Text("Secure using Biometric"),
                    trailing: CupertinoSwitch(applyTheme: true,
                      value:logindata.getBool('auth') == null
                          ? false
                          : logindata.getBool('auth')!,
                      focusColor: Color.fromARGB(255, 89, 216, 255),
                      //activeTrackColor: const Color.fromARGB(255, 89, 216, 255),
                      activeColor: Colors.green,
                      onChanged: (value) {
                       setState(() {
                          logindata.setBool('auth', value);
                        });
                        print(logindata.getBool('auth'));
                      },
                    ),
                  ),
               ),
                Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  tileColor:Color(0xff86a8e7),
                  leading: Icon(Icons.logout_outlined),
                  title: const Text('LogOut'),
                  onTap: () {
                    CoolAlert.show(
                      confirmBtnColor: Color(0xff00186a),
                      backgroundColor: Color(0xff001969),
                      context: context,
                      type: CoolAlertType.confirm,
                      onConfirmBtnTap: () => LogoutAPI(context),
                    );
                  },
                ),
              ),
            ]),
          ),
        ));
  }

  LogoutAPI(BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({"rsUsername": "SASI_MGR"});
    var response = await post(
      Uri.parse('https://ifar.pilogcloud.com/appUserlogout'),
      headers: headers,
      body: body,
    );
    if (response.body == 'Success') {
      print(response.body);

        logindata.setBool('login', true); await Navigator.push(
            context,
            PageTransition(
                duration: Duration(seconds: 1),
                type: PageTransitionType.leftToRightWithFade,
                child: mainLoginScreen(
                  screenHeight: MediaQuery.of(context).size.height,
                )));





      await Fluttertoast.showToast(
          msg: "ThankYou",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(11, 74, 153, 1),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print(response.reasonPhrase);
    }
    Navigator.of(context, rootNavigator: true).pop();
    return response;
  }
}
