import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intellensense/Services/themesetup/DarkThemeProvider.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Services/themesetup/styles.dart';

import 'SpalashScreen/screens/login/mainLoginScreen.dart';

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
}

late SharedPreferences logindata;
var DropdownApidata;
var data;
var Selectedinput;
GlobalKey DashboardDropdownkey = GlobalKey();

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getCurrentAppTheme();
    // TODO: implement initState
    super.initState();
  }

  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final screenHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(create: (_) {
      return themeChangeProvider;
    }, child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
      return MaterialApp(
        theme: Styles.themeData(themeChangeProvider.darkTheme, context),
        debugShowCheckedModeBanner: false,
        title: 'TRS Party',
        home: mainLoginScreen(screenHeight: screenHeight),
      );
    }));
  }
}

///login API
const rootUrl = 'http://192.169.1.211:8082';

///LogOut Api
const rootUrl1 = 'https://ifar.pilogcloud.com/';
