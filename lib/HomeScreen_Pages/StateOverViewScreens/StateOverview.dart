import 'dart:convert';

import 'package:animated_rail/animated_rail.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
  void initState() {
    statedropdownvisible == true;

    super.initState();

    //TwitterOverViewApi();
    //StateNameApi();
  }

  late Future<dynamic> finaldata = StateNameApi();
  late Future<dynamic> finaldata1 = TwitterOverViewApi();
  late Future<dynamic> TopPartyFinaldata = TopPartylistApi();
  late Future<dynamic> NewsPaperOverviewFutureData = NewspaperOverviewApi();
  late Future<dynamic> Youtubetoppartydata = YoutubeTopPartylistApi();
  late Future<dynamic> Youtubefinaldata = YoutubeOverViewApi();
  late Future<dynamic> newschannelfinaldata = NewsChannelTopPartylistApi();
  late Future<dynamic> NewschannelOverviewfinaldata = NewschannelOverViewApi();
  late Future<dynamic> FaceBookfinaldata = FaceBookOverViewApi();
  late Future<dynamic> FaceBooktoppartydata = FaceBookTopPartylistApi();
  late Future<dynamic> _TopCandidaitevalue=TopCandidatelistApi();
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
                            width: MediaQuery.of(context).size.width,
                            borderRadius: BorderRadius.circular(8),
                            // minLength: MediaQuery.of(context).size.width / 6,
                            // maxLength: MediaQuery.of(context).size.width / 3,
                          )),
                    );
                    ;
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
                              istablevisible = false;
                              isNewsChannelvisible = false;
                              isFacebookvisible = false;
                              _NewspaperOverviewTabledata.clear();
                              statedropdownvisible = false;
                              selectedValue = value as String;
                              YoutubeTopPartylistdata =
                                  YoutubeTopPartylistApi();
                              TopPartyFinaldata = TopPartylistApi();
                              NewsPaperOverviewFutureData =
                                  NewspaperOverviewApi();
                              Youtubetablecolumn.clear();
                              newschannelfinaldata =
                                  NewsChannelTopPartylistApi();
                              NewsChanneltablecolumn.clear();
                              FaceBooktoppartydata = FaceBookTopPartylistApi();
                              FaceBooktablecolumn.clear();
                              isytvisible = false;
                              isnewschannelvisible = false;
                              statedropdownvisible = false;
                              isFaceBookvisible = false;
                              TopCandidatequery.clear();
                              _TopCandidaitevalue=TopCandidatelistApi();
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
      // appBar: AppBar(),
      body: SafeArea(
        child: DefaultTabController(
          length: 5,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
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
                    statedropdownvisible == true
                        ? TwitterOverviewScreen()
                        : SkeletonParagraph(
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
                    ),
                    isytvisible == true
                        ? YoutubeOverviewScreen()
                        : SkeletonParagraph(
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
                    ),
                    Center(
                      child: NewsPaperOverviewScreen(),
                    ),
                    isnewschannelvisible == true
                        ? NewschannelOverviewScreen()
                        : SkeletonParagraph(
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
                    ),
                    isFaceBookvisible == true
                        ? FacebookOverviewScreen()
                        : SkeletonParagraph(
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
    bool isHighestCount = partyData.keys.where((p) => p != party).map((p) {
      print(p);
      return p.toString();
    }).every((p) => (double.parse(partyData[p][0][attribute].toString()) <=
        double.parse(partyData[party][0][attribute].toString()) as bool));
    if (isHighestCount) return TextStyle(color: Colors.green);

    return null;
  }

  TwitterOverviewScreen() {
    return TopPartylistdata['top_parties'].isEmpty
        ? Image.asset('assets/Image/datanotfound.gif')
        : FutureBuilder<dynamic>(
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
                  minLength: MediaQuery.of(context).size.width / 2,
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
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DataTable(
                          headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Color(0xff00196b)),
                          dataRowColor:
                          MaterialStateColor.resolveWith((states) {
                            return Color(0xffd2dfff);
                          }),
                          border: TableBorder.all(color: Colors.black),
                          // Datatable widget that have the property columns and rows.
                          columns: [
                            // Set the name of the column
                            DataColumn(
                              label: Text(
                                'PARTY NAME',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                  TwitterOverviewdata['party_data']
                                  [partyt1][0]
                                  ['CANDIDATE_PARTY_NAME'],
                                  style: TextStyle(color: Colors.white)),
                            ),
                            DataColumn(
                              label: Text(
                                  TwitterOverviewdata['party_data']
                                  [partyt2][0]
                                  ['CANDIDATE_PARTY_NAME'],
                                  style: TextStyle(color: Colors.white)),
                            ),
                            DataColumn(
                              label: Text(
                                  TwitterOverviewdata['party_data']
                                  [partyt3][0]
                                  ['CANDIDATE_PARTY_NAME'],
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                          rows: [
                            // Set the values to the columns

                            DataRow(
                              cells: [
                                DataCell(Text(
                                  "USER FOLLOWERS",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                )),
                                ...TwitterOverviewdata['party_data']
                                    .keys
                                    .map(
                                      (p) => DataCell(Text(
                                      TwitterOverviewdata[
                                      'party_data'][p][0]
                                      ['USER_FOLLOWERS']
                                          .toString(),
                                      style: highestCountStyle(
                                          TwitterOverviewdata[
                                          'party_data'],
                                          p,
                                          'USER_FOLLOWERS'))),
                                )
                              ],
                            ),
                            DataRow(cells: [
                              DataCell(Text(
                                "LIKES",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                              ...TwitterOverviewdata['party_data']
                                  .keys
                                  .map(
                                    (p) => DataCell(Text(
                                    TwitterOverviewdata['party_data']
                                    [p][0]['LIKES']
                                        .toString(),
                                    style: highestCountStyle(
                                        TwitterOverviewdata[
                                        'party_data'],
                                        p,
                                        'LIKES'))),
                              ),
                              /* DataCell(Text(TwitterOverviewdata['party_data']['INC'][0]['LIKES'].toString())),
                                  DataCell(Text(TwitterOverviewdata['party_data']['TRS'][0]['LIKES'].toString())),
                                  DataCell(Text(TwitterOverviewdata['party_data']['BJP'][0]['LIKES'].toString())),*/
                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                "RETWEET COUNT",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                              ...TwitterOverviewdata['party_data']
                                  .keys
                                  .map(
                                    (p) => DataCell(Text(
                                    TwitterOverviewdata['party_data']
                                    [p][0]['RETWEET_COUNT']
                                        .toString(),
                                    style: highestCountStyle(
                                        TwitterOverviewdata[
                                        'party_data'],
                                        p,
                                        'RETWEET_COUNT'))),
                              ),
                              /*DataCell(Text(TwitterOverviewdata['party_data']['INC'][0]['RETWEET_COUNT'].toString())),
                                  DataCell(Text(TwitterOverviewdata['party_data']['TRS'][0]['RETWEET_COUNT'].toString())),
                                  DataCell(Text(TwitterOverviewdata['party_data']['BJP'][0]['RETWEET_COUNT'].toString()),*/
                            ]),
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Color(0xffd2dfff),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                                text:
                                'With Huge Difference In counts for Tweets and Re-Tweets reports says that '),
                            new TextSpan(
                                text: '${TwitterOverviewdata['lead'][0]}',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 25)),
                            new TextSpan(
                                text:
                                ' is relatively Dominant in Twitter Data'),
                          ],
                        ),
                      ),

                      //  Text(
                      //         '""', style: TextStyle(
                      //                   fontFamily: 'Segoe UI',
                      //                   fontSize: 16,
                      //                 ),),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FutureBuilder<dynamic>(
                    future: _TopCandidaitevalue,
                    builder: (
                        BuildContext context,
                        AsyncSnapshot<dynamic> snapshot,
                        ) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return  Text('${snapshot.error}');
                        } else if (snapshot.hasData) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      'TOP CANDIDATES',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 145,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: 4,
                                    itemBuilder: ((context, index) {
                                      return Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  15)),
                                          color: Color(0xffd2dfff),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 130,
                                              width: 110,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceAround,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.person_2,
                                                        size: 17,
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      TopCandidate['top_candidates'][index]['CANDIDATE_NAME'].toString().length>10?Text(

                                                        '${TopCandidate['top_candidates'][index]['CANDIDATE_NAME']}'.substring(0,12),
                                                        style: _textStyle,

                                                      ):
                                                      Text(

                                                        '${TopCandidate['top_candidates'][index]['CANDIDATE_NAME']}',
                                                        style: _textStyle,

                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .person_add_alt_1_rounded,
                                                          size: 17),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        '${TopCandidate['top_candidates'][index]['USER_FOLLOWERS']}',
                                                        style: _textStyle,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .person_pin_rounded,
                                                          size: 17),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        '${TopCandidate['top_candidates'][index]['CANDIDATE_PARTY_NAME']}',
                                                        style: _textStyle,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Count : ${TopCandidate['top_candidates'][index]['COUNT']}',
                                                        style: _textStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                              ),
                            ],
                          );
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    },
                  ),
                  TwitterOverviewdata['lead'][0] == 'INC'
                      ? Image.asset(
                    'assets/new Updated images/twitter_001.gif',
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                  )
                      : Container(),
                ],
              ),
            );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }

  TextStyle _textStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
  bool isytvisible = false;
  bool istablevisible = false;
//Youtube Overview Screen
  YoutubeOverviewScreen() {
    return YoutubeTopPartylistdata['top_parties'].isEmpty
        ? Image.asset('assets/Image/datanotfound.gif')
        : FutureBuilder<dynamic>(
      future: Youtubefinaldata,
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
                  minLength: MediaQuery.of(context).size.width / 2,
                )),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            // for(int i=0;i<TwitterOverviewdata['party_data']['INC'][i];i++){
            //
            // }
            return Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: istablevisible == true
                        ? DataTable(
                        headingRowColor:
                        MaterialStateColor.resolveWith(
                                (states) => Color(0xff00196b)),
                        dataRowColor:
                        MaterialStateColor.resolveWith((states) {
                          return Color(0xffd2dfff);
                        }),
                        border: TableBorder.all(color: Colors.black),
                        // Datatable widget that have the property columns and rows.
                        columns: [
                          // Set the name of the column
                          DataColumn(
                            label: Text(
                              'PARTY NAME',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ...Youtubetablecolumn
                          // DataColumn(
                          //   label: Text(
                          //       YoutubeOverviewdata['party_data'][partyt1][0]
                          //           ['CANDIDATE_PARTY_NAME'],
                          //       style: TextStyle(color: Colors.white)),
                          // ),
                          // DataColumn(
                          //   label: Text(
                          //       YoutubeOverviewdata['party_data'][partyt2][0]
                          //           ['CANDIDATE_PARTY_NAME'],
                          //       style: TextStyle(color: Colors.white)),
                          // ),
                          // DataColumn(
                          //   label: Text(
                          //       YoutubeOverviewdata['party_data'][partyt3][0]
                          //           ['CANDIDATE_PARTY_NAME'],
                          //       style: TextStyle(color: Colors.white)),
                          // ),
                        ],
                        rows: [
                          // Set the values to the columns
                          DataRow(
                            cells: [
                              DataCell(Text(
                                "LIKES",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                              ...YoutubeOverviewdata['party_data']
                                  .keys
                                  .map(
                                    (p) => DataCell(Text(
                                  YoutubeOverviewdata[
                                  'party_data'][p]
                                  [0]['LIKES']
                                      .toString(),
                                  // style: highestCountStyle(
                                  //     YoutubeOverviewdata['party_data'],
                                  //     p,
                                  //     'LIKES')
                                )),
                              )
                            ],
                          ),
                          DataRow(cells: [
                            DataCell(Text(
                              "COMMENTS",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            )),
                            ...YoutubeOverviewdata['party_data']
                                .keys
                                .map(
                                  (p) => DataCell(Text(
                                YoutubeOverviewdata[
                                'party_data'][p][0]
                                ['COMMENTS']
                                    .toString(),
                                // style: highestCountStyle(
                                //     YoutubeOverviewdata['party_data'],
                                //     p,
                                //     'COMMENTS')
                              )),
                            ),
                            /* DataCell(Text(TwitterOverviewdata['party_data']['INC'][0]['LIKES'].toString())),
                                DataCell(Text(TwitterOverviewdata['party_data']['TRS'][0]['LIKES'].toString())),
                                DataCell(Text(TwitterOverviewdata['party_data']['BJP'][0]['LIKES'].toString())),*/
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              "VIEWS",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            )),
                            ...YoutubeOverviewdata['party_data']
                                .keys
                                .map(
                                  (p) => DataCell(Text(
                                YoutubeOverviewdata[
                                'party_data'][p][0]
                                ['VIEWS']
                                    .toString(),
                                // style: highestCountStyle(
                                //     YoutubeOverviewdata['party_data'],
                                //     p,
                                //     'VIEWS')
                              )),
                            ),
                            /*DataCell(Text(TwitterOverviewdata['party_data']['INC'][0]['RETWEET_COUNT'].toString())),
                                DataCell(Text(TwitterOverviewdata['party_data']['TRS'][0]['RETWEET_COUNT'].toString())),
                                DataCell(Text(TwitterOverviewdata['party_data']['BJP'][0]['RETWEET_COUNT'].toString()),*/
                          ]),
                          // DataRow(cells: [
                          //   DataCell(Text(
                          //     "CANDIDATE_PARTY_NAME",
                          //     style: TextStyle(fontWeight: FontWeight.bold),
                          //   )),
                          //   ...YoutubeOverviewdata['party_data'].keys.map(
                          //         (p) => DataCell(Text(
                          //             YoutubeOverviewdata['party_data'][p][0]
                          //                     ['CANDIDATE_PARTY_NAME']
                          //                 .toString(),
                          //             // style: highestCountStyle(
                          //             //     YoutubeOverviewdata['party_data'],
                          //             //     p,
                          //             //     'CANDIDATE_PARTY_NAME')
                          //                 )),
                          //       ),
                          //   /*DataCell(Text(TwitterOverviewdata['party_data']['INC'][0]['RETWEET_COUNT'].toString())),
                          //       DataCell(Text(TwitterOverviewdata['party_data']['TRS'][0]['RETWEET_COUNT'].toString())),
                          //       DataCell(Text(TwitterOverviewdata['party_data']['BJP'][0]['RETWEET_COUNT'].toString()),*/
                          // ]),
                        ])
                        : Container(),
                  ),
                ),
              ],
            );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }

//NewsPaperOverview Screen
  NewsPaperOverviewScreen() {
    return FutureBuilder<dynamic>(
      future: NewsPaperOverviewFutureData,
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
                  minLength: MediaQuery.of(context).size.width / 2,
                )),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            bool isnull = false;
            NewspaperOverviewdata['party_data'] == null
                ? isnull = true
                : isnull = false;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isnull == false
                      ? Column(
                    children: [
                      Table(
                        border: TableBorder.all(),
                        children: [
                          TableRow(children: [
                            Container(
                                height: 30,
                                color: Color(0xff00196b),
                                child: Center(
                                    child: Text(
                                      'PARTY NAME',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))),
                            Container(
                                height: 30,
                                color: Color(0xff00196b),
                                child: Center(
                                    child: Text(
                                      'COUNT',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))),
                          ]),
                          ..._NewspaperOverviewTabledata,
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${NewspaperOverviewdata['party_data'][0]['PARTY_NAME']} is Relatively Dominant ',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Image.asset('assets/Image/celebrate.gif',
                          height: 250, width: 150)
                    ],
                  )
                      : Center(
                    child: Image.asset('assets/Image/datanotfound.gif'),
                  ),
                ),
              ],
            );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }

  bool isNewsChannelvisible = false;
  NewschannelOverviewScreen() {
    return NewsChannelTopPartylistdata['top_parties'].isEmpty
        ? Image.asset('assets/Image/datanotfound.gif')
        : FutureBuilder<dynamic>(
      future: NewschannelOverviewfinaldata,
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
                  minLength: MediaQuery.of(context).size.width / 2,
                )),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            // for(int i=0;i<TwitterOverviewdata['party_data']['INC'][i];i++){
            //
            // }
            return Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isNewsChannelvisible == true
                        ? DataTable(
                        headingRowColor:
                        MaterialStateColor.resolveWith(
                                (states) => Color(0xff00196b)),
                        dataRowColor:
                        MaterialStateColor.resolveWith((states) {
                          return Color(0xffd2dfff);
                        }),
                        border: TableBorder.all(color: Colors.black),
                        // Datatable widget that have the property columns and rows.
                        columns: [
                          // Set the name of the column
                          DataColumn(
                            label: Text(
                              'PARTY NAME',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ...NewsChanneltablecolumn
                          // DataColumn(
                          //   label: Text(
                          //       YoutubeOverviewdata['party_data'][partyt1][0]
                          //           ['CANDIDATE_PARTY_NAME'],
                          //       style: TextStyle(color: Colors.white)),
                          // ),
                          // DataColumn(
                          //   label: Text(
                          //       YoutubeOverviewdata['party_data'][partyt2][0]
                          //           ['CANDIDATE_PARTY_NAME'],
                          //       style: TextStyle(color: Colors.white)),
                          // ),
                          // DataColumn(
                          //   label: Text(
                          //       YoutubeOverviewdata['party_data'][partyt3][0]
                          //           ['CANDIDATE_PARTY_NAME'],
                          //       style: TextStyle(color: Colors.white)),
                          // ),
                        ],
                        rows: [
                          // Set the values to the columns
                          DataRow(
                            cells: [
                              DataCell(Text(
                                "LIKES",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                              ...NewschannelOverviewdata[
                              'party_data']
                                  .keys
                                  .map(
                                    (p) => DataCell(Text(
                                    NewschannelOverviewdata[
                                    'party_data'][p]
                                    [0]['LIKES']
                                        .toString(),
                                    style: highestCountStyle(
                                        NewschannelOverviewdata[
                                        'party_data'],
                                        p,
                                        'LIKES'))),
                              )
                            ],
                          ),
                          DataRow(cells: [
                            DataCell(Text(
                              "COMMENTS",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            )),
                            ...NewschannelOverviewdata['party_data']
                                .keys
                                .map(
                                  (p) => DataCell(Text(
                                  NewschannelOverviewdata[
                                  'party_data'][p]
                                  [0]['COMMENTS']
                                      .toString(),
                                  style: highestCountStyle(
                                      NewschannelOverviewdata[
                                      'party_data'],
                                      p,
                                      'COMMENTS'))),
                            ),
                            /* DataCell(Text(TwitterOverviewdata['party_data']['INC'][0]['LIKES'].toString())),
                                DataCell(Text(TwitterOverviewdata['party_data']['TRS'][0]['LIKES'].toString())),
                                DataCell(Text(TwitterOverviewdata['party_data']['BJP'][0]['LIKES'].toString())),*/
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              "VIEWS",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            )),
                            ...NewschannelOverviewdata['party_data']
                                .keys
                                .map(
                                  (p) => DataCell(Text(
                                  NewschannelOverviewdata[
                                  'party_data'][p]
                                  [0]['VIEWS']
                                      .toString(),
                                  style: highestCountStyle(
                                      NewschannelOverviewdata[
                                      'party_data'],
                                      p,
                                      'VIEWS'))),
                            ),
                            /*DataCell(Text(TwitterOverviewdata['party_data']['INC'][0]['RETWEET_COUNT'].toString())),
                                DataCell(Text(TwitterOverviewdata['party_data']['TRS'][0]['RETWEET_COUNT'].toString())),
                                DataCell(Text(TwitterOverviewdata['party_data']['BJP'][0]['RETWEET_COUNT'].toString()),*/
                          ]),
                          // DataRow(cells: [
                          //   DataCell(Text(
                          //     "CANDIDATE_PARTY_NAME",
                          //     style: TextStyle(fontWeight: FontWeight.bold),
                          //   )),
                          //   ...YoutubeOverviewdata['party_data'].keys.map(
                          //         (p) => DataCell(Text(
                          //             YoutubeOverviewdata['party_data'][p][0]
                          //                     ['CANDIDATE_PARTY_NAME']
                          //                 .toString(),
                          //             // style: highestCountStyle(
                          //             //     YoutubeOverviewdata['party_data'],
                          //             //     p,
                          //             //     'CANDIDATE_PARTY_NAME')
                          //                 )),
                          //       ),
                          //   /*DataCell(Text(TwitterOverviewdata['party_data']['INC'][0]['RETWEET_COUNT'].toString())),
                          //       DataCell(Text(TwitterOverviewdata['party_data']['TRS'][0]['RETWEET_COUNT'].toString())),
                          //       DataCell(Text(TwitterOverviewdata['party_data']['BJP'][0]['RETWEET_COUNT'].toString()),*/
                          // ]),
                        ])
                        : Container(),
                  ),
                ),
              ],
            );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }

//FaceBook Overview Screen
  bool isFacebookvisible = false;
  FacebookOverviewScreen() {
    return FaceBookTopPartylistdata['top_parties'].isEmpty
        ? Image.asset('assets/Image/datanotfound.gif')
        : FutureBuilder<dynamic>(
      future: FaceBookfinaldata,
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
                  minLength: MediaQuery.of(context).size.width / 2,
                )),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            // for(int i=0;i<TwitterOverviewdata['party_data']['INC'][i];i++){
            //
            // }
            return Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isFacebookvisible == true
                        ? DataTable(
                        headingRowColor:
                        MaterialStateColor.resolveWith(
                                (states) => Color(0xff00196b)),
                        dataRowColor:
                        MaterialStateColor.resolveWith((states) {
                          return Color(0xffd2dfff);
                        }),
                        border: TableBorder.all(color: Colors.black),
                        // Datatable widget that have the property columns and rows.
                        columns: [
                          // Set the name of the column
                          DataColumn(
                            label: Text(
                              'PARTY NAME',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ...FaceBooktablecolumn
                          // DataColumn(
                          //   label: Text(
                          //       YoutubeOverviewdata['party_data'][partyt1][0]
                          //           ['CANDIDATE_PARTY_NAME'],
                          //       style: TextStyle(color: Colors.white)),
                          // ),
                          // DataColumn(
                          //   label: Text(
                          //       YoutubeOverviewdata['party_data'][partyt2][0]
                          //           ['CANDIDATE_PARTY_NAME'],
                          //       style: TextStyle(color: Colors.white)),
                          // ),
                          // DataColumn(
                          //   label: Text(
                          //       YoutubeOverviewdata['party_data'][partyt3][0]
                          //           ['CANDIDATE_PARTY_NAME'],
                          //       style: TextStyle(color: Colors.white)),
                          // ),
                        ],
                        rows: [
                          // Set the values to the columns
                          DataRow(
                            cells: [
                              DataCell(Text(
                                "LIKES",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                              ...FaceBookOverviewdata['party_data']
                                  .keys
                                  .map(
                                    (p) => DataCell(Text(
                                  FaceBookOverviewdata[
                                  'party_data'][p]
                                  [0]['LIKES']
                                      .toString(),
                                  // style: highestCountStyle(
                                  //     YoutubeOverviewdata['party_data'],
                                  //     p,
                                  //     'LIKES')
                                )),
                              )
                            ],
                          ),
                          DataRow(cells: [
                            DataCell(Text(
                              "COMMENTS",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            )),
                            ...FaceBookOverviewdata['party_data']
                                .keys
                                .map(
                                  (p) => DataCell(Text(
                                FaceBookOverviewdata[
                                'party_data'][p][0]
                                ['COMMENTS']
                                    .toString(),
                                // style: highestCountStyle(
                                //     YoutubeOverviewdata['party_data'],
                                //     p,
                                //     'COMMENTS')
                              )),
                            ),
                            /* DataCell(Text(TwitterOverviewdata['party_data']['INC'][0]['LIKES'].toString())),
                                DataCell(Text(TwitterOverviewdata['party_data']['TRS'][0]['LIKES'].toString())),
                                DataCell(Text(TwitterOverviewdata['party_data']['BJP'][0]['LIKES'].toString())),*/
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              "SHARES",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            )),
                            ...FaceBookOverviewdata['party_data']
                                .keys
                                .map(
                                  (p) => DataCell(Text(
                                FaceBookOverviewdata[
                                'party_data'][p][0]
                                ['SHARES']
                                    .toString(),
                                // style: highestCountStyle(
                                //     YoutubeOverviewdata['party_data'],
                                //     p,
                                //     'VIEWS')
                              )),
                            ),
                            /*DataCell(Text(TwitterOverviewdata['party_data']['INC'][0]['RETWEET_COUNT'].toString())),
                                DataCell(Text(TwitterOverviewdata['party_data']['TRS'][0]['RETWEET_COUNT'].toString())),
                                DataCell(Text(TwitterOverviewdata['party_data']['BJP'][0]['RETWEET_COUNT'].toString()),*/
                          ]),
                          // DataRow(cells: [
                          //   DataCell(Text(
                          //     "CANDIDATE_PARTY_NAME",
                          //     style: TextStyle(fontWeight: FontWeight.bold),
                          //   )),
                          //   ...YoutubeOverviewdata['party_data'].keys.map(
                          //         (p) => DataCell(Text(
                          //             YoutubeOverviewdata['party_data'][p][0]
                          //                     ['CANDIDATE_PARTY_NAME']
                          //                 .toString(),
                          //             // style: highestCountStyle(
                          //             //     YoutubeOverviewdata['party_data'],
                          //             //     p,
                          //             //     'CANDIDATE_PARTY_NAME')
                          //                 )),
                          //       ),
                          //   /*DataCell(Text(TwitterOverviewdata['party_data']['INC'][0]['RETWEET_COUNT'].toString())),
                          //       DataCell(Text(TwitterOverviewdata['party_data']['TRS'][0]['RETWEET_COUNT'].toString())),
                          //       DataCell(Text(TwitterOverviewdata['party_data']['BJP'][0]['RETWEET_COUNT'].toString()),*/
                          // ]),
                        ])
                        : Container(),
                  ),
                ),
              ],
            );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
  ///          API CALLS    / //////////////////////////////////

  ///twitteroverviewData API
  var TwitterOverviewdata;
  Map Selectionquery1 = new Map<String, dynamic>();
  Future<dynamic> TwitterOverViewApi() async {
    setState(() {
      Selectionquery1['type'] = 'party_data';
      Selectionquery1['STATE'] = selectedValue;
      Selectionquery1['party_list'] =
      '${TopPartylistdata['top_parties'].join(",")}';
      //Selectionquery['channel'] = 'YOUTUBE';
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media/'),
        body: Selectionquery1);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        TwitterOverviewdata = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          statedropdownvisible = true;
        });

        print(TwitterOverviewdata);
      } catch (e) {
        print(TwitterOverviewdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return TwitterOverviewdata;
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
          isLoaded = true;
          TopPartyFinaldata = TopPartylistApi();
          Youtubetoppartydata = YoutubeTopPartylistApi();
          newschannelfinaldata = NewsChannelTopPartylistApi();
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

//Twitter top party list
  var statedropdownvisible = false;
//top party list api
  String? partyt1;
  String? partyt2;
  String? partyt3;

  var TopPartylistdata;
  Map TopPartylistquery = new Map<String, dynamic>();
  Future<dynamic> TopPartylistApi() async {
    setState(() {
      TopPartylistquery['type'] = 'top_parties';
      TopPartylistquery['STATE'] = selectedValue.toString();
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media/'),
        body: TopPartylistquery);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        setState(() {
          TopPartylistdata = jsonDecode(utf8.decode(response.bodyBytes));
          partyt1 = TopPartylistdata['top_parties'][0] ?? '';
          partyt2 = TopPartylistdata['top_parties'][1] ?? '';
          partyt3 = TopPartylistdata['top_parties'][2] ?? '';
          finaldata1 = TwitterOverViewApi();
        });

        print(partyt1);
        print(partyt2);
        print(partyt3);
        print(selectedValue.toString());
        print(TopPartylistdata);
      } catch (e) {
        print(TopPartylistdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return TopPartylistdata;
  }

//Youtube top party list api
  var YoutubeTopPartylistdata;
  var locallist = [];
  List<DataColumn> Youtubetablecolumn = [];
  Future<dynamic> YoutubeTopPartylistApi() async {
    print('YT top');
    var body = json.encode({
      "type": "top_parties",
      "STATE": selectedValue.toString(),
      "social_handle": "YOUTUBE"
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_YT/'),
        headers: headers,
        body: body);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        setState(() {
          YoutubeTopPartylistdata = jsonDecode(utf8.decode(response.bodyBytes));
          locallist = YoutubeTopPartylistdata['top_parties'];
          Youtubefinaldata = YoutubeOverViewApi();
          isytvisible = true;
        });
        print(locallist.toList());
      } catch (e) {
        print(YoutubeTopPartylistdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return YoutubeTopPartylistdata;
  }

//Youtube Overview data api
  var YoutubeOverviewdata;
  Future<dynamic> YoutubeOverViewApi() async {
    // String partylist=locallist.join(",");

    var body = json.encode({
      "type": "party_data",
      "STATE": selectedValue.toString(),
      "party_list": "${YoutubeTopPartylistdata['top_parties'].join(",")}",
      "social_handle": "YOUTUBE"
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_YT/'),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      try {
        YoutubeOverviewdata = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          istablevisible = true;
          statedropdownvisible = true;
          for (int i = 0;
          i < YoutubeTopPartylistdata['top_parties'].length;
          i++) {
            Youtubetablecolumn.add(
              DataColumn(
                label: Text(
                  '${YoutubeTopPartylistdata['top_parties'][i]}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        });
      } catch (e) {
        print(YoutubeOverviewdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return YoutubeOverviewdata;
  }

  //Newspaper overview api
  var NewspaperOverviewdata;
  List<TableRow> _NewspaperOverviewTabledata = [];
  Map NewspaperOverviewquery = new Map<String, dynamic>();
  Future<dynamic> NewspaperOverviewApi() async {
    setState(() {
      NewspaperOverviewquery['type'] = 'top_parties';
      NewspaperOverviewquery['STATE'] = selectedValue.toString();
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_NP/'),
        body: NewspaperOverviewquery);

    if (response.statusCode == 200) {
      try {
        NewspaperOverviewdata = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0; i < NewspaperOverviewdata['party_data'].length; i++) {
          _NewspaperOverviewTabledata.add(TableRow(children: [
            Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    '${NewspaperOverviewdata['party_data'][i]['PARTY_NAME']}',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                )),
            Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    '${NewspaperOverviewdata['party_data'][i]['COUNT']}',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                )),
          ]));
        }
      } catch (e) {
        print(NewspaperOverviewdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return NewspaperOverviewdata;
  }

//NewsChannel top party list api
  var NewsChannelTopPartylistdata;
  var NewsChannellocallist = [];
  List<DataColumn> NewsChanneltablecolumn = [];
  Future<dynamic> NewsChannelTopPartylistApi() async {
    print('YT top');
    var body = json.encode({
      "type": "top_parties",
      "STATE": selectedValue.toString(),
      "social_handle": "NEWS_CHANNEL"
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_YT/'),
        headers: headers,
        body: body);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        setState(() {
          NewsChannelTopPartylistdata =
              jsonDecode(utf8.decode(response.bodyBytes));
          NewsChannellocallist = NewsChannelTopPartylistdata['top_parties'];
          NewschannelOverviewfinaldata = NewschannelOverViewApi();
          isnewschannelvisible = true;
        });
        print('newschannel top party list');
        print(NewsChannellocallist.toList());
      } catch (e) {
        print(NewsChannelTopPartylistdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return NewsChannelTopPartylistdata;
  }

//Newschannel Overview data api
  bool isnewschannelvisible = false;
  var NewschannelOverviewdata;
  Future<dynamic> NewschannelOverViewApi() async {
    print('list heree');
    String partylist = NewsChannellocallist.join(",");
    print(partylist);

    var body = json.encode({
      "type": "party_data",
      "STATE": selectedValue.toString(),
      "party_list": "$partylist",
      "social_handle": "NEWS_CHANNEL"
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_YT/'),
        headers: headers,
        body: body);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        NewschannelOverviewdata = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          isNewsChannelvisible = true;
          statedropdownvisible = true;
          for (int i = 0;
          i < NewsChannelTopPartylistdata['top_parties'].length;
          i++) {
            NewsChanneltablecolumn.add(
              DataColumn(
                label: Text(
                  '${NewsChannelTopPartylistdata['top_parties'][i]}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        });
        print('its Newschannel party data');
        print(partylist);
        print(NewschannelOverviewdata);
      } catch (e) {
        print(NewschannelOverviewdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return NewschannelOverviewdata;
  }

//FaceBook top party list api
  var FaceBookTopPartylistdata;
  var FaceBooklocallist = [];
  List<DataColumn> FaceBooktablecolumn = [];
  Future<dynamic> FaceBookTopPartylistApi() async {
    print('FaceBook top');
    var body = json.encode({
      "type": "top_parties",
      "STATE": selectedValue.toString(),
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_FB/'),
        headers: headers,
        body: body);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        setState(() {
          FaceBookTopPartylistdata =
              jsonDecode(utf8.decode(response.bodyBytes));
          FaceBooklocallist = FaceBookTopPartylistdata['top_parties'];
          // Youtubefinaldata=YoutubeOverViewApi();
          isFaceBookvisible = true;
          FaceBookfinaldata = FaceBookOverViewApi();
        });
        print(locallist.toList());
      } catch (e) {
        print(FaceBookTopPartylistdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return FaceBookTopPartylistdata;
  }

//FaceBook Overview data api
  var FaceBookOverviewdata;
  bool isFaceBookvisible = false;
  Future<dynamic> FaceBookOverViewApi() async {
    // String partylist=locallist.join(",");

    var body = json.encode({
      "type": "party_data",
      "STATE": selectedValue.toString(),
      "party_list": "${FaceBookTopPartylistdata['top_parties'].join(",")}",
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_FB/'),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      try {
        FaceBookOverviewdata = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          isFacebookvisible = true;
          statedropdownvisible = true;
          for (int i = 0;
          i < FaceBookTopPartylistdata['top_parties'].length;
          i++) {
            FaceBooktablecolumn.add(
              DataColumn(
                label: Text(
                  '${FaceBookTopPartylistdata['top_parties'][i]}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        });
      } catch (e) {
        print(FaceBookOverviewdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return FaceBookOverviewdata;
  }

  //TopCandidate List
  var TopCandidate;
  Map TopCandidatequery = new Map<String, dynamic>();
  Future<dynamic> TopCandidatelistApi() async {
    print('API INIT');

    TopCandidatequery['type'] = 'top_candidates';
    TopCandidatequery['STATE'] = selectedValue.toString();




    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media/'),

        body: TopCandidatequery);

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('Its top party details');
      try {
        setState(() {
          TopCandidate = jsonDecode(utf8.decode(response.bodyBytes));
        });


      } catch (e) {
        print(TopCandidate);
      }
    } else {
      print(response.reasonPhrase);
    }
    return TopCandidate;
  }
}