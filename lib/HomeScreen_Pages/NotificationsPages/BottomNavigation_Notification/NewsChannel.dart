import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intellensense/main.dart';

import '../../../Constants/constants.dart';
import '../Expansion_components_Notification/NewsChannelGridDb.dart';
import '../Expansion_components_Notification/NewsChannelHashTagInfo.dart';

class NewsChannelPage extends StatefulWidget {
  @override
  State<NewsChannelPage> createState() => _NewsChannelPageState();
}

class _NewsChannelPageState extends State<NewsChannelPage> {
  late Future<dynamic> finaldata = NewsChannelApi();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: onSearchTextChanged,
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
                        child:
                         ListView.builder(
                          itemCount: NewsChanneldata['candidate_names'].length,
                          itemBuilder: (context, index) {
                            return NewsChannelNotificationtile(
                                Hashtag:
                                    '${NewsChanneldata['candidate_names'][index]}',
                                dashboadTap: NewsChannelHashTagInfo(
                                    NewsChanneldata['candidate_names'][index]),
                                GridTap: NewsChannelGridDb(
                                    NewsChanneldata['candidate_names'][index]));
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
                    return NewsChannelNotificationtile(
                        Hashtag: '${searchData[index]}',
                        dashboadTap: NewsChannelHashTagInfo(
                          searchData[index],
                        ),
                        GridTap: NewsChannelGridDb(
                            searchData[index]));
                  },
                ),
              ),
      ],
    );
  }

  var NewsChanneldata;
  Map Selectionquery = new Map<String, dynamic>();
  Future<dynamic> NewsChannelApi() async {
    setState(() {
      Selectionquery['type'] = 'candidate_names';
      Selectionquery['channel'] = 'NEWS_CHANNEL';
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6656/active_youtube_channel/'),
        body: Selectionquery);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        NewsChanneldata = json.decode(response.body);
fullData=NewsChanneldata['candidate_names'];
        print(NewsChanneldata);
      } catch (e) {
        print(NewsChanneldata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return NewsChanneldata;
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

class NewsChannelNotificationtile extends StatefulWidget {
  String Hashtag;
  Widget? dashboadTap;
  Widget? GridTap;
  NewsChannelNotificationtile({
    this.dashboadTap,
    this.GridTap,
    required this.Hashtag,
  });

  @override
  State<NewsChannelNotificationtile> createState() =>
      _NewsChannelNotificationtileState();
}

class _NewsChannelNotificationtileState
    extends State<NewsChannelNotificationtile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ExpansionTile(
        collapsedBackgroundColor:  Color(0xffc8d1e7),
        backgroundColor: Color(0xffc8d1e7),
        childrenPadding: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: Image.asset(
          'assets/new Updated images/news-71.png',
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
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                ),
                transitionType: ContainerTransitionType.fade,
                transitionDuration: const Duration(milliseconds: 1200),
                openBuilder: (context, action) {
                  return widget.dashboadTap!;
                },
                closedBuilder: (context, action) {
                  return Image.asset(
                    'assets/NotificationIcons/analyticsShowCard-01-removebg-preview.png',
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
                    'assets/NotificationIcons/GridDB-04.png',
                    height: 25,
                    width: 25,
                  );
                },
              ),
              Image.asset(
                'assets/NotificationIcons/Open_Docs_Icon-01 (1).png',
                height: 25,
                width: 25,
              ),
              Image.asset(
                'assets/NotificationIcons/Pivot-Unpivot_Icon-02.png',
                height: 25,
                width: 25,
              ),
              Image.asset(
                'assets/NotificationIcons/Tree-03.png',
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
