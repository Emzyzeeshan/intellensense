import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intellensense/main.dart';


import '../../../Constants/constants.dart';
import '../Expansion_components_Notification/YoutubeGridDb.dart';
import '../Expansion_components_Notification/YoutubeHashTagInfo.dart';
import '../Expansion_components_Notification/YoutubePivot.dart';


class Youtube extends StatefulWidget {

  @override
  State<Youtube> createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  TextEditingController textEditingController = new TextEditingController();
  late Future<dynamic> finaldata = YoutubeApi();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
          child: TextField(
            onChanged: onSearchTextChanged,
            controller: textEditingController,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                isDense: true,
                fillColor: TextfieldColor,
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
                    return SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(child: CircularProgressIndicator()),
                            Text('Please Wait')
                          ]),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: Youtubedata['candidate_names'].length,
                          itemBuilder: (context, index) {
                            return YoutubeNotificationtile(
                                Hashtag: '${Youtubedata['candidate_names'][index]}',
                                dashboadTap: YoutubeHashTagInfo(
                                Youtubedata['candidate_names']
                            [index]),
                              GridTap: YoutubeGridDb(
                                  Youtubedata['candidate_names'][index]),
                              PivotTap: YoutubePivot(
                                  Youtubedata['candidate_names'][index]),
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
              )
            : Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchData.length,
                  itemBuilder: (context, index) {
                    return YoutubeNotificationtile(

                        Hashtag:'${searchData[index]['candidate_names']}',
                      dashboadTap: YoutubeHashTagInfo(
                          searchData[index]),
                      GridTap: YoutubeGridDb(
                          searchData[index]),
                      PivotTap: YoutubePivot(
                          searchData[index]),
                    );
                  },
                ),
              ),
      ],
    );
  }

  var Youtubedata;
  Map Selectionquery = new Map<String, dynamic>();
  Future<dynamic> YoutubeApi() async {
    setState(() {
      Selectionquery['type'] = 'candidate_names';
      Selectionquery['channel'] = 'YOUTUBE';
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6656/active_youtube_channel/'),
        body: Selectionquery);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        Youtubedata = json.decode(response.body);
fullData=Youtubedata['candidate_names'];
        print(Youtubedata);
      } catch (e) {
        print(Youtubedata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return Youtubedata;
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
      if (data
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

class YoutubeNotificationtile extends StatefulWidget {
  String Hashtag;
  Widget? dashboadTap;
  Widget? GridTap;
  Widget? PivotTap;
  YoutubeNotificationtile({
    required this.Hashtag, this.dashboadTap,this.GridTap, this.PivotTap});

  @override
  State<YoutubeNotificationtile> createState() =>
      _YoutubeNotificationtileState();
}

class _YoutubeNotificationtileState extends State<YoutubeNotificationtile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ExpansionTile(collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        collapsedBackgroundColor: Color(0xffc8d1e7),
        backgroundColor: Color(0xffbdcade),

        //childrenPadding: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: Image.asset(
          'assets/icons/Social-Media-Icons-IS-10.png',
          height: 25,
          width: 25,
        ),
        title: Text(widget.Hashtag,style: TextStyle(
          height: 0,
          // color: Colors.white,
        )),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OpenContainer(
                closedColor: Color(0xffc8d1e7),
                openColor: Color(0xffc8d1e7),

                //openElevation: 10.0,
                transitionType: ContainerTransitionType.fade,
                transitionDuration: const Duration(milliseconds: 1200),
                openBuilder: (context, action) {
                  return widget.dashboadTap!;
                },
                closedBuilder: (context, action) {
                  return Image.asset(
                    'assets/NotificationIcons/analyticsShowCard-01-removebg-preview.png',
                    height: 20,
                    width: 20,
                  );
                },
              ),
              OpenContainer(
                closedColor: Color(0xffc8d1e7),
                openColor: Color(0xffc8d1e7),

                //openElevation: 10.0,
                transitionType: ContainerTransitionType.fade,
                transitionDuration: const Duration(milliseconds: 1200),
                openBuilder: (context, action) {
                  return widget.GridTap!;
                },
                closedBuilder: (context, action) {
                  return Image.asset(
                    'assets/NotificationIcons/GridDB-04.png',
                    height: 20,
                    width: 20,
                  );
                },
              ),
              Image.asset(
                'assets/NotificationIcons/Open_Docs_Icon-01 (1).png',
                height: 20,
                width: 20,
              ),
              OpenContainer(
                closedColor: Color(0xffc8d1e7),
                openColor: Color(0xffc8d1e7),

                //openElevation: 10.0,
                transitionType: ContainerTransitionType.fade,
                transitionDuration: const Duration(milliseconds: 1200),
                openBuilder: (context, action) {
                  return widget.PivotTap!;
                },
                closedBuilder: (context, action) {
                  return Image.asset(
                    'assets/NotificationIcons/Pivot-Unpivot_Icon-02.png',
                    height: 20,
                    width: 20,
                  );
                },
              ),
              Image.asset(
                'assets/NotificationIcons/Tree-03.png',
                height: 20,
                width: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
