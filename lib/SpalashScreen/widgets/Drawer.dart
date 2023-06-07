import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intellensense/Pages/DrawerScreens/ConstituencyAnalysis.dart';
import 'package:intellensense/Pages/DrawerScreens/ElectoralAnalysis/ElectoralAnalysis.dart';
import 'package:intellensense/Pages/DrawerScreens/CandidatureAnalysis/CandidatureAnalysis.dart';
import 'package:intellensense/SpalashScreen/screens/SettingScreen.dart';
import 'package:intellensense/SpalashScreen/screens/login/login.dart';

import '../../main.dart';
import '../screens/login/mainLoginScreen.dart';

class drawer extends StatefulWidget {

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color(0xffd2dfff),
        child: ListView(children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xffd2dfff),
            ),
            child: Image.asset(
                'assets/icons/IntelliSense-Logo-Finall_01022023_A.gif'),
          ),
          ListTile(
            leading: Image(
              image: AssetImage('assets/icons/Home-Iocn.png'),
              height: 25,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ExpansionTile(
              title: Text('Political Science'),
              leading: Image.asset(
                'assets/new Updated images/intellisensesolutions-Icons-62.png',
                height: 25,
              ),
              childrenPadding: EdgeInsets.only(left: 15),
              children: [
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/new Updated images/intellisensesolutions-Icons-62.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Candidature Analysis'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CandidatureAnalysis(),
                        ));
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/new Updated images/intellisensesolutions-Icons-73 (1).png',
                    ),
                    height: 25,
                  ),
                  title: Text('Constituency Analysis'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConstituencyAnalysis(),
                        ));
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/new Updated images/intellisensesolutions-Icons-74.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Communication channel'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/new Updated images/intellisensesolutions-Icons-79.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Electoral Analysis'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ElectoralAnalysis(),
                        ));
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/new Updated images/intellisensesolutions-Icons-80.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Emotional AI'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/icons/compareIconB.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Command Center'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/new Updated images/intellisensesolutions-Icons-77.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Score Cards'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/icons/whatsapp.png',
                    ),
                    height: 25,
                  ),
                  title: Text('WhatsApp'),
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => ChatScreen()));
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/new Updated images/intellisensesolutions-Icons-76.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Sentiment Analysis'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Image(
                    image: AssetImage(
                      'assets/icons/comparative.png',
                    ),
                    height: 25,
                  ),
                  title: Text('Configurator'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),

              ]),
        
           ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
               Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingScreen(),
                        ));
            },
          ),
        ]));
  }
  // LogoutAPI(BuildContext context) async {
  //   var headers = {'Content-Type': 'application/json'};
  //   var body =
  //   json.encode({"rsUsername": "SASI_MGR"});
  //   var response = await post(
  //     Uri.parse('https://ifar.pilogcloud.com/'),
  //     headers: headers,
  //     body: body,
  //   );
  //   if (response.body == 'Success') {
  //     print(response.body);
  //     logindata.setBool('login', true);

  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => mainLoginScreen(
  //               screenHeight: MediaQuery.of(context).size.height,
  //             )));

  //     await Fluttertoast.showToast(
  //         msg: "ThankYou",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.SNACKBAR,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Color.fromRGBO(11, 74, 153, 1),
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  //   Navigator.of(context, rootNavigator: true).pop();
  //   return response;
  // }
}
