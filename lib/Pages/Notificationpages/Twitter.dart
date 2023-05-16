import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intellensense/Pages/Notificationpages/Components/hashtagInfo.dart';
import 'package:intellensense/main.dart';

class Twitter extends StatefulWidget {
  const Twitter({super.key});

  @override
  State<Twitter> createState() => _TwitterState();
}

class _TwitterState extends State<Twitter> {
  late Future<dynamic> finaldata = TwitterApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd2dfff),
      body: FutureBuilder<dynamic>(
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  TextField(
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
                  Flexible(
                    child: ListView.builder(
                      itemCount: twitterdata['active_twitter_hashtags'].length,
                      itemBuilder: (context, index) {
                        return TwittterNotificationtile(
                          Hashtag:
                              '${twitterdata['active_twitter_hashtags'][index]}',
                          dashboadTap: HashTagInfo(
                              twitterdata['active_twitter_hashtags'][index]),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ]),
              );
            } else {
              return Center(child: const Text('Issue With API'));
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }

  var twitterdata;
  Future<dynamic> TwitterApi() async {
    // await Future.delayed(Duration(seconds: 1));
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({});

    var response = await post(
      Uri.parse('http://idxp.pilogcloud.com:6656/active_twitter_hashtags/'),
    );

    if (response.statusCode == 200) {
      setState(() {
        twitterdata = json.decode(response.body);
      });

      print(twitterdata);
    } else {
      print(response.reasonPhrase);
    }
    return twitterdata;
  }
}

class TwittterNotificationtile extends StatefulWidget {
  String? Hashtag;
  Widget? dashboadTap;
  TwittterNotificationtile({
    this.dashboadTap,
    @required this.Hashtag,
    super.key,
  });

  @override
  State<TwittterNotificationtile> createState() =>
      _TwittterNotificationtileState();
}

class _TwittterNotificationtileState extends State<TwittterNotificationtile> {
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
          'assets/icons/Social-Media-Icons-IS-08.png',
          height: 25,
          width: 25,
        ),
        title: Text(widget.Hashtag!),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OpenContainer(
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
              Image.asset(
                'assets/NotificationIcons/GridDB.png',
                height: 25,
                width: 25,
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
