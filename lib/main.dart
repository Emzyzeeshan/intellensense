import 'dart:collection';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intellensense/SpalashScreen/screens/login/widgets/login_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SpalashScreen/screens/login/login.dart';
import 'SpalashScreen/screens/onboarding/onboarding.dart';


Future<void> _firebadeMessagingBackgroundHandler(RemoteMessage message) async {

   Firebase.initializeApp(); // options: DefaultFirebaseConfig.platformOptions
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebadeMessagingBackgroundHandler);
  runApp(MaterialApp(
    home: MyApp(),
  ));
}late SharedPreferences logindata;
var DropdownApidata;
var data;var Selectedinput;
GlobalKey DashboardDropdownkey = GlobalKey();
class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TRS Party',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        primarySwatch: Colors.blue,
        fontFamily: 'Urbanist',
      ),
      home: Onboarding(screenHeight: screenHeight),
    );
  }
}


///login API
const rootUrl = 'http://192.169.1.211:8082';

///LogOut Api
const rootUrl1 = 'https://ifar.pilogcloud.com/';