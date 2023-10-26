
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intellensense/SignUpPages/SIgnUpRegister_Phone.dart';
import 'package:intellensense/main.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import 'SignUpRegistration_Email.dart';

enum EmailVerificationState { SHOW_PHONE_FORM_STATE, SHOW_OTP_FORM_STATE }

class EmailSignUp extends StatefulWidget {

  @override
  State<EmailSignUp> createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  final GlobalKey<ScaffoldState> _scaffoldKeyForSnackBar =
      GlobalKey<ScaffoldState>();
  TextEditingController EmailController = TextEditingController();
  EmailVerificationState currentState =
      EmailVerificationState.SHOW_PHONE_FORM_STATE;
  bool spinnerLoading = false;
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
              Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios)),
                ],
              ),
              Image.asset(
                'assets/new Updated images/AppIcon.gif',
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
                  : currentState == EmailVerificationState.SHOW_PHONE_FORM_STATE
                      ? getPhoneFormWidget(context)
                      : getOTPFormWidget(context),
            ],
          ),
        ),
      ),
    ));
  }

  getPhoneFormWidget(context) {
    return Column(
      children: [
        const Text(
          "Enter Email to authenticate",
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 40.0,
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,

          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: EmailController,
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
              hintText: "E-mail",
              prefixIcon: Icon(Icons.phone_android_rounded)),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
            onPressed: () {
              EmailOtpAPI();
              setState(() {
                currentState = EmailVerificationState.SHOW_OTP_FORM_STATE;
              });
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Color(0xFF306EFF), // foreground
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
          onPressed: () {
            if (verifiedOTP == OTp) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUpEmail(EmailController.text)));
            } else {
              Fluttertoast.showToast(
                  msg: "Incorrect OTP",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.grey.shade900, // foreground
          ),
          child: const Text("Verify OTP Number"),
        ),
      ],
    );
  }

  var OTP;
  String? verifiedOTP;
  EmailOtpAPI() async {
    setState(() {
      spinnerLoading = true;
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await get(
      Uri.parse(INSIGHTS + '/sendOtpToEmail?email=${EmailController.text}'),
      headers: headers,
    );
    print(EmailController.text);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        spinnerLoading = false;
      });
      print(response.body);

      setState(() {
 OTP=response.body.toString();
        verifiedOTP = OTP;
      });
      print(OTP);
    } else {
      print(response.reasonPhrase);
    }
    return OTP;
  }
}
