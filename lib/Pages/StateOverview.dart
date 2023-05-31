import 'dart:convert';

import 'package:animated_rail/animated_rail.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intellensense/SpalashScreen/constants.dart';

class StateOverviewScreen extends StatefulWidget {
  const StateOverviewScreen({Key? key}) : super(key: key);

  @override
  State<StateOverviewScreen> createState() => _StateOverviewScreenState();
}

class _StateOverviewScreenState extends State<StateOverviewScreen> {
  final List<String> items = [];
  List fullData = [];
  List searchData = [];
  String? selectedValue = 'TELANGANA';
  final TextEditingController textEditingController = TextEditingController();


  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
late Future<dynamic> finaldata=StateNameApi();
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
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(child: CircularProgressIndicator()),
                          Text('Please Wait')
                        ]);
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
                              .map<DropdownMenuItem<String>>((item) => DropdownMenuItem<String>(
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
                                  .toString().toUpperCase()
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
          ElevatedButton(
              onPressed: () {
                StateNameApi();
                print(selectedValue);
              },
              child: Text('Verify')),
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
      body: AnimatedRail(
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
      ),
    );
  }

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

    setState(() {});
  }
}
