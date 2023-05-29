import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class GoogleTrendsScreen extends StatefulWidget {
  const GoogleTrendsScreen({Key? key}) : super(key: key);

  @override
  State<GoogleTrendsScreen> createState() => _GoogleTrendsScreenState();
}

class _GoogleTrendsScreenState extends State<GoogleTrendsScreen> {
  var NewsPaperListResult = [];
  @override
  void initState() {
    super.initState();
    GoogleTrendsListAPI();
  }

  late Future<dynamic> finaldata = GoogleTrendsListAPI();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
          color: Colors.grey[300],
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
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
                        'assets/icons/googleTrends1.png',
                        height: 19,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Trends',
                        style: TextStyle(fontSize: 18),
                      ),
                      Spacer(),
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
                          children: [...GoogleTrendsList()],
                        );
                      } else {
                        return const Text('Server Error');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  }),
                ),
                //...NewsPaperList()
              ]))))),
    );
  }

  List<Card> GoogleTrendsList() {
    if (NewsPaperListResult.length == 0) return [];
    return NewsPaperListResult.map<Card>((Value) => Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.all(4),
          elevation: 20,
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Value['partyName'] ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    Text(
                      Value['id']['saerchCount'].toString() ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Value['candidateName'] ?? '',
                  maxLines: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
            trailing: Text(

                    (

                        Value['editDate'][2].toString() +"/"+ Value['editDate'][1].toString()+ "/"+Value['editDate'][0].toString())??''),
            onTap: () => launchUrl(Uri.parse(Value['sourceUrl'])),
          ),
        )).toList();
  }

  GoogleTrendsListAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var response = await get(
      Uri.parse(
          INSIGHTS+'/googleTrends?page=0,13'),
      headers: headers,
    );
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      try {
        setState(() =>
            NewsPaperListResult = jsonDecode(utf8.decode(response.bodyBytes)));
      } catch (e) {
        print(NewsPaperListResult);
        NewsPaperListResult = [];
      }
    } else {
      print(response.reasonPhrase);
    }
    return NewsPaperListResult;
  }
}
