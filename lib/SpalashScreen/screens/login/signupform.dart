import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intellensense/HomeScreen.dart';
import 'package:intellensense/SpalashScreen/screens/login/login.dart';
import 'package:intellensense/SpalashScreen/screens/login/widgets/login_form.dart';
import 'package:intellensense/main.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SignUpForm extends StatefulWidget {
  var data;
  SignUpForm(this.data,);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  var input = 'MM_REQUESTOR';
  TextEditingController _pass = TextEditingController();
  TextEditingController username = TextEditingController();
  @override
  void initState() {
    print(widget.data);
    // TODO: implement initState
    super.initState();
  }

  List Requestor = [
    'MM_REQUESTOR',
    'MM_APPROVER',
    'MM_MANAGER',
    'MM_STEWARD',
    'SM_REQUESTOR',
    'SM_APPROVER',
    'SM_MANAGER'
  ];
  bool registered = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffd2dfff),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/IntelliSense-Logo-Finall_01022023_A.gif',
                  height: 200,
                  width: 200,
                ),
                Text(
                  'Create your own digital account',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 7,
                    child: SingleChildScrollView(
                      child: registered == false
                          ? Column(children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    hint: Text(
                                      '${input}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items:
                                        Requestor.map<DropdownMenuItem<String>>(
                                            (item) => DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                )).toList(),
                                    value: input,
                                    onChanged: (value) {
                                      setState(() {
                                        input = value as String;
                                        print(input);
                                      });
                                    },
                                    buttonHeight: 50,
                                    buttonWidth:
                                        MediaQuery.of(context).size.width,
                                    itemHeight: 40,
                                    iconSize: 14,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.grey[200],
                                    ),
                                    itemPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    dropdownPadding: null,
                                    dropdownElevation: 8,
                                    dropdownOverButton: true,
                                    scrollbarRadius: const Radius.circular(40),
                                    scrollbarThickness: 6,
                                    dropdownFullScreen: false,
                                    dropdownDecoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    dropdownMaxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.5,
                                    scrollbarAlwaysShow: true,
                                    offset: const Offset(-20, 0),
                                    isDense: true,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: username,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Pls enter Username';
                                    }
                                    ;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      hintText: 'Username',
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide.none),
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                      focusColor: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FancyPasswordField(
                                  controller: _pass,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Pls enter Password';
                                    }
                                    ;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.key),
                                      hintText: 'Password',
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide.none),
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                      focusColor: Colors.grey),
                                  validationRules: {
                                    UppercaseValidationRule(),
                                    LowercaseValidationRule(),
                                    DigitValidationRule(),
                                    SpecialCharacterValidationRule(),
                                  },
                                  strengthIndicatorBuilder: (strength) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: StepProgressIndicator(
                                        totalSteps: 6,
                                        currentStep: getStep(strength),
                                        selectedColor: getColor(strength)!,
                                        unselectedColor: Colors.grey[300]!,
                                      ),
                                    );
                                  },
                                  validationRuleBuilder: (rules, value) {
                                    return Wrap(
                                      runSpacing: 1,
                                      spacing: 1,
                                      children: rules.map(
                                        (rule) {
                                          final ruleValidated =
                                              rule.validate(value);
                                          return Chip(
                                            label: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                if (ruleValidated) ...[
                                                  const Icon(
                                                    Icons.check,
                                                    color: Color(0xFF0A9471),
                                                  ),
                                                  const SizedBox(width: 8),
                                                ],
                                                Text(
                                                  rule.name,
                                                  style: TextStyle(
                                                    color: ruleValidated
                                                        ? const Color(
                                                            0xFF0A9471)
                                                        : const Color(
                                                            0xFF9A9FAF),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            backgroundColor: ruleValidated
                                                ? const Color(0xFFD0F7ED)
                                                : const Color(0xFFF4F5F6),
                                          );
                                        },
                                      ).toList(),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val!.isEmpty)
                                      return 'please enter password';
                                    if (val != _pass.text)
                                      return 'Password does not match';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.password_outlined),
                                      hintText: 'Confirm Password',
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide.none),
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                      focusColor: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CheckboxListTile(
                                  title: Text(
                                      "I read and accept terms & conditions"),
                                  value: checkedValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      checkedValue = newValue!;
                                    });
                                  },
                                  controlAffinity: ListTileControlAffinity
                                      .leading, //  <-- leading Checkbox
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      SignupFormAPI();
                                    }
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.blueAccent,
                                ),
                              )
                            ])
                          : Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        'assets/new Updated images/success.gif'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Sucessfully Registered',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 19.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                         Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Login(
                        screenHeight: MediaQuery.of(context).size.height,
                      )));
                                      },
                                      child: Text('Login'),
                                      color: Colors.blueAccent,
                                    )
                                  ]),
                            ),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  String? validatePassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  int getStep(double strength) {
    if (strength == 0) {
      return 0;
    } else if (strength < .1) {
      return 1;
    } else if (strength < .2) {
      return 2;
    } else if (strength < .3) {
      return 3;
    } else if (strength < .4) {
      return 4;
    } else if (strength < .5) {
      return 5;
    } else if (strength < .6) {
      return 6;
    } else if (strength < .7) {
      return 7;
    }
    return 8;
  }

  Color? getColor(double strength) {
    if (strength == 0) {
      return Colors.grey[300];
    } else if (strength < .1) {
      return Colors.red;
    } else if (strength < .2) {
      return Colors.red;
    } else if (strength < .3) {
      return Colors.yellow;
    } else if (strength < .4) {
      return Colors.yellow;
    } else if (strength < .5) {
      return Colors.yellow;
    } else if (strength < .6) {
      return Colors.green;
    } else if (strength < .7) {
      return Colors.green;
    }
    return Colors.green;
  }

  //form
  var formdata;
  SignupFormAPI() async {
    var body;
    var headers = {'Content-Type': 'application/json'};
    setState(() {
      if (currentState == SignUpVerificationState.BYPHONE) {
        body = json.encode({
          "userName": "${username.text}",
          "email": "Byphone@piloggroup.com",
          "password": "${_pass.text}",
          "role": "${input}",
          "firstName": "zeeshan",
          "lastName": "mohd",
          "mobile": "${widget.data.toString()}"
        });
      } else if (currentState == SignUpVerificationState.BYEMAIL) {
        body = json.encode({
          "userName": "${username.text}",
          "email": "${widget.data.toString()}",
          "password": "${_pass.text}",
          "role": "${input}",
          "firstName": "zeeshan",
          "lastName": "mohd",
          "mobile": "123456789"
        });
      }
    });
    print(body);
    var response = await post(
      Uri.parse(INSIGHTS + '/register'),
      headers: headers,
      body: body,
    );

    print(response.statusCode);
    if (response.statusCode == 201) {
      formdata = response.body;
      if (formdata.toString() == 'Successfully registered ${username.text}') {
        setState(() {
          registered = true;
         
        });
      } else {
        Fluttertoast.showToast(
            msg: "Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      print(response.body);

      print(formdata);
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(
          msg: "username already exists: ${username.text}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print(response.reasonPhrase);
    }
    return formdata;
  }
}
