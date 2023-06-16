import 'dart:convert';

import 'package:animated_rail/animated_rail.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intellensense/Constants/constants.dart';
import 'package:skeletons/skeletons.dart';

class StateOverviewScreen extends StatefulWidget {
  const StateOverviewScreen({Key? key}) : super(key: key);

  @override
  State<StateOverviewScreen> createState() => _StateOverviewScreenState();
}

class _StateOverviewScreenState extends State<StateOverviewScreen> {
  final List<String> items = [];
  List fullData = [];
  List fullData1 = [];
  List searchData = [];
  String? selectedValue = 'TELANGANA';
  final TextEditingController textEditingController = TextEditingController();
bool isLoaded = false;
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
  @override
  void initState(){
    super.initState();
    StateNameApi();
    //TwitterOverViewApi();
    //StateNameApi();
  }

  late Future<dynamic> finaldata = StateNameApi();
  late Future<dynamic> finaldata1 = TwitterOverViewApi();
  Widget _buildTest(String title) {
    return Container(
      //color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<dynamic>(
                future: finaldata,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<dynamic> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 1,

                          lineStyle: SkeletonLineStyle(

                            height: 30,
                            width:  MediaQuery.of(context).size.width,
                            borderRadius: BorderRadius.circular(8),
                            // minLength: MediaQuery.of(context).size.width / 6,
                            // maxLength: MediaQuery.of(context).size.width / 3,
                          )),
                    );;
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Select Item',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: StateNamedata['state_names']!
                              .map<DropdownMenuItem<String>>(
                                  (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                              .toList(),

                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value as String;
                              finaldata1 = TwitterOverViewApi();
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                            ),
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: textEditingController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Search for an item...',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return (item.value
                                  .toString()
                                  .toUpperCase()
                                  .contains(searchValue.toUpperCase()));
                            },
                          ),
                          //This to clear the search value when you close the menu
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              textEditingController.clear();
                            }
                          },
                        ),
                      );
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              )),
         /* ElevatedButton(
              onPressed: () {
                //StateNameApi();
                print(selectedValue);
              },
              child: Text('Search')),*/
        ],
      ),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeColor,
      appBar: AppBar(),
      body: SafeArea(
        child: DefaultTabController(
          length: 5,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                backgroundColor: Colors.blue.shade100,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: TextStyle(color: Colors.black),
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    icon: Image.asset(
                      'assets/icons/Social-Media-Icons-IS-08.png',
                      height: 20,
                    ),
                    text: "Twitter",
                  ),
                  Tab(
                    icon: Image.asset(
                      'assets/icons/Social-Media-Icons-IS-10.png',
                      height: 20,
                    ),
                    text: "YouTube",
                  ),
                  Tab(
                    icon: Image.asset(
                      'assets/new Updated images/intellisensesolutions-Icons-83.png',
                      height: 20,
                    ),
                    text: "NewsPaper",
                  ),
                  Tab(
                    icon: Image.asset(
                      'assets/new Updated images/news-71.png',
                      height: 20,
                    ),
                    text: "NewsChannel",
                  ),
                  Tab(
                    icon: Image.asset(
                      'assets/icons/Social-Media-Icons-IS-06.png',
                      height: 20,
                    ),
                    text: "FaceBook",
                  ),
                ],
              ),
              _buildTest('Twitter'),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Center(child: TwitterOverviewScreen()),
                    Center(
                      child: Icon(Icons.directions_transit),
                    ),
                    Center(
                      child: Icon(Icons.directions_bike),
                    ),
                    Center(
                      child: Icon(Icons.directions_car),
                    ),
                    Center(
                      child: Icon(Icons.directions_transit),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      /*AnimatedRail(
        cursorSize: Size(60, 60),
        //background: hexToColor('#8B77DD'),
        maxWidth: 275,
        width: 100,
        railTileConfig: RailTileConfig(
          iconSize: 30,
          iconColor: Colors.black,
          expandedTextStyle: TextStyle(fontSize: 20),
          collapsedTextStyle: TextStyle(fontSize: 12),
          activeColor: Colors.purple,
          iconBackground: Colors.white,
        ),
        items: [
          RailItem(
              icon: Image.asset(
                'assets/icons/Social-Media-Icons-IS-08.png',
                height: 30,
              ),
              label: "Twitter",
              screen: _buildTest('Twitter')),
          RailItem(
              icon: Image.asset(
                'assets/icons/Social-Media-Icons-IS-10.png',
                height: 30,
              ),
              label: 'Youtube',
              screen: _buildTest('Youtube')),
          RailItem(
              icon: Image.asset(
                'assets/new Updated images/intellisensesolutions-Icons-83.png',
                height: 30,
              ),
              label: "NewsPaper",
              screen: _buildTest('NewsPaper')),
          RailItem(
              icon: Image.asset(
                'assets/new Updated images/news-71.png',
                height: 30,
              ),
              label: 'NewsChannel',
              screen: _buildTest('NewsChannel')),
          RailItem(
              icon: Image.asset(
                'assets/icons/Social-Media-Icons-IS-06.png',
                height: 30,
              ),
              label: 'FaceBook',
              screen: _buildTest('FaceBook')),
        ],
      ),*/
    );
  }

  // TwitterOverviewdata['party_data']['INC'][0]['USER_FOLLOWERS']
  highestCountStyle(Map partyData, String party, String attribute) {
    print(partyData.toString());
    bool isHighestCount = partyData.keys
        .where((p)=>p!=party).map((p){print(p); return p.toString();})
        .every((p)=>(double.parse(partyData[p][0][attribute].toString()) <= double.parse(partyData[party][0][attribute].toString())as bool));
    if (isHighestCount) return TextStyle(color: Colors.green);

    return null;
  }

  TwitterOverviewScreen() {
    return Scaffold(
        body:   isLoaded==true?
        FutureBuilder<dynamic>(
          future: finaldata1,
          builder: (
              BuildContext context,
              AsyncSnapshot<dynamic> snapshot,
              ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 5,
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 20,
                      borderRadius: BorderRadius.circular(8),
                      minLength:
                      MediaQuery.of(context).size.width / 2,
                    )),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {

                // for(int i=0;i<TwitterOverviewdata['party_data']['INC'][i];i++){
                //
                // }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DataTable(
                        headingRowColor:
                        MaterialStateColor.resolveWith((states) => Color(0xff00196b)),
                      dataRowColor: MaterialStateColor.resolveWith((states) { return
                        Color(0xffd2dfff);
                      }),
                        border: TableBorder.all(color:Colors.black ),
                        // Datatable widget that have the property columns and rows.
                        columns: [
                          // Set the name of the column
                          DataColumn(
                            label: Text('CANDIDATE PARTY NAME',style: TextStyle(color: Colors.white),),
                          ),
                          DataColumn(
                            label: Text(TwitterOverviewdata['party_data']['INC'][0]['CANDIDATE_PARTY_NAME'],style: TextStyle(color: Colors.white)),
                          ),
                          DataColumn(
                            label: Text(TwitterOverviewdata['party_data']['TRS'][0]['CANDIDATE_PARTY_NAME'],style: TextStyle(color: Colors.white)),
                          ),
                          DataColumn(
                            label: Text(TwitterOverviewdata['party_data']['BJP'][0]['CANDIDATE_PARTY_NAME'],style: TextStyle(color: Colors.white)),
                          ),
                        ],
                        rows: [
                          // Set the values to the columns

                          DataRow(cells: [
                            DataCell(Text("USER FOLLOWERS",style: TextStyle(fontWeight: FontWeight.bold),)),
                            ...TwitterOverviewdata['party_data'].keys.map((p)=>DataCell(Text(TwitterOverviewdata['party_data'][p][0]['USER_FOLLOWERS'].toString(), style: highestCountStyle(TwitterOverviewdata['party_data'],p,'USER_FOLLOWERS'))),)
                          ],),
                          DataRow(cells: [
                            DataCell(Text("LIKES",style: TextStyle(fontWeight: FontWeight.bold),)),
                            ...TwitterOverviewdata['party_data'].keys.map((p)=>DataCell(Text(TwitterOverviewdata['party_data'][p][0]['LIKES'].toString(), style: highestCountStyle(TwitterOverviewdata['party_data'],p,'LIKES'))),),
                           /* DataCell(Text(TwitterOverviewdata['party_data']['INC'][0]['LIKES'].toString())),
                            DataCell(Text(TwitterOverviewdata['party_data']['TRS'][0]['LIKES'].toString())),
                            DataCell(Text(TwitterOverviewdata['party_data']['BJP'][0]['LIKES'].toString())),*/
                          ]),
                          DataRow(cells: [
                            DataCell(Text("RETWEET COUNT",style: TextStyle(fontWeight: FontWeight.bold),)),
                            ...TwitterOverviewdata['party_data'].keys.map((p)=>DataCell(Text(TwitterOverviewdata['party_data'][p][0]['RETWEET_COUNT'].toString(), style: highestCountStyle(TwitterOverviewdata['party_data'],p,'RETWEET_COUNT'))),),
                            /*DataCell(Text(TwitterOverviewdata['party_data']['INC'][0]['RETWEET_COUNT'].toString())),
                            DataCell(Text(TwitterOverviewdata['party_data']['TRS'][0]['RETWEET_COUNT'].toString())),
                            DataCell(Text(TwitterOverviewdata['party_data']['BJP'][0]['RETWEET_COUNT'].toString()),*/


                          ]),
                        ]),
                  ),
                );
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ):Container()
        );
  }
  ///twitteroverviewData API
  var TwitterOverviewdata;
  Map Selectionquery1 = new Map<String, dynamic>();
  Future<dynamic> TwitterOverViewApi() async {
    setState(() {
      Selectionquery1['type'] = 'party_data';
      Selectionquery1['STATE'] = selectedValue;
      Selectionquery1['party_list'] = 'INC,TRS,BJP';
      //Selectionquery['channel'] = 'YOUTUBE';
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media/'),
        body: Selectionquery1);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        TwitterOverviewdata = jsonDecode(utf8.decode(response.bodyBytes));
        fullData1 = TwitterOverviewdata['party_data'];

        print(TwitterOverviewdata);
      } catch (e) {
        print(TwitterOverviewdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return TwitterOverviewdata;
  }

  onSearchTextChanged1(String text) async {
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
  }

  ///Statenames API
  var StateNamedata;
  Map Selectionquery = new Map<String, dynamic>();
  Future<dynamic> StateNameApi() async {
    setState(() {
      Selectionquery['type'] = 'state_names';
      //Selectionquery['channel'] = 'YOUTUBE';
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/view/'),
        body: Selectionquery);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        StateNamedata = jsonDecode(utf8.decode(response.bodyBytes));
        fullData = StateNamedata['state_names'];

        setState(() {
             isLoaded=true;
        });
        print(StateNamedata);
      } catch (e) {
        print(StateNamedata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return StateNamedata;
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
  }
}
