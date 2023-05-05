import 'dart:convert';

import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class LiveUpdatesScreen extends StatefulWidget {
  const LiveUpdatesScreen({Key? key}) : super(key: key);

  @override
  State<LiveUpdatesScreen> createState() => _LiveUpdatesScreenState();
}

class _LiveUpdatesScreenState extends State<LiveUpdatesScreen> {
  var LiveUpdatesListResult = [];
  @override
  void initState() {
    super.initState();
    LiveUpdatesListAPI();
  }

  late Future<dynamic> finaldata = LiveUpdatesListAPI();
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
                          'assets/icons/liveUpdares.png',
                          height: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Live Updates',
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
                            children: [...LiveUpdatesList()],
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

  List<Card> LiveUpdatesList() {
    if (LiveUpdatesListResult.length == 0) return [];
    return LiveUpdatesListResult.map<Card>((Value) => Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(4),
          elevation: 20,
          child: ListTile(
            leading: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(30),
                    child: Image.network(
                      Value['sourceImg'],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey),
                  color: Colors.white,
                )),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    Value['id']['mediaName'] ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
                Text(
                  ' || ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  Value['id']['publishedDate'] ?? '',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            title: Text(
              Value['id']['headLine'] ?? '',
              maxLines: 3,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            onTap: () => launchUrl(Uri.parse(Value['sourceUrl'])),
          ),
        )).toList();
  }

  LiveUpdatesListAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var response = await get(
      Uri.parse(INSIGHTS+ '/livenews?page=0,17'),
      headers: headers,
    );
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      try {
        setState(() => LiveUpdatesListResult =
            jsonDecode(utf8.decode(response.bodyBytes)));
      } catch (e) {
        print(LiveUpdatesListResult);
        LiveUpdatesListResult = [];
      }
    } else {
      print(response.reasonPhrase);
    }
    return LiveUpdatesListResult;
  }
}
