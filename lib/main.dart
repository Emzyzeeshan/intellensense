import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intellensense/HomeScreen_Pages/HomeScreen.dart';


import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constants/themesetup/DarkThemeProvider.dart';
import 'Constants/themesetup/styles.dart';
import 'LoginPages/mainLoginScreen.dart';

Future<void> _firebadeMessagingBackgroundHandler(RemoteMessage message) async {
  Firebase.initializeApp(); // options: DefaultFirebaseConfig.platformOptions
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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
     check_if_already_login();
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
        home:
        
         mainLoginScreen(screenHeight: screenHeight),
      );
    }));
  }
    var newuser;
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false || FirebaseAuth.instance.authStateChanges() == true) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
enum SignUpVerificationState { BYEMAIL, BYPHONE }
  SignUpVerificationState? currentState ;
///login API
const rootUrl = 'http://192.169.1.173:8080';
///login API new
const rootURL1 = 'http://192.169.1.211:8082/insights/3.67.0';
///LogOut Api
const rootUrl1 = 'https://ifar.pilogcloud.com/';

///{{INSIGHTS-URL}}
const INSIGHTS = 'http://192.169.1.211:8082/insights/3.67.0';
