import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intellensense/SpalashScreen/constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:xml2json/xml2json.dart';

class ConstituencyAnalysis extends StatefulWidget {
  const ConstituencyAnalysis({super.key});

  @override
  State<ConstituencyAnalysis> createState() => _ConstituencyAnalysisState();
}

class _ConstituencyAnalysisState extends State<ConstituencyAnalysis> {
  final myTransformer = Xml2Json();
  TextEditingController editingController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); //
  var duplicateItems = <String>[];
  var items = <String>[];
  List fullData = <String>[];
  List searchData = <String>[];
  late Future<dynamic> finaldata = ConstituencyAnalysiAPI();
  late Future<dynamic> finaldata2 =
      ConstituencyAnalysisDataDetailsAPI('ACHAMPET');
  var xmldata;
  var Details;
  var jsondata;
  @override
  void initState() {
    map['constituency'] = 'ACHAMPET';

    super.initState();
  }

  var map = new Map<String, dynamic>();

  void filterSearchResults(String query) {
    setState(() {
      items = duplicateItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.grey.shade700,
          icon: Icon(Icons.search),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        centerTitle: true,
        backgroundColor: Color(0xffd2dfff),
        title: Image.asset(
          'assets/icons/IntelliSense-Logo-Finall.gif',
          fit: BoxFit.cover,
          height: 40,
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xffd2dfff),
        child: Column(
          children: [
            Image.asset(
              'assets/icons/IntelliSense-Logo-Finall.gif',
              fit: BoxFit.cover,
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: 7,
                right: 7,
              ),
              child: TextField(
                onChanged: onSearchTextChanged,
                controller: editingController,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search_rounded),
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
                              shrinkWrap: true,
                              itemCount: fullData.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        finaldata2 =
                                            ConstituencyAnalysisDataDetailsAPI(
                                                fullData[index].toString());
                                      });

                                      print(fullData[index]);
                                    },
                                    tileColor: Colors.white,
                                    leading: Icon(Icons.location_on_sharp),
                                    title:
                                        Text('${fullData[index]}'.toString()),
                                  ),
                                );
                              },
                            ),
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
                : Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchData.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                finaldata2 = ConstituencyAnalysisDataDetailsAPI(
                                    searchData[index].toString());
                              });

                              print(searchData[index]);
                            },
                            tileColor: Colors.white,
                            title: Text('${searchData[index]}'.toString()),
                            trailing: Text('Sample'),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  var ConstituencyAnalysisData;
  ConstituencyAnalysiAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var response = await get(
      Uri.parse('http://idxp.pilogcloud.com:6652/constituency_names/'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      try {
        ConstituencyAnalysisData = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          fullData = ConstituencyAnalysisData['ASSEMBLY_CONSTITUENCY'];
        });

        print(fullData);
      } catch (e) {}
    } else {
      print(response.reasonPhrase);
    }
    return ConstituencyAnalysisData;
  }

  var ConstituencyAnalysisDataDetailsData;

  ConstituencyAnalysisDataDetailsAPI(String parameter) async {
    setState(() {
      map['constituency'] = parameter;
    });

    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6652/constituency_analysis/'),
        body: map);

    if (response.statusCode == 200) {
      try {
        ConstituencyAnalysisDataDetailsData =
            jsonDecode(utf8.decode(response.bodyBytes));
      } catch (e) {}
    } else {
      print(response.reasonPhrase);
    }
    return ConstituencyAnalysisDataDetailsData;
  }

  onSearchTextChanged(String text) async {
    searchData.clear();
    if (text.isEmpty) {
// Check textfield is empty or not
      setState(() {});
      return;
    }

    fullData.forEach((data) {
      if (data
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
