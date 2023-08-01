import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:intellensense/HomeScreen_Pages/Drawers/DrawerScreens/CandidatureAnalysis/Candidature%20Analysis/PartyMemberDetails.dart';
import 'package:intellensense/HomeScreen_Pages/Drawers/DrawerScreens/CandidatureAnalysis/CandidatureAnalysis.dart';
import 'package:intellensense/main.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AllCandidateList extends StatefulWidget {
  const AllCandidateList({Key? key}) : super(key: key);

  @override
  State<AllCandidateList> createState() => _AllCandidateListState();
}

class _AllCandidateListState extends State<AllCandidateList> {
  List searchData = [];
  late Future<dynamic> finaldata = AllCandidateListAPI();
  TextEditingController textEditingController = TextEditingController();

  var partycolor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 35),
          child: Column(children: [
            Row(
              children: [
                // Image.asset('assets/icons/IntelliSense-Logo-Finall.gif',
                //     height: 35,width: 35,),
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
                SizedBox(
                  width: 10,
                ),
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
                  activeBgColors: [
                    [Colors.green],
                    [Colors.black26]
                  ],
                  animate:
                      true, // with just animate set to true, default curve = Curves.easeIn
                  curve: Curves
                      .bounceInOut, // animate must be set to true when using custom curve
                  onToggle: (index) {
                    if (index == 0) {
                      pageController.jumpToPage(0);
                    } else if (index == 1) {
                      pageController.jumpToPage(1);
                    }
                    print('switched to: $index');
                  },
                ),
              ],
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
                                itemCount: Resultdata.length,
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
                                        return
                                            //  Container();
                                            TrsMpDetails(
                                                Resultdata[index]);
                                      },
                                      closedBuilder: (context, action) {
                                        PartytileColor(index, Resultdata);
                                        // if(Resultdata[index]['party']=='TRS'){

                                        //     partycolor=Color(0xfff57ec6);

                                        // }else if(Resultdata[index]['party']=='AIMIM'){

                                        // partycolor=Color.fromARGB(255, 13, 71, 15);
                                        // }else if(Resultdata[index]['party']=='AIFB'){

                                        //     partycolor=Colors.redAccent;

                                        // }else if(Resultdata[index]['party']=='INC'){

                                        //     partycolor=Color.fromARGB(255, 112, 169, 113);

                                        // }else if(Resultdata[index]['party']=='TDP'){

                                        //     partycolor=Colors.yellow;

                                        // }else if(Resultdata[index]['party']=='BJP'){

                                        //     partycolor=Colors.orangeAccent;

                                        // }
                                        return ListTile(
                                          dense: true,
                                          tileColor: partycolor,

                                          subtitle: Text(
                                              "Party: ${Resultdata[index]['party']}"),
                                          // collapsedBackgroundColor: Colors.grey.shade100,
                                          // tilePadding: EdgeInsets.all(5),

                                          leading: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle),
                                            height: 50,
                                            width: 50,
                                            child: CircleAvatar(
                                              minRadius: 30,
                                              backgroundImage: MemoryImage(
                                                  base64Decode(Resultdata[index]
                                                              ['content']
                                                          .substring(22) ??
                                                      ''),
                                                  scale: 10),
                                            ),
                                          ),
                                          title: Text(
                                              '${Resultdata[index]['name']}'),
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
                          
                             PartytileColor(index, searchData);
                          
                         
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
                                return
                                    // Container();

                                    TrsMpDetails(searchData[index]);
                              },
                              closedBuilder: (context, action) {
                                return ListTile(
                                  dense: true,
                                  tileColor: partycolor,

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
        ),
        CandidatureAnalysis()
      ],
    ));
  }

  onSearchTextChanged(String text) async {
    searchData.clear();
    if (text.isEmpty) {
      // Check textfield is empty or not
      setState(() {});
      return;
    }

    Resultdata.forEach((data) {
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

  var Resultdata;
  Future<dynamic> AllCandidateListAPI() async {
    var response = await get(
      Uri.parse(INSIGHTS + '/getallcandidates'),
    );
    print(response.toString());
    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        Resultdata = jsonDecode(utf8.decode(response.bodyBytes));

        print(Resultdata);
      } catch (e) {
        print(Resultdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return Resultdata;
  }

  PartytileColor(index, DataType) {
    if (DataType[index]['party'] == 'TRS') {
      partycolor = Color(0xfff57ec6);
    } else if (DataType[index]['party'] == 'AIMIM') {
      partycolor = Color.fromARGB(255, 13, 71, 15);
    } else if (DataType[index]['party'] == 'AIFB') {
      partycolor = Colors.redAccent;
    } else if (DataType[index]['party'] == 'INC') {
      partycolor = Color.fromARGB(255, 112, 169, 113);
    } else if (DataType[index]['party'] == 'TDP') {
      partycolor = Colors.yellow;
    } else if (DataType[index]['party'] == 'BJP') {
      partycolor = Colors.orangeAccent;
    } else if (DataType[index]['party'] == 'JSP') {
      partycolor = Colors.red;
    } else if (DataType[index]['party'] == 'SHIV SENA') {
      partycolor = Colors.deepOrangeAccent;
    }  else if (DataType[index]['party'] == 'YSRCP') {
      partycolor = Colors.blue.shade500;
    } else {
      partycolor = Colors.cyan[50];
    }
  }
}
