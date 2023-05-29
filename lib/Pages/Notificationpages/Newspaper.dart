import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intellensense/main.dart';


import '../../main.dart';
import 'Components/NewsPaperGridDb.dart';
import 'Components/NewspaperHashTagInfo.dart';

class Newspaper extends StatefulWidget {

  @override
  State<Newspaper> createState() => _NewspaperState();
}

class _NewspaperState extends State<Newspaper> {
  late Future<dynamic> finaldata = NewspaperApi();
  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
            TextField(
              onChanged: onSearchTextChanged,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        isDense: true,
                        fillColor: Colors.blue.shade100,
                        filled: true,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        prefixIcon: Container(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.search_rounded),
                          width: 18,
                        )),
                  ),
                   SizedBox(
          height: 10,
        ),
          searchData.length ==
                0 // Check SearchData list is empty or not if empty then show full data else show search data
            ? FutureBuilder<dynamic>(
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
                  return Flexible(
                    child: ListView.builder(
                      itemCount: Newspaperdata['candidate_names'].length,
                      itemBuilder: (context, index) {
                        return NewspaperNotificationtile(
                            Hashtag:'${Newspaperdata['candidate_names'][index]}',
                          dashboadTap: NewspaperHashTagInfo(
                              Newspaperdata['candidate_names']
                              [index]),
                          GridTap: NewsPaperGridDb(
                              Newspaperdata['candidate_names']
                              [index]
                          )
                        );
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
          ) : Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchData.length,
                  itemBuilder: (context, index) {
                    return NewspaperNotificationtile(
                        Hashtag:'${searchData[index]}',
                      dashboadTap: NewspaperHashTagInfo(
                        searchData[index],
                      ),
                        GridTap: NewsPaperGridDb(
                            searchData[index]
                        )
                    );
                  },
                ),
              ),
        ],
      );
    
  }

  var Newspaperdata;
  Map Selectionquery = new Map<String, dynamic>();
  Future<dynamic> NewspaperApi() async {
    setState(() {
      Selectionquery['type'] = 'candidate_names';
      //Selectionquery['channel'] = 'YOUTUBE';
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6656/active_news_channel/'),
        body: Selectionquery);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        Newspaperdata = json.decode(utf8.decode(response.bodyBytes));

        print(Newspaperdata);
      } catch (e) {
        print(Newspaperdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return Newspaperdata;
  }

   List searchData = [];
  List fullData = [];
  onSearchTextChanged(String text) async {
    searchData.clear();
    if (text.isEmpty) {
      // Check textfield is empty or not
      setState(() {});
      return;
    }

    fullData.forEach((data) {
      if (data['candidate_names']
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase().toString())) {
        searchData.add(
            data); // If not empty then add search data into search data list
      }
    });
    print(searchData.length);
    setState(() {});
  }
}

class NewspaperNotificationtile extends StatefulWidget {
  String Hashtag;
  Widget? dashboadTap;
  Widget? GridTap;
  NewspaperNotificationtile({
      this.dashboadTap,
    required this.Hashtag,this.GridTap });

  @override
  State<NewspaperNotificationtile> createState() =>
      _NewspaperNotificationtileState();
}

class _NewspaperNotificationtileState extends State<NewspaperNotificationtile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.grey.shade200,
        backgroundColor: Colors.grey.shade100,
        childrenPadding: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: Image.asset(
          'assets/new Updated images/intellisensesolutions-Icons-83.png',
          height: 25,
          width: 25,
        ),
        title: Text(widget.Hashtag),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OpenContainer(
                closedColor: Color(0xffd2dfff),
                openColor: Color(0xffd2dfff),
                openElevation: 10.0,
                closedShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                transitionType: ContainerTransitionType.fade,
                transitionDuration: const Duration(milliseconds: 1200),
                openBuilder: (context, action) {
                  return widget.dashboadTap!;
                },
                closedBuilder: (context, action) {
                  return Image.asset(
                    'assets/NotificationIcons/analyticsShowCard.png',
                    height: 25,
                    width: 25,
                  );
                },
              ),
              OpenContainer(
                closedColor: Color(0xffd2dfff),
                openColor: Color(0xffd2dfff),
                openElevation: 10.0,
                closedShape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                ),
                transitionType: ContainerTransitionType.fade,
                transitionDuration: const Duration(milliseconds: 1200),
                openBuilder: (context, action) {
                  return widget.GridTap!;
                },
                closedBuilder: (context, action) {
                  return Image.asset(
                    'assets/NotificationIcons/GridDB.png',
                    height: 25,
                    width: 25,
                  );
                },
              ),
              Image.asset(
                'assets/NotificationIcons/Open_Docs_Icon.png',
                height: 25,
                width: 25,
              ),
              Image.asset(
                'assets/NotificationIcons/Pivot-Unpivot_Icon.png',
                height: 25,
                width: 25,
              ),
              Image.asset(
                'assets/NotificationIcons/Tree.png',
                height: 25,
                width: 25,
              ),
            ],
          )
        ],
      ),
    );
  }
}
