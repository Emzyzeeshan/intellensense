import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  var SurveyListResult = [];
  @override
  void initState() {
    super.initState();
    SuerveyListAPI();
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
                          'assets/icons/surveydxp.png',
                          height: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Survey',
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
                  ...SurveyList()
                ]))))));
  }

  List<Card> SurveyList() {
    if (SurveyListResult.length == 0) return [];
    return SurveyListResult.map<Card>((Value) => Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(6),
          elevation: 20,
          child: ListTile(
            title: Text(
              Value['id']['mediaName'] ?? '',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            subtitle: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  Value['id']['headLine'] ?? '',
                  maxLines: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
            trailing: Text(
              Value['id']['publishedDate'] ?? '',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => launchUrl(Uri.parse(Value['sourceUrl'])),
          ),
        )).toList();
  }

  SuerveyListAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({"page": 0});
    var response = await post(
      Uri.parse('http://192.169.1.211:8081/insights/1.1.0/livenews'),
      headers: headers,
      body: body,
    );
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      try {
        setState(() =>
            SurveyListResult = jsonDecode(utf8.decode(response.bodyBytes)));
      } catch (e) {
        print(SurveyListResult);
        SurveyListResult = [];
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
