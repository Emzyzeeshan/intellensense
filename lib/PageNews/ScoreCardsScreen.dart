import 'dart:convert';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class ScoreCardsScreen extends StatefulWidget {
  const ScoreCardsScreen({Key? key}) : super(key: key);

  @override
  State<ScoreCardsScreen> createState() => _ScoreCardsScreenState();
}

class _ScoreCardsScreenState extends State<ScoreCardsScreen> {
  var NewsPaperListResult = [];
  @override
  void initState() {
    super.initState();
    NewsPaperListAPI();
    //NewsPaperAllAPI();
  }

  @override
  Widget build(BuildContext context) {
    FlipCardController _controller = FlipCardController();
    final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(''),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: ExpansionTileCard(
              baseColor: Colors.cyan[50],
              expandedColor: Colors.white,
              key: cardA,
              leading: CircleAvatar(backgroundColor: Colors.grey),
              title: Text("A V S S AMARNATH GUDIVADA"),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text('Follow')),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(onPressed: () {}, child: Text('Message'))
                    ],
                  )
                ],
              ),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Table(
                        defaultColumnWidth: FixedColumnWidth(130.0),
                        border: TableBorder.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                            width: 2),
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment: TableCellVerticalAlignment.top,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    'Social Media',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(''),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(''),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(''),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(''),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(''),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(''),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment: TableCellVerticalAlignment.top,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    'Rank',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('55'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('64'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('87'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('109'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('28'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('17'),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment: TableCellVerticalAlignment.top,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    'Based on rank',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(''),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(''),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(''),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(''),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(''),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(''),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    Row(
                      children: [
                        Text('Analytics'),
                        SizedBox(
                          width: 50,
                        ),
                        Image.asset(
                          'assets/icons/Social-Media-Icons-IS-01.png',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/icons/Social-Media-Icons-IS-02.png',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/icons/Social-Media-Icons-IS-03.png',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/icons/Social-Media-Icons-IS-04.png',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/icons/Social-Media-Icons-IS-05.png',
                          height: 20,
                          width: 20,
                        ),
                      ],
                    )
                    /*MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      onPressed: () {
                        cardA.currentState?.expand();
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.arrow_downward),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Open'),
                        ],
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      onPressed: () {
                        cardA.currentState?.collapse();
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.arrow_upward),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Close'),
                        ],
                      ),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      onPressed: () {
                      },
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.swap_vert),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Toggle'),
                        ],
                      ),
                    ),*/
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FixContainer() {
    return Container();
  }

  List<Card> NewsPaperList() {
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
              Value['id']['publishedDate'] ?? '',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => launchUrl(Uri.parse(Value['sourceUrl'])),
            /*onTap: (){
          print(Value);
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrsMpDetails(Value)));
        },*/
          ),
        )).toList();
  }

  NewsPaperListAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({});
    var response = await post(
      Uri.parse(
          'http://192.169.1.211:8081/api/v1/profile/newspaper/partyName/TDP'),
      headers: headers,
      body: body,
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
  }
}
