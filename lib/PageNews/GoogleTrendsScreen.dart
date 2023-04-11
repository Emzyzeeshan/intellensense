import 'dart:convert';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
    //NewsPaperAllAPI();
  }
  late Future<dynamic> finaldata = GoogleTrendsListAPI();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8),
        child:  Card(
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
                          /*Container(
              color: Colors.blue,
            ),*/
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
                          /*Tooltip(
                              message: 'Pin Card',
                              child: CupertinoButton(
                                minSize: double.minPositive,
                                padding: EdgeInsets.zero,
                                child: Icon(Icons.pin_invoke,
                                    color: Color.fromRGBO(58, 129, 233, 1),
                                    size: 30),
                                onPressed: () {},
                              )),*/
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
                         /* Tooltip(
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
                              )),*/
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
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top:70.0),
                                    child: Center(child: CircularProgressIndicator()),
                                  );
                                } else if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return const Text('Data Error');
                                  } else if (snapshot.hasData) {
                                    return Column(children: [...GoogleTrendsList()],);
                                  } else {
                                    return const Text('Server Error');
                                  }
                                } else {
                                  return Text(
                                      'State: ${snapshot.connectionState}');
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
            /*leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          child: ClipOval(
            child: Image.memory(
              base64Decode(Value['content'].substring(22) ?? ''),
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
          ),
        ),*/
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Value['partyName'] ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                Row(
                  children: [
                    Icon(Icons.search,color: Colors.blue,),
                    Text(
                      Value['id']['saerchCount'].toString() ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
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
                  Value['id']['candidateName'] ?? '',
                  maxLines: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                /*Row(
              children: [
                Row(
                  children: [
                    Image.asset('assets/icons/Video ViewsEmoji.png',height: 20,width: 20,),
                    SizedBox(width: 10,),
                    //IconButton(onPressed: () {}, icon: ImageIcon(AssetImage('assets/icons/Video ViewsEmoji.png')),),
                    Text(Value['videoViews'] ?? '',style: TextStyle(fontSize: 14),)
                  ],
                ),
                SizedBox(width: 10,),
                Row(
                  children: [
                    Image.asset('assets/icons/Video LikesEmoji.png',height: 20,width: 20,),
                    SizedBox(width: 10,),
                    //IconButton(onPressed: () {}, icon: ImageIcon(AssetImage('assets/icons/Video LikesEmoji.png')),),
                    Text(Value['videoLikes'] ?? '',style: TextStyle(fontSize: 14),)
                  ],
                ),
                SizedBox(width: 10,),
                Row(
                  children: [
                    Image.asset('assets/icons/Video DislikesEmoji.png',height: 20,width: 20,),
                    SizedBox(width: 10,),
                    //IconButton(onPressed: () {}, icon: ImageIcon(AssetImage('assets/icons/Video DislikesEmoji.png')),),
                    Text(Value['videoDislikes'] ?? '',style: TextStyle(fontSize: 14),)
                  ],
                ),
                SizedBox(width: 10,),
                Row(
                  children: [
                    Image.asset('assets/icons/Video CommentsEmoji.png',height: 20,width: 20,),
                    SizedBox(width: 10,),
                    //IconButton(onPressed: () {}, icon: ImageIcon(AssetImage('assets/icons/Video CommentsEmoji.png')),),
                    Text(Value['videoCommentsCount'] ?? '',style: TextStyle(fontSize: 14),)
                  ],
                ),
                SizedBox(width: 10,),
                //IconButton(onPressed: (){}, icon: Icon(Icons.comment))
                */
              ],
            ),
            trailing: Text(
              DateFormat.yMd().format(DateTime.fromMillisecondsSinceEpoch((Value['id']['editDate']?? '')))
              /*DateTime.fromMillisecondsSinceEpoch((Value['id']['editDate']?? '')).toString()*/
             /* Value['id']['editDate'].toString()?? '',*/
              //style: TextStyle(fontSize: 16),
            ),
            onTap: () => launchUrl(Uri.parse(Value['sourceUrl'])),
            /*onTap: (){
          print(Value);
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrsMpDetails(Value)));
        },*/
          ),
        )).toList();
  }

  GoogleTrendsListAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var response = await get(
      Uri.parse(
          'http://192.169.1.211:8081/insights/2.60.0/googleTrends?page=0,13'),
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