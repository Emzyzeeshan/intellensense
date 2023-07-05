import 'dart:convert';
import 'dart:typed_data';

import 'package:animations/animations.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:intellensense/main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intellensense/main.dart';
import '../../../../Constants/ResponsiveSize.dart';
import '../../../../Constants/constants.dart';
import 'Candidature Analysis/PartyMemberDetails.dart';

class CandidatureAnalysis extends StatefulWidget {

  @override
  State<CandidatureAnalysis> createState() => _CandidatureAnalysisState();
}

class _CandidatureAnalysisState extends State<CandidatureAnalysis> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var input = 'TRS';
  List PartyName = ["IND", "JSP", "SHIV SENA ", "COMMUNIST PARTY OF INDIA (MARXIST)", "BJP", "RASHTRIYA JANATA DAL", "TRS", "AIFB", "ALL INDIA TRINAMOOL CONGRESS ", "SAMAJWADI PARTY", "INC", "AIMIM", "TDP", "JANATHA DAL (SECULAR)", "BHARATHIYA JANATHA PARTI", "JANATHA DAL (UNITED)", "DRAVIDA MUNNETRA KAZHAGAM(DMK)", "YSRCP", "AAM AADMI PARTY", "NATIONALIST CONGRESS PARTY"];
  late Future<dynamic> finaldata = PartyDataApi('TRS');
  ScrollController? scrollController = ScrollController();
  Uint8List? myImage;
  List fullData = [];
  List searchData = [];
  TextEditingController textEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    DeviceSizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: HomeColor,
        appBar: AppBar(
          leading: Container(),
          toolbarHeight: 55,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only( top: 35, left: 8, right: 8),
            child: Row(
              children: [

                // Image.asset('assets/icons/IntelliSense-Logo-Finall.gif',
                //     height: 35),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search....',
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        focusColor: Colors.grey),
                    controller: textEditingController,
                    onChanged: onSearchTextChanged,
                  ),
                ),
                     SizedBox(width: 10,),
                ToggleSwitch(
                  minWidth: 35.0,
                  minHeight: 35.0,
                  initialLabelIndex: 0,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  icons: [
                    FontAwesomeIcons.searchengin,
                    FontAwesomeIcons.filter,
                  ],
                  iconSize: 30.0,
                  activeBgColors: [[Colors.black26],
                    [ Colors.green ],
                    
                  ],
                  animate:
                      true, // with just animate set to true, default curve = Curves.easeIn
                  curve: Curves
                      .bounceInOut, // animate must be set to true when using custom curve
                  onToggle: (index) {
                    if(index==0){
                      pageController.jumpToPage(0);
                    }else if(index==1){
pageController.jumpToPage(1);
                    }
                    print('switched to: $index');
                  },
                ),
              ],
            ),
          ),
          backgroundColor: HomeColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  key: DashboardDropdownkey,
                  hint: Text(
                    '${input}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: PartyName.map<DropdownMenuItem<String>>(
                          (item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item.toString(),
                          style:  TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      )).toList(),
                  value: input,
                  onChanged: (value) {
                    setState(() {
                      input = value as String;
                      print(input);
                      finaldata = PartyDataApi(input);
                      // pageController.jumpToPage(
                      //     data['dashBordlist']
                      //         .indexOf(selectedValue));
                      // print(data['dashBordlist']
                      //     .indexOf(selectedValue));
                    });
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: TextfieldColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(15))),
                    height: 40,
                  ),
                ),
              ),
            ),
            searchData.length ==
                0 // Check SearchData list is empty or not if empty then show full data else show search data
                ? FutureBuilder(
              future: finaldata,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.35),
                    child: SpinKitWave(
                      size: 30,
                      color: Colors.blueAccent,
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: const Text('Data Error'));
                  } else if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: partydata.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, bottom: 5),
                              child: OpenContainer(
                                closedColor: Color(0xffd2dfff),
                                openColor: Color(0xffd2dfff),
                                closedElevation: 10.0,
                                openElevation: 10.0,
                                closedShape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0)),
                                ),
                                transitionType:
                                ContainerTransitionType.fade,
                                transitionDuration:
                                const Duration(milliseconds: 1200),
                                openBuilder: (context, action) {
                                  return TrsMpDetails(partydata[index]);
                                },
                                closedBuilder: (context, action) {
                                  return ListTile(
                                    dense: true,
                                    tileColor: Color(0xffd2dfff),

                                    subtitle: Text(
                                        "Party: ${partydata[index]['party']}"),
                                    // collapsedBackgroundColor: Colors.grey.shade100,
                                    // tilePadding: EdgeInsets.all(5),

                                    leading: Container(decoration: BoxDecoration(shape: BoxShape.circle),
                                      height: 50,
                                      width: 50,
                                      child: CircleAvatar(minRadius: 30,
                                        backgroundImage: MemoryImage(
                                            base64Decode(partydata[index]
                                            ['content']
                                                .substring(22) ??
                                                ''),scale: 10
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                        '${partydata[index]['name']}'),
                                    trailing: Icon(Icons.arrow_drop_down),
                                  );
                                },
                              ),
                            );
                          }),
                    );
                  } else {
                    return Center(child: const Text('Server Error'));
                  }
                } else {
                  return Center(
                      child: Text('State: ${snapshot.connectionState}'));
                }
              }),
            )
                : Expanded(
              child: ListView.builder(
                  itemCount: searchData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                      child: OpenContainer(
                        closedColor: Color(0xffd2dfff),
                        openColor: Color(0xffd2dfff),
                        closedElevation: 10.0,
                        openElevation: 10.0,
                        closedShape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10.0)),
                        ),
                        transitionType: ContainerTransitionType.fade,
                        transitionDuration:
                        const Duration(milliseconds: 1200),
                        openBuilder: (context, action) {
                          return TrsMpDetails(searchData[index]);
                        },
                        closedBuilder: (context, action) {
                          return ListTile(
                            dense: true,
                            tileColor: Color(0xffd2dfff),

                            subtitle: Text(
                                "Party: ${searchData[index]['party']}"),
                            // collapsedBackgroundColor: Colors.grey.shade100,
                            // tilePadding: EdgeInsets.all(5),

                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 30,
                              child: ClipOval(
                                child: Image.memory(
                                  base64Decode(searchData[index]
                                  ['content']
                                      .substring(22) ??
                                      ''),
                                  width: 300,
                                  height: 300,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            title: Text('${searchData[index]['name']}'),
                            trailing: Icon(Icons.arrow_drop_down),
                          );
                        },
                      ),
                    );
                  }),
            )
          ]),
        ));
  }

  var partydata;
  Future<dynamic> PartyDataApi(Input) async {
    // await Future.delayed(Duration(seconds: 1));
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({});
    var response = await get(
      Uri.parse(INSIGHTS+'/party/$Input'),
    );

    if (response.statusCode == 200) {
      setState(() {
        partydata = jsonDecode(response.body);
      });
      fullData = partydata;
      print(partydata[0]);
    } else {
      print(response.reasonPhrase);
    }
    return partydata;
  }

  onSearchTextChanged(String text) async {
    searchData.clear();
    if (text.isEmpty) {
      // Check textfield is empty or not
      setState(() {});
      return;
    }

    fullData.forEach((data) {
      if (data['name']
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase().toString())) {
        searchData.add(
            data); // If not empty then add search data into search data list
      }
    });

    setState(() {});
  }
}

SocialInfoCard(String imagepath, String info) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Column(
      children: [
        Container(
          height: 30,
          width: 30,
          child: Image.asset(
            imagepath,
            height: 30,
            width: 30,
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Text(info)
      ],
    ),
  );
}