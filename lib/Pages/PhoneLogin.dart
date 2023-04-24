import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intellensense/main.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:intellensense/Home3.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

enum PhoneVerificationState { SHOW_PHONE_FORM_STATE, SHOW_OTP_FORM_STATE }

class PhoneAuthPage extends StatefulWidget {
  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final GlobalKey<ScaffoldState> _scaffoldKeyForSnackBar =
      GlobalKey<ScaffoldState>();
  PhoneVerificationState currentState =
      PhoneVerificationState.SHOW_PHONE_FORM_STATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  String? verificationIDFromFirebase;
  bool spinnerLoading = false;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _verifyPhoneButton() async {
    print("Phone Number:" '+91' + "${phoneController.text}");
    setState(() {
      spinnerLoading = true;
    });
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+91' + phoneController.text,
        verificationCompleted: (phoneAuthCredential) async {
          setState(() {
            spinnerLoading = false;
          });
          //TODO: Auto Complete Function
          //signInWithPhoneAuthCredential(phoneAuthCredential);
        },
        verificationFailed: (verificationFailed) async {
          setState(() {
            spinnerLoading = true;
          });
          var snackBar = SnackBar(
              content: Text(
                  "Verification Code Failed: ${verificationFailed.message}"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        codeSent: (verificationId, resendingToken) async {
          setState(() {
            spinnerLoading = false;
            currentState = PhoneVerificationState.SHOW_OTP_FORM_STATE;
            this.verificationIDFromFirebase = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }

  _verifyOTPButton() async {
    if (phoneController.text.length == 10) {
      SendDatatoSheet();
    } else {
      print('Enter 10 digit mobile');
    }
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationIDFromFirebase!, smsCode: OTp);
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      spinnerLoading = true;
    });
    try {
      final authCredential =
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      setState(() {
        spinnerLoading = false;
      });
      if (authCredential.user != null) {
        logindata.setBool('login', false);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home3()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        spinnerLoading = false;
      });
      var snackBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  getPhoneFormWidget(context) {
    return Column(
      children: [
        const Text(
          "Enter phone number to authenticate",
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 40.0,
        ),
        TextField(
          keyboardType: TextInputType.phone,
          maxLength: 10,
          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: phoneController,
          textAlign: TextAlign.start,
          decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(166, 240, 237, 237),
              isDense: true,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              hintText: "Phone Number",
              prefixIcon: Icon(Icons.phone_android_rounded)),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
            onPressed: () => _verifyPhoneButton(),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF306EFF), // background
              onPrimary: Colors.white, // foreground
            ),
            child: const Text("Verify")),
      ],
    );
  }

  String OTp = '';
  getOTPFormWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Enter OTP Number",
          style: const TextStyle(fontSize: 16.0),
        ),
        const SizedBox(
          height: 40.0,
        ),
        OTPTextField(
          spaceBetween: 8,
          length: 6,
          width: MediaQuery.of(context).size.width,
          fieldWidth: 50,
          style: TextStyle(fontSize: 17),
          textFieldAlignment: MainAxisAlignment.center,
          fieldStyle: FieldStyle.box,
          onCompleted: (pin) {
            print("Completed: " + pin);
            setState(() {
              OTp = pin;
            });
          },
        ),
        // TextField(
        //   controller: otpController,
        //   textAlign: TextAlign.start,
        //   decoration: const InputDecoration(
        //       hintText: "OTP Number",
        //       prefixIcon: Icon(Icons.confirmation_number_rounded)),
        // ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
          onPressed: () => _verifyOTPButton(),
          style: ElevatedButton.styleFrom(
            primary: Colors.grey.shade900, // background
            onPrimary: Colors.white, // foreground
          ),
          child: const Text("Verify OTP Number"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffd2dfff),
      key: _scaffoldKeyForSnackBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/IntelliSense-Logo-Finall.gif',
                height: 200,
                width: 200,
              ),
              const SizedBox(
                height: 40.0,
              ),
              spinnerLoading
                  ? const Center(
                      child: SpinKitCircle(
                        color: Color.fromARGB(255, 243, 33, 58),
                        size: 75,
                      ),
                    )
                  : currentState == PhoneVerificationState.SHOW_PHONE_FORM_STATE
                      ? getPhoneFormWidget(context)
                      : getOTPFormWidget(context),
            ],
          ),
        ),
      ),
    ));
  }
  void SendDatatoSheet() async {
    const String scriptURL =
        'https://script.google.com/macros/s/AKfycbzeEtxTVd-vRNFpG7zqw0yHM0kGtG_ccXmRXqHR7pgFkAZyI7520Y7Era8l0to1IuSG/exec';

    String tempName = phoneController.text;
    String tempSex = OTp;
    String tempAge = OTp;

    String queryString = "?name=$tempName&sex=$tempSex&age=$tempAge";

    var finalURI = Uri.parse(scriptURL + queryString);
    var response = await http.get(finalURI);
    //print(finalURI);
    if (response.statusCode == 200) {
      var bodyR = convert.jsonDecode(response.body);
      print(bodyR);
    }
  }
}
