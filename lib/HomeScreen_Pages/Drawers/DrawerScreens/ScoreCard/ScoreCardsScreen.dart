import 'dart:convert';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flip_card/flip_card_controller.dart';
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
    final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
    final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();
    final GlobalKey<ExpansionTileCardState> cardD = new GlobalKey();
    final GlobalKey<ExpansionTileCardState> cardE = new GlobalKey();
    final GlobalKey<ExpansionTileCardState> cardF = new GlobalKey();
    final GlobalKey<ExpansionTileCardState> cardG = new GlobalKey();
    final GlobalKey<ExpansionTileCardState> cardH = new GlobalKey();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(''),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
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
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
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
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
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
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTileCard(
              baseColor: Colors.cyan[50],
              expandedColor: Colors.white,
              key: cardB,
              leading: CircleAvatar(backgroundColor: Colors.grey),
              title: Text("A. S. MANOHAR"),
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTileCard(
              baseColor: Colors.cyan[50],
              expandedColor: Colors.white,
              key: cardC,
              leading: CircleAvatar(backgroundColor: Colors.grey),
              title: Text("ABBAYA CHOWDARY KOTHARI"),
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                                  child: Text('75'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('92'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('788'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('025'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('869'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('41'),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTileCard(
              baseColor: Colors.cyan[50],
              expandedColor: Colors.white,
              key: cardD,
              leading: CircleAvatar(backgroundColor: Colors.grey),
              title: Text("ABDUL AZIZ SHAIK"),
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                                  child: Text('97'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('61'),
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
                                  child: Text('971'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('94'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('970'),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTileCard(
              baseColor: Colors.cyan[50],
              expandedColor: Colors.white,
              key: cardE,
              leading: CircleAvatar(backgroundColor: Colors.grey),
              title: Text("ABDUL HAFEEZ KHAN"),
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                                  child: Text('673'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('47'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('826'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('94'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('31'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('66'),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTileCard(
              baseColor: Colors.cyan[50],
              expandedColor: Colors.white,
              key: cardF,
              leading: CircleAvatar(backgroundColor: Colors.grey),
              title: Text("ADIMULAM KONETI"),
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                                  child: Text('92'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('42'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('54'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('76'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('54'),
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
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTileCard(
              baseColor: Colors.cyan[50],
              expandedColor: Colors.white,
              key: cardG,
              leading: CircleAvatar(backgroundColor: Colors.grey),
              title: Text("ADIREDDY BHAVANI"),
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                                  child: Text('87'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('789'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('513'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('54'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('31'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('21'),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTileCard(
              baseColor: Colors.cyan[50],
              expandedColor: Colors.white,
              key: cardH,
              leading: CircleAvatar(backgroundColor: Colors.grey),
              title: Text("ADITI VIJAYALAKSHMI GAJAPATHI RAJU PUSAPATI"),
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
                                  child: Text('67'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('24'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('45'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('852'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('127'),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('034'),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                verticalAlignment:
                                TableCellVerticalAlignment.top,
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
