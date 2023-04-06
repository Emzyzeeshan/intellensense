import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'main.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedValue;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    DeviceSizeConfig().init(context);
    late Future<dynamic> finaldata = DropdownApi();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(''),
        ),
        body: Column(children: [
          Container(
            height: MediaQuery.of(context).orientation == Orientation.landscape
                ? DeviceSizeConfig.screenHeight! * 0.2
                : DeviceSizeConfig.screenHeight! * 0.14,
            decoration: BoxDecoration(
                /* gradient: LinearGradient(
                colors: [
                  Color(0xff6d96fa),
                  Color(0xffd7e2fe),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),*/
                ),
            child: Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FutureBuilder(
                      future: finaldata,
                      builder: ((context, snapshot) {
                        /*if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Align(
                            alignment: Alignment.bottomCenter,
                            child:  SleekCircularSlider(
                                appearance: CircularSliderAppearance(
                                  size: 50,
                                  customColors: CustomSliderColors(
                                      trackColor:    Color(0xff6d96fa), progressBarColor: Colors.white),
                                  spinnerMode: true,
                                )));
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {*/
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              key: DashboardDropdownkey,
                              hint: Text(
                                'ok',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: data['dashBordlist']
                                  .map<DropdownMenuItem<String>>(
                                      (item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item.toString(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                  .toList(),
                              value: Selectedinput,
                              onChanged: (value) {
                                setState(() {
                                  Selectedinput = value as String;
                                  print(Selectedinput);
                                  Selectedinput = Selectedinput;
                                  // pageController.jumpToPage(
                                  //     data['dashBordlist']
                                  //         .indexOf(selectedValue));
                                  // print(data['dashBordlist']
                                  //     .indexOf(selectedValue));
                                });
                              },
                              buttonHeight: 50,
                              buttonWidth: MediaQuery.of(context).size.width,
                              itemHeight: 40,
                              iconSize: 14,
                              buttonPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.grey[200],
                              ),
                              itemPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              dropdownPadding: null,
                              dropdownElevation: 8,
                              dropdownOverButton: true,
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              dropdownFullScreen: false,
                              dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15)),
                              dropdownMaxHeight:
                                  MediaQuery.of(context).size.height * 0.5,
                              scrollbarAlwaysShow: true,
                              offset: const Offset(-20, 0),
                              isDense: true,
                            ),
                          ),
                        );
                      } /*else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text(
                            'State: ${snapshot.connectionState}');
                      }*/
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*Container(
          child: Flexible(
            child: HR_Dashboard(),
          ),
        ),*/
        ]));
  }

  Future<dynamic> DropdownApi() async {
    // await Future.delayed(Duration(seconds: 1));
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({});
    var response = await post(
      Uri.parse('http://192.169.1.211:8080/smartBi/smartIntBi/getChartData'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      setState(() {
        DropdownApidata = response.body;
        data = jsonDecode(response.body);
        Selectedinput = data['dashBordlist'][0];
      });

      // print(data);
      print(data['dashBordlist']);
    } else {
      print(response.reasonPhrase);
    }
    return data;
  }
}

class DeviceSizeConfig {
  static MediaQueryData? mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  static double? textScale;
  static double? safeAreaHorizontal;
  static double? safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;
  static double? paddingRight;
  static double? paddingLeft;
  static double? paddingTop;
  static double? paddingBottom;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData?.size.width;
    screenHeight = mediaQueryData?.size.height;

    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
    textScale = mediaQueryData?.textScaleFactor;
    paddingLeft = mediaQueryData?.padding.left;
    paddingRight = mediaQueryData?.padding.right;
    paddingTop = mediaQueryData?.padding.top;
    paddingBottom = mediaQueryData?.padding.bottom;
    safeAreaHorizontal = paddingRight! + paddingRight!;

    safeAreaVertical = paddingTop! + paddingBottom!;
    safeBlockHorizontal = (screenWidth! - safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - safeAreaVertical!) / 100;
  }
}
