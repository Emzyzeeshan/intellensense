import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube/youtube.dart';
import 'package:youtube/youtube_thumbnail.dart';

import '../main.dart';

class YouTubeScreen extends StatefulWidget {
  const YouTubeScreen({Key? key}) : super(key: key);

  @override
  State<YouTubeScreen> createState() => _YouTubeScreenState();
}

class _YouTubeScreenState extends State<YouTubeScreen> {
  var YouTubeListResult = [];
  @override
  void initState() {
    super.initState();
    YouTubeListAPI();
  }

  late Future<dynamic> finaldata = YouTubeListAPI();
  String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

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
                          'assets/icons/Social-Media-Icons-IS-10.png',
                          height: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'YouTube',
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
                            children: [...YouTubeList()],
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

  List<Card> YouTubeList() {
    if (YouTubeListResult.length == 0) return [];
    return YouTubeListResult.map<Card>((Value) => Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(4),
          elevation: 20,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    Value['mediaChannelName'] ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Text(
                    Value['publishedDate'] ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              ListTile(
                leading: GestureDetector(
                  onTap: () {
                    AlertDialog alert = AlertDialog(
                      title: Image.network(
                        YoutubeThumbnail(
                                youtubeId:
                                    convertUrlToId(Value['sourceUrl']) ?? '')
                            .hd() as String,
                        width: 300,
                        height: 300,
                        fit: BoxFit.fill,
                      ),
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          YoutubeThumbnail(
                                  youtubeId:
                                      convertUrlToId(Value['sourceUrl']) ?? '')
                              .hd() as String,
                          width: 300,
                          height: 300,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                subtitle: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      Value['videoTitle'] ?? '',
                      maxLines: 3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
                onTap: () {
                  
                  launchUrl(Uri.parse(Value['sourceUrl']));
                 
                  },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/Video ViewsEmoji.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        Value['videoViews'] ?? '',
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
                        'assets/icons/Video LikesEmoji.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        Value['videoLikes'] ?? '',
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
                        Value['videoCommentsCount'] ?? '',
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
                        'assets/icons/Sentiment-Icon.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Sentiment',
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        )).toList();
  }

  YouTubeListAPI() async {
    var headers = {'Content-Type': 'application/json'};

    var response = await get(
      Uri.parse(INSIGHTS + '/youtube-news/partyName/TDP?page=0,15'),
      headers: headers,
    );
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      try {
        setState(() =>
            YouTubeListResult = jsonDecode(utf8.decode(response.bodyBytes)));
      } catch (e) {
        print(YouTubeListResult);
        YouTubeListResult = [];
      }
    } else {
      print(response.reasonPhrase);
    }
    return YouTubeListResult;
  }
}
