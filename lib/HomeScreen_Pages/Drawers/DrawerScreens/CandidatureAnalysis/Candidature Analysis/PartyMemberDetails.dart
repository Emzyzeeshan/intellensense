import 'dart:async';
import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:intellensense/Constants/constants.dart';
import 'package:intellensense/main.dart';

import '../Audio Emotion/AudioEmotionList.dart';
import '../Voice to Text/voicetotextlist.dart';
import '../newschannel emotion/NewsChannelSentiment.dart';
import '../newspaper emotion/NewspaperSentiment.dart';
import '../twitter emotion/TwitterSentiment.dart';
import '../youtube emotion/YoutubeSentiment.dart';
import '../../../../../main.dart';

class TrsMpDetails extends StatefulWidget {
  var Value;

  TrsMpDetails(this.Value);

  @override
  State<TrsMpDetails> createState() => _TrsMpDetailsState();
}

class _TrsMpDetailsState extends State<TrsMpDetails> {
  late Future<dynamic> Detailsofpartydata = PartyResultAPI();

  var isExpandedValues = [false, false];
  // final Completer<GoogleMapController> _controller =
  // Completer<GoogleMapController>();
  //
  // static const CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );
  var partycolor;
  @override
  void initState() {
    if(widget.Value['party']=='TRS'){

      partycolor=Color(0xfff57ec6);

    }else if(widget.Value['party']=='AIMIM'){

      partycolor=Color.fromARGB(255, 13, 71, 15);
    }else if(widget.Value['party']=='AIFB'){

      partycolor=Colors.redAccent;

    }else if(widget.Value['party']=='INC'){

      partycolor=Color.fromARGB(255, 112, 169, 113);

    }else if(widget.Value['party']=='TDP'){

      partycolor=Colors.yellow;

    }else if(widget.Value['party']=='BJP'){

      partycolor=Colors.orangeAccent;

    }else if(widget.Value['party']=='JSP'){

      partycolor=Colors.red;

    }else if(widget.Value['party']=='SHIV SENA'){

      partycolor=Colors.deepOrangeAccent;

    }else{
      partycolor=Colors.cyan[50];
    }
    print(widget.Value['party']);
    PartyResultAPI();
    // TODO: implement initState
    super.initState();
  }

  bool loaded = false;
  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 28.0, left: 8, right: 8),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: MemoryImage(
                        base64Decode(
                            widget.Value['content'].substring(22) ?? ''),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.Value['name'] ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(5)),
                    Image.asset(
                      'assets/icons/Social-Media-Icons-IS-06.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Image.asset(
                      'assets/icons/Social-Media-Icons-IS-07.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Image.asset(
                      'assets/icons/Social-Media-Icons-IS-08.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Image.asset(
                      'assets/icons/Social-Media-Icons-IS-09.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.contain,
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Image.asset(
                      'assets/icons/Social-Media-Icons-IS-10.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ExpansionTileCard(
                  baseColor:  partycolor,
                  // expandedColor: Colors.white,
                  // expandedTextColor: Colors.black,
                  title: Text('Profile'),
                  children: [
                    Column(
                      children: <Widget>[
                        Container(
                          child: Table(
                            defaultColumnWidth: FixedColumnWidth(150.0),
                            border: TableBorder.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2),
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        'Party',
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
                                      child: Text(widget.Value['party'] ?? ''),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        'Contact No',
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
                                      child: Text(
                                          widget.Value['contactNumber'] ?? ''),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        'Religion',
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
                                      child:
                                      Text(widget.Value['religion'] ?? ''),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        'Caste',
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
                                      child: Text(widget.Value['caste'] ?? ''),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        'Age',
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
                                      child: Text(widget.Value['age'] ?? ''),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        'Education',
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
                                      child:
                                      Text(widget.Value['education'] ?? ''),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        'Political Career',
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
                                      child: Text(
                                          widget.Value['politicalCareeer'] ??
                                              ''),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        'Constituency',
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
                                      child: Text(
                                          widget.Value['constitution'] ?? ''),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        'Spouse',
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
                                      child: Text(widget.Value['spouse'] ?? ''),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                loaded == false
                    ? Center(child: CircularProgressIndicator())
                    : Column(children: <Widget>[
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: Resultdata.length,
                      itemBuilder: (context, index) {
                        double winnervotespercent = (double.parse(
                            Resultdata[index]['winnerVotes'] == null
                                ? 0.00
                                : Resultdata[index]
                            ['winnerVotes']) /
                            (double.parse(Resultdata[index]
                            ['winnerVotes'] ==
                                null
                                ? 0.00
                                : Resultdata[index]
                            ['winnerVotes']) +
                                double.parse(Resultdata[index]
                                ['runnerVotes'] ==
                                    null
                                    ? 0.00
                                    : Resultdata[index]['runnerVotes']))) *
                            100;
                        double runnervotespercent = (double.parse(
                            Resultdata[index]['runnerVotes'] == null
                                ? 0.00
                                : Resultdata[index]
                            ['runnerVotes']) /
                            (double.parse(Resultdata[index]
                            ['winnerVotes'] ==
                                null
                                ? 0.00
                                : Resultdata[index]
                            ['winnerVotes']) +
                                double.parse(Resultdata[index]
                                ['runnerVotes'] ==
                                    null
                                    ? 0.00
                                    : Resultdata[index]['runnerVotes']))) *
                            100;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ExpansionTileCard(
                              baseColor:  partycolor,
                              // expandedColor: Colors.white,
                              leading: Text(
                                  '${Resultdata[index]['id']['year']}'),
                              title: Container(),
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Table(
                                        defaultColumnWidth:
                                        FixedColumnWidth(150.0),
                                        border: TableBorder.all(
                                            color: Colors.grey,
                                            style: BorderStyle.solid,
                                            width: 2),
                                        children: [
                                          TableRow(
                                            children: [
                                              TableCell(
                                                verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .top,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(20),
                                                  child: Text(
                                                    'District',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(10),
                                                  child: Text(
                                                      '${Resultdata[index]['district']}'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          TableRow(
                                            children: [
                                              TableCell(
                                                verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .top,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(20),
                                                  child: Text(
                                                    'Constituency',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(10),
                                                  child: Text(
                                                      '${Resultdata[index]['assemblyConstituency']}'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Table(
                                        defaultColumnWidth:
                                        FixedColumnWidth(150.0),
                                        border: TableBorder.all(
                                            color: Colors.grey,
                                            style: BorderStyle.solid,
                                            width: 2),
                                        children: [
                                          TableRow(children: [
                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment
                                                  .top,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    20),
                                                child: Text(
                                                  'Party',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment
                                                  .middle,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    10),
                                                child: Text(
                                                  'Votes',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment
                                                  .middle,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    10),
                                                child: Text(
                                                  'Candidate Name',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment
                                                  .middle,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    10),
                                                child: Text(
                                                  'Votes(%)',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment
                                                  .top,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    20),
                                                child: Text(
                                                  '${Resultdata[index]['winnerParty']}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment
                                                  .middle,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    10),
                                                child: Text(
                                                    '${Resultdata[index]['winnerVotes'].toString()}'),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment
                                                  .middle,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    10),
                                                child: Text(
                                                    '${Resultdata[index]['id']['winnerCandidate']}'),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment
                                                  .middle,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    10),
                                                child: Text(
                                                    '$winnervotespercent'
                                                        .toString()
                                                        .substring(
                                                        0, 6) +
                                                        '%'),
                                              ),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment
                                                  .top,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    20),
                                                child: Text(
                                                  '${Resultdata[index]['runnerParty'].toString()}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment
                                                  .middle,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    10),
                                                child: Text(
                                                    '${Resultdata[index]['runnerVotes'].toString()}'),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment
                                                  .middle,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    10),
                                                child: Text(
                                                    '${Resultdata[index]['runnerCandidate']}'),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment
                                                  .middle,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    10),
                                                child: Text(
                                                    '$runnervotespercent'
                                                        .toString()
                                                        .substring(
                                                        0, 6) +
                                                        '%'),
                                              ),
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Table(
                                        defaultColumnWidth:
                                        FixedColumnWidth(150.0),
                                        border: TableBorder.all(
                                            color: Colors.grey,
                                            style: BorderStyle.solid,
                                            width: 2),
                                        children: [
                                          TableRow(children: [
                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment
                                                  .top,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    20),
                                                child: Text(
                                                  'Margin-Votes',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              verticalAlignment:
                                              TableCellVerticalAlignment
                                                  .top,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    20),
                                                child: Text(
                                                  '${Resultdata[index]['margin']}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                ),
                                              ),
                                            ),
                                          ])
                                        ]),
                                  ],
                                )
                              ]),
                        );
                      }),
                  // ListTile(
                  //   leading: Text('Sentiment Analysis'),
                  //   tileColor: Colors.cyan[50],
                  //   trailing: Icon(Icons.arrow_drop_down),
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         PageTransition(
                  //             duration: Duration(milliseconds: 700),
                  //             type: PageTransitionType.bottomToTop,
                  //             child: SentimentAnalysis(widget.Value)));
                  //   },
                  // ),

                  //Sentiment analysis
                ]),
                Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color:Color(0xff86a8e7),
                      child: Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Sentiment Analysis',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            OpenContainer(


                              openElevation: 10.0,
                              closedShape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)),
                              ),
                              transitionType:
                              ContainerTransitionType.fade,
                              transitionDuration:
                              const Duration(milliseconds: 1200),
                              openBuilder: (context, action) {
                                return TwitterSentiment(widget.Value);
                              },
                              closedBuilder: (context, action) {
                                return SentimentCardTemplate(() {},
                                    'assets/icons/Social-Media-Icons-IS-08.png');
                              },
                            ),
                            OpenContainer(


                              openElevation: 10.0,
                              closedShape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)),
                              ),
                              transitionType:
                              ContainerTransitionType.fade,
                              transitionDuration:
                              const Duration(milliseconds: 1200),
                              openBuilder: (context, action) {
                                return YoutubeSentiment(widget.Value);
                              },
                              closedBuilder: (context, action) {
                                return SentimentCardTemplate(() {},
                                    'assets/icons/Social-Media-Icons-IS-10.png');
                              },
                            ),
                            OpenContainer(


                              openElevation: 10.0,
                              closedShape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)),
                              ),
                              transitionType:
                              ContainerTransitionType.fade,
                              transitionDuration:
                              const Duration(milliseconds: 1200),
                              openBuilder: (context, action) {
                                return NewsPaperSentiment(widget.Value);
                              },
                              closedBuilder: (context, action) {
                                return SentimentCardTemplate(() {},
                                    'assets/new Updated images/intellisensesolutions-Icons-83.png');
                              },
                            ),
                            OpenContainer(


                              openElevation: 10.0,
                              closedShape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)),
                              ),
                              transitionType:
                              ContainerTransitionType.fade,
                              transitionDuration:
                              const Duration(milliseconds: 1200),
                              openBuilder: (context, action) {
                                return Container();
                              },
                              closedBuilder: (context, action) {
                                return SentimentCardTemplate(() {},
                                    'assets/icons/voicedxps.png');
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            OpenContainer(


                              openElevation: 10.0,
                              closedShape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)),
                              ),
                              transitionType:
                              ContainerTransitionType.fade,
                              transitionDuration:
                              const Duration(milliseconds: 1200),
                              openBuilder: (context, action) {
                                return NewsChannel(widget.Value);
                              },
                              closedBuilder: (context, action) {
                                return SentimentCardTemplate(
                                        () {}, 'assets/icons/newsdxps.png');
                              },
                            ),
                            OpenContainer(


                              openElevation: 10.0,
                              closedShape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)),
                              ),
                              transitionType:
                              ContainerTransitionType.fade,
                              transitionDuration:
                              const Duration(milliseconds: 1200),
                              openBuilder: (context, action) {
                                return Container();
                              },
                              closedBuilder: (context, action) {
                                return SentimentCardTemplate(() {},
                                    'assets/icons/timelinedxp.png');
                              },
                            ),
                            OpenContainer(


                              openElevation: 10.0,
                              closedShape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)),
                              ),
                              transitionType:
                              ContainerTransitionType.fade,
                              transitionDuration:
                              const Duration(milliseconds: 1200),
                              openBuilder: (context, action) {
                                return AudioEmotionlist();
                              },
                              closedBuilder: (context, action) {
                                return SentimentCardTemplate(() {},
                                    'assets/icons/faceEmotiondxp.png');
                              },
                            ),
                            OpenContainer(


                              openElevation: 10.0,
                              closedShape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)),
                              ),
                              transitionType:
                              ContainerTransitionType.fade,
                              transitionDuration:
                              const Duration(milliseconds: 1200),
                              openBuilder: (context, action) {
                                return ContentCardScreen();
                              },
                              closedBuilder: (context, action) {
                                return SentimentCardTemplate(() {},
                                    'assets/icons/voice_to_text.png');
                              },
                            ),
                          ],
                        )
                      ]),
                    )),
              ],
            ),
          )),
    );
  }

  var Resultdata;
  Future<dynamic> PartyResultAPI() async {
    var response = await get(
      Uri.parse(INSIGHTS + '/isEleResults/${widget.Value['name']}'),
    );
    print(response.toString());
    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        Resultdata = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          loaded = true;
        });

        print(Resultdata);
      } catch (e) {
        print(Resultdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return Resultdata;
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  SentimentCardTemplate(VoidCallback ontap, String path) {
    return Card(
      color: Color(0xffd2dfff),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(
          '$path',
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
