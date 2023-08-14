import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intellensense/HomeScreen_Pages/HomeScreen.dart';
import 'package:intellensense/LoginPages/widgets/fade_slide_transition.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../main.dart';
import '../Constants/constants.dart';

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
  final GlobalKey<FormFieldState> formFieldKey = GlobalKey();
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

  @override
  initState() {
    super.initState();
    userNameText.text= 'david';
    passWordText.text = 'David@06';

  }
  final ValueNotifier<bool> popup = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 3 -
        MediaQuery.of(context).padding.top;
    final space = height > 650 ? kSpaceM : kSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Form(
        key: formFieldKey,
        child: Column(
          children: <Widget>[
            FadeSlideTransition(
                animation: widget.animation,
                additionalOffset: 0.0,
                child: TextFormField(
                  keyboardType: TextInputType.text,

                  controller: userNameText,
                  //controller: controller,
                  decoration: InputDecoration(errorText: userError==true?'User Not Found':'',
border: InputBorder.none,
                    fillColor: Color.fromARGB(166, 240, 237, 237),
                    filled: true,
                    contentPadding: const EdgeInsets.all(kPaddingM),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
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
                )),
            SizedBox(height: space),
            FadeSlideTransition(
                animation: widget.animation,
                additionalOffset: space,
                child: TextFormField(

                  obscureText: _visible,
                  controller: passWordText,
                  decoration: InputDecoration(border: InputBorder.none,
                    errorText: passError==true?'Invid Username Or Password':'',
                    fillColor: Color.fromARGB(166, 240, 237, 237),
                    filled: true,
                    contentPadding: const EdgeInsets.all(kPaddingM),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
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
                        _visible ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _visible = !_visible;
                        });
                      },
                    ),
                  ),
                )),
            SizedBox(height: space),




          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Align(
              alignment: Alignment.center,
              child: ValueListenableBuilder<bool>(
                  valueListenable: popup,
                  builder: (context, value, _) {
                    return popup.value
                        ? SpinKitSpinningLines(
                      lineWidth: 5,
                      size: 50,
                      color: Colors.blueAccent,
                    )
                        : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          popup.value = true;
                        });
                        await Future.delayed(Duration(seconds: 2));
                        try {
                          // final result = await InternetAddress.lookup('example.com');
                          // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                            LoginAPI();
          //}
                        } catch (_) {
                          // islogin = false;
                          // print('not connected');
                          // return await QuickAlert.show(
                          //   animType: QuickAlertAnimType.slideInUp,
                          //   backgroundColor: Colors.white,
                          //   context: context,
                          //   type: QuickAlertType.error,
                          //   title: 'Oops...',
                          //   text: 'Please Check Your Internet!!',
                          //   confirmBtnColor: Color(0xff5163da),
                          // );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 20.0),
                        backgroundColor: Color(0xff6d96fa),
                        shape: StadiumBorder(),
                      ),
                      /*shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0),*/

                          child: Text(
                            "Login",
                            style: GoogleFonts.nunitoSans(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),


                    );
                  }),
            ),
          ),
            // InkWell(
            //     onTap: () async {
            //
            //
            //     },
            //     child:
            //
            //
            //     Container(
            //               width: MediaQuery.of(context).size.width * 0.5,
            //               height: MediaQuery.of(context).size.height * 0.07,
            //               margin: const EdgeInsets.only(left: 20, right: 20),
            //               decoration: const BoxDecoration(
            //                 borderRadius: BorderRadius.all(Radius.circular(50)),
            //                 color: Color(0xFF306EFF),
            //               ),
            //               child: Center(
            //                 child: Text(
            //                   "Login",
            //                   style: GoogleFonts.nunitoSans(
            //                       fontSize: 15,
            //                       fontWeight: FontWeight.w700,
            //                       color: Colors.white),
            //                 ),
            //               ),
            //             ),
            //     ),
          ],
        ),
      ),
    );
  }


  //Login APi
  var loginData;
LoginAPI()async{
   bool result= await InternetConnectionChecker().hasConnection;
if(result==true){
   var headers = {'Content-Type': 'application/json'};
  var body=json.encode({
    "username": "${userNameText.text}",
    "password": "${passWordText.text}"
  });
  print('hi2');
  var response = await post(
    Uri.parse(
        rootURL1 + '/auth/login'),
    headers: headers,
    body:body,
  );

  print(response.statusCode);
  if (response.statusCode == 200) {
print(response.body);
    print(response.statusCode);
    try {
      setState(() {

        loginData =json.decode(response.body);

      });
      if(loginData['message'].toString()=='Success'){
        logindata.setBool('login', false);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HomeScreen(),
            ));
        popup.value=false;

      }else if(loginData['message'].toString()=='Error: Invid Username Or Passwordal.'){


        setState(() {
          passError=true; 
           popup.value=false;
        });
      }
    } catch (e) {}
  }else if(response.statusCode==400){
   setState(() {
     userError=true;
     popup.value=false;
   });
  }
  else {
    print(response.reasonPhrase);
  }
}else{setState(() {
  Fluttertoast.showToast(
        msg: "Pls Check Internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
   popup.value=false;

});

}
 
  return loginData;
}
}

