import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intellensense/main.dart';


import '../../main.dart';
import 'Components/NewsPaperGridDb.dart';
import 'Components/NewspaperHashTagInfo.dart';

class Facebook extends StatefulWidget {

  @override
  State<Facebook> createState() => _FacebookState();
}

class _FacebookState extends State<Facebook> {
  late Future<dynamic> finaldata = FacebookApi();

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
                    itemCount: Facebookdata['active_facebook_hashtags'].length,
                    itemBuilder: (context, index) {
                      return NewspaperNotificationtile(
                          Hashtag:'${Facebookdata['active_facebook_hashtags'][index]}',
                          dashboadTap: NewspaperHashTagInfo(
                              Facebookdata['active_facebook_hashtags']
                          ),
                          GridTap: NewsPaperGridDb(
                              Facebookdata['active_facebook_hashtags']
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

  var Facebookdata;
  Map Selectionquery = new Map<String, dynamic>();
  Future<dynamic> FacebookApi() async {
    setState(() {
      Selectionquery['type'] = 'active_tags';
      //Selectionquery['channel'] = 'YOUTUBE';
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6656/active_facebook_channel/'),
        body: Selectionquery);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        Facebookdata = json.decode(response.body);
        fullData=Facebookdata['active_facebook_hashtags'];

        print(Facebookdata);
      } catch (e) {
        print(Facebookdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return Facebookdata;
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
          'assets/icons/fb.png',
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
