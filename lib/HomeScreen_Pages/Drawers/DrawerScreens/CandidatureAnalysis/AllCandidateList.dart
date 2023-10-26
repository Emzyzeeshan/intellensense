import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:intellensense/HomeScreen_Pages/Drawers/DrawerScreens/CandidatureAnalysis/Candidature%20Analysis/PartyMemberDetails.dart';
import 'package:intellensense/main.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
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
  bool changeview = false;

  /// Each time to start a speech recognition session

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 35),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom:5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios)),

                  Spacer(),
                Row(
                  children: [
                    Text('CANDIDATE ANALYTICS',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                    Image.asset(
                      'assets/new Updated images/AppIcon.gif',
                      fit: BoxFit.contain,
                      height: 45,

                    ),
                  ],
                ),
                Spacer(),
                  IconButton(
                  onPressed: () {
                    setState(() {
                      changeview = !changeview;
                    });
                  },
                  icon: changeview
                      ? Icon(Icons.list_alt_outlined)
                      : Icon(Icons.grid_on_rounded),
                  iconSize: 27,
                ),
                ],),
            ),
            Row(
              children: [
                // Image.asset('assets/icons/IntelliSense-Logo-Finall.gif',
                //     height: 35,width: 35,),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search....',
                        hintStyle: TextStyle(color: Colors.black),
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
                          return changeview ? Gridview() : Listview();
                        } else {
                          return Center(child: const Text('Server Error'));
                        }
                      } else {
                        return Center(
                            child: Text('State: ${snapshot.connectionState}'));
                      }
                    }),
                  )
                : changeview
                    ? SearchGridview()
                    : Searchlistview()
          ]),
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
          .contains(text.toLowerCase().toString())||data['constitution']
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase().toString())||data['politicalType']
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase().toString())||data['party']
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
    } else if (DataType[index]['party'] == 'YSRCP') {
      partycolor = Colors.blue.shade500;
    } else {
      partycolor = Colors.cyan[50];
    }
  }

//List view
  Listview() {
    return Expanded(
      child: ListView.builder(
          itemCount: Resultdata.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:  EdgeInsets.only(bottom: 5),
              child: OpenContainer(
                closedColor: Color(0xffd2dfff),
                openColor: Color(0xffd2dfff),
                closedElevation: 10.0,
                openElevation: 10.0,
                closedShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                transitionType: ContainerTransitionType.fade,
                transitionDuration: const Duration(milliseconds: 1200),
                openBuilder: (context, action) {
                  return
                      //  Container();
                      TrsMpDetails(Resultdata[index]);
                },
                closedBuilder: (context, action) {
                  PartytileColor(index, Resultdata);
                
                  return ListTile(
                    dense: true,
                    tileColor: partycolor,

                    subtitle: Text("Party: ${Resultdata[index]['party']}"),
                    // collapsedBackgroundColor: Colors.grey.shade100,
                    // tilePadding: EdgeInsets.all(5),

                    leading: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                        minRadius: 30,
                        backgroundImage: MemoryImage(
                            base64Decode(
                                Resultdata[index]['content'].substring(22) ??
                                    ''),
                            scale: 10),
                      ),
                    ),
                    title: Text('${Resultdata[index]['name']}'),
                    trailing: Icon(Icons.arrow_drop_down),
                  );
                },
              ),
            );
          }),
    );
  }

//Gridview

  Gridview() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 6.0, // spacing between rows
          crossAxisSpacing: 6.0, // spacing between columns
        ),
        padding: EdgeInsets.all(6.0), // padding around the grid
        itemCount: Resultdata.length, // total number of items
        itemBuilder: (context, index) {
          return OpenContainer(
            // closedColor:Color(0xffd2dfff) ,

            openColor: Color(0xffd2dfff),
            closedElevation: 0.0,
            openElevation: 10.0,
            closedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            transitionType: ContainerTransitionType.fade,
            transitionDuration: const Duration(milliseconds: 1200),
            openBuilder: (context, action) {
              return
                  // Container();

                  TrsMpDetails(Resultdata[index]);
            },
            closedBuilder: (context, action) {
              PartytileColor(index, Resultdata);
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: partycolor,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: Image.memory(
                                base64Decode(Resultdata[index]['content']
                                        .substring(22) ??
                                    ''),
                                width: 300,
                                height: 300,
                                fit: BoxFit.fill,filterQuality: FilterQuality.high,isAntiAlias: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${Resultdata[index]['name']}',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(" ${Resultdata[index]['party']}",
                                  style: TextStyle(fontSize: 10)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );

            },
          );
        },
      ),
    );
  }

//Search grid view
  SearchGridview() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of items in each row
          mainAxisSpacing: 6.0, // spacing between rows
          crossAxisSpacing: 6.0, // spacing between columns
        ),
        padding: EdgeInsets.all(6.0), // padding around the grid
        itemCount: searchData.length, // total number of items
        itemBuilder: (context, index) {
          return OpenContainer(
            // closedColor:Color(0xffd2dfff) ,

            openColor: Color(0xffd2dfff),
            closedElevation: 0.0,
            openElevation: 10.0,
            closedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            transitionType: ContainerTransitionType.fade,
            transitionDuration: const Duration(milliseconds: 1200),
            openBuilder: (context, action) {
              return
                  // Container();

                  TrsMpDetails(searchData[index]);
            },
            closedBuilder: (context, action) {
              PartytileColor(index, searchData);
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: partycolor,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(17),
                              child: Image.memory(
                                base64Decode(searchData[index]['content']
                                        .substring(22) ??
                                    ''),
                                width: 300,
                                height: 300,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${searchData[index]['name']}',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(" ${searchData[index]['party']}",
                                  style: TextStyle(fontSize: 10)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  //Search List view
  Searchlistview() {
    return Expanded(
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
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                transitionType: ContainerTransitionType.fade,
                transitionDuration: const Duration(milliseconds: 1200),
                openBuilder: (context, action) {
                  return
                      // Container();

                      TrsMpDetails(searchData[index]);
                },
                closedBuilder: (context, action) {
                  return ListTile(
                    dense: true,
                    tileColor: partycolor,

                    subtitle: Text("Party: ${searchData[index]['party']}"),
                    // collapsedBackgroundColor: Colors.grey.shade100,
                    // tilePadding: EdgeInsets.all(5),

                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 30,
                      child: ClipOval(
                        child: Image.memory(
                          base64Decode(
                              searchData[index]['content'].substring(22) ?? ''),
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
    );
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