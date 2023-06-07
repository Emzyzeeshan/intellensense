import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intellensense/HomeScreen_Pages/HomeScreen.dart';
import 'package:intellensense/Constants/constants.dart';
import 'package:intellensense/LoginPages/login.dart';
import 'package:intellensense/main.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xffd2dfff);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => HomeColor = color);
    print(pickerColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffd2dfff),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
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
                  color: Colors.black),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                tileColor: Colors.grey.shade200,
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
            Padding(
              padding: const EdgeInsets.all(4.0),
              child:
              
              
               ListTile(
                tileColor: Colors.grey.shade200,
                leading: Icon(Icons.format_color_fill_rounded),
                title: const Text('Change Background Color'),
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: const Text('Pick a color!'),
                            content: SingleChildScrollView(
                              child: ColorPicker(showLabel: true,
                                pickerColor: HomeColor,
                                onColorChanged: changeColor,
                              ),
                            ));
                      });
                },
              ),
            ),
          ]),
        ));
  }

  LogoutAPI(BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    var body =
        json.encode({"rsUsername": "${logindata.getString('username')}"});
    var response = await post(
      Uri.parse('https://ifar.pilogcloud.com/appUserlogout'),
      headers: headers,
      body: body,
    );
    if (response.body == 'Success') {
      print(response.body);
      logindata.setBool('login', true);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Login(
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
