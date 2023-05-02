import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class FaceBookScreen extends StatefulWidget {
  const FaceBookScreen({Key? key}) : super(key: key);

  @override
  State<FaceBookScreen> createState() => _FaceBookScreenState();
}

class _FaceBookScreenState extends State<FaceBookScreen> {
  var FacebookListResult = [];
  @override
  void initState() {
    super.initState();
    FacebookListAPI();
  }

  late Future<dynamic> finaldata = FacebookListAPI();
  @override
  Widget build(BuildContext context) {
    FlipCardController _controller = FlipCardController();
    return Padding(
        padding: EdgeInsets.all(8),
        child: Card(
            color: Colors.grey[300],
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.blueAccent, width: 2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )),
            child: Padding(
                padding: EdgeInsets.all(6),
                child: Card(
                    child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                  Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/icons/Social-Media-Icons-IS-06.png',
                          height: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'FaceBook',
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Tooltip(
                            message: 'Pin Card',
                            child: CupertinoButton(
                              minSize: double.minPositive,
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.pin_invoke,
                                  color: Color.fromRGBO(58, 129, 233, 1),
                                  size: 30),
                              onPressed: () {},
                            )),
                        Tooltip(
                            message: 'Refresh',
                            child: CupertinoButton(
                              minSize: double.minPositive,
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.refresh,
                                  color: Color.fromRGBO(58, 129, 233, 1),
                                  size: 30),
                              onPressed: () {},
                            )),
                        Tooltip(
                            message: 'Card Sort',
                            child: CupertinoButton(
                              minSize: double.minPositive,
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.sort,
                                  color: Color.fromRGBO(58, 129, 233, 1),
                                  size: 30),
                              onPressed: () {},
                            )),
                        Tooltip(
                            message: 'Calender',
                            child: CupertinoButton(
                              minSize: double.minPositive,
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.calendar_today,
                                  color: Color.fromRGBO(58, 129, 233, 1),
                                  size: 30),
                              onPressed: () {},
                            )),
                        Tooltip(
                            message: 'Multi-Filter',
                            child: CupertinoButton(
                              minSize: double.minPositive,
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.filter_alt_outlined,
                                  color: Color.fromRGBO(58, 129, 233, 1),
                                  size: 30),
                              onPressed: () {},
                            )),
                        Tooltip(
                            message: 'More',
                            child: CupertinoButton(
                              minSize: double.minPositive,
                              padding: EdgeInsets.zero,
                              child: Icon(Icons.more_vert,
                                  color: Color.fromRGBO(58, 129, 233, 1),
                                  size: 30),
                              onPressed: () {},
                            )),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 4,
                    color: Colors.grey,
                  ),
                  FutureBuilder(
                    future: finaldata,
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Data Error');
                        } else if (snapshot.hasData) {
                          return Column(
                            children: [...FacebookList()],
                          );
                        } else {
                          return const Text('Server Error');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    }),
                  ),
                ]))))));
  }

  FixContainer() {
    return Container();
  }

  List<Card> FacebookList() {
    if (FacebookListResult.length == 0) return [];
    return FacebookListResult.map<Card>((Value) => Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(4),
          elevation: 20,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    Value['candidateName'] ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 13),
                  ),
                ),
                Text(
                  Value['publishedDate'] ?? '',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  Value['titleContent'] ?? '',
                  textAlign: TextAlign.left,
                  maxLines: 3,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/LikesEmoji.png',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          Value['likesCount'].toString() ?? '',
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/Video CommentsEmoji.png',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          Value['commentsCount'].toString() ?? '',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/SharesEmoji.png',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          Value['shareCount'].toString() ?? '',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            onTap: () => launchUrl(Uri.parse(Value['urlsAttached'])),
          ),
        )).toList();
  }

  FacebookListAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var response = await get(
      Uri.parse(
          'http://192.169.1.211:8081/insights/2.89.0/facebookAnalysis?page=0,12'),
      headers: headers,
    );
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      try {
        setState(() =>
            FacebookListResult = jsonDecode(utf8.decode(response.bodyBytes)));
      } catch (e) {
        print(FacebookListResult);
        FacebookListResult = [];
      }
    } else {
      print(response.reasonPhrase);
    }
    return FacebookListResult;
  }
}
