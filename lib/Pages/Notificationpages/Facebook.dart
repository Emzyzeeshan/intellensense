import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Facebook extends StatefulWidget {
  const Facebook({super.key});

  @override
  State<Facebook> createState() => _FacebookState();
}

class _FacebookState extends State<Facebook> {
  late Future<dynamic> finaldata = FacebookApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      itemCount: Facebookdata.length,
                      itemBuilder: (context, index) {
                        return FacebookNotificationtile(
                            '${Facebookdata[index]['hashTag']}');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ]),
              );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }

  var Facebookdata;
  Future<dynamic> FacebookApi() async {
    // await Future.delayed(Duration(seconds: 1));
    var headers = {'Content-Type': 'application/json'};

    var response = await get(
      Uri.parse(
          'http://192.169.1.211:8081/insights/2.60.0/trendingHashtags?page=0,14&field=FACEBOOK'),
    );

    if (response.statusCode == 200) {
      setState(() {
        Facebookdata = jsonDecode(response.body);
      });

      print(Facebookdata);
    } else {
      print(response.reasonPhrase);
    }
    return Facebookdata;
  }
}

class FacebookNotificationtile extends StatefulWidget {
  String Hashtag;
  FacebookNotificationtile(
    @required this.Hashtag, {
    super.key,
  });

  @override
  State<FacebookNotificationtile> createState() =>
      _FacebookNotificationtileState();
}

class _FacebookNotificationtileState extends State<FacebookNotificationtile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
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
            Image.asset(
              'assets/NotificationIcons/analyticsShowCard.png',
              height: 25,
              width: 25,
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
    );
  }
}
