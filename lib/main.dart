import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intellensense/HomeScreen_Pages/HomeScreen.dart';
import 'package:intellensense/LoginPages/login.dart';
import 'package:intellensense/SplashScreen/splashanimation.dart';
import 'package:local_auth/local_auth.dart';


import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constants/themesetup/DarkThemeProvider.dart';
import 'Constants/themesetup/styles.dart';
import 'LoginPages/mainLoginScreen.dart';
import 'firebase_options.dart';

Future<void> _firebadeMessagingBackgroundHandler(RemoteMessage message) async {
  Firebase.initializeApp(); // options: DefaultFirebaseConfig.platformOptions
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  //
   FirebaseMessaging.onBackgroundMessage(_firebadeMessagingBackgroundHandler);
  runApp(ChangeNotifierProvider(create: (context) => DarkMode(), child: MyApp()));
}

late SharedPreferences logindata;
var DropdownApidata;
var data;
var Selectedinput;
GlobalKey DashboardDropdownkey = GlobalKey();
  PageController pageController=PageController();
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
 authb();

    getCurrentAppTheme();
    // TODO: implement initState
    super.initState();
  }

  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }
  authb() async {
    logindata = await SharedPreferences.getInstance();
    if (logindata.getBool('auth') == true) {
      print('ok');
      _authenticate();
    } else {
      logindata.setBool('auth', false);
    }
  }
bool authenticated = false;
  final LocalAuthentication auth = LocalAuthentication();
  Future<bool> _authenticate() async {
    String _authorized = 'Not Authorized';
    bool _isAuthenticating = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(sensitiveTransaction: true,
          useErrorDialogs: true,
          stickyAuth: true,
        ),

      );

      setState(() {
        _isAuthenticating = false;
      });
      print('auth');
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
    if (!mounted) {}
    if (_authorized == 'Not Authorized') {
      setState(() {
        exit(0);
      });
    }

    return authenticated;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final screenHeight = MediaQuery.of(context).size.height;
  final themeMode = Provider.of<DarkMode>(context);
  var mainTheme = ThemeData.light();
  var darkTheme = ThemeData.dark();
 

    return ChangeNotifierProvider(create: (_) {
      return themeChangeProvider;
    }, child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
      return GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(

           theme: themeMode.darkMode ?darkTheme: mainTheme  ,

      //     theme: ThemeData(
      //   brightness: Brightness.light,
      //   /* light theme settings */
      // ),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      //   /* dark theme settings */
      // ),
      // themeMode: ThemeMode.dark, 
          // theme: Styles.themeData(themeChangeProvider.darkTheme, context),
          debugShowCheckedModeBanner: false,
          title: 'TRS Party',
          home:SplashAnimation()
          //  mainLoginScreen(screenHeight: screenHeight),
        ),
      );
    }));
  }
 

}
enum SignUpVerificationState { BYEMAIL, BYPHONE }
  SignUpVerificationState? currentState ;
///login API
const rootUrl = 'http://192.169.1.173:8080';
///login API new
const rootURL1 = 'http://apimobile.pilogcloud.com:8080/insights/3.67.0';
///LogOut Api
const rootUrl1 = 'https://ifar.pilogcloud.com/';

///{{INSIGHTS-URL}}
const INSIGHTS = 'http://apimobile.pilogcloud.com:8080/insights/3.67.0';

class DarkMode with ChangeNotifier {

  bool darkMode = false; ///by default it is true
  ///made a method which will execute while switching
  changeMode() {
    darkMode = !darkMode;
    notifyListeners(); ///notify the value or update the widget value
  }
}