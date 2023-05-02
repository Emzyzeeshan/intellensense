import 'dart:async';
import 'dart:convert';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class TrsMpDetails extends StatefulWidget {
  var Value;
  TrsMpDetails(this.Value);

  @override
  State<TrsMpDetails> createState() => _TrsMpDetailsState();
}

class _TrsMpDetailsState extends State<TrsMpDetails> {
  late Future<dynamic> Detailsofpartydata = PartyResultAPI();
  var isExpandedValues = [false, false];
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  void initState() {
    PartyResultAPI();
    // TODO: implement initState
    super.initState();
  }

  bool loaded = false;
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 80,
                child: ClipOval(
                  child: Image.memory(
                    base64Decode(widget.Value['content'].substring(22) ?? ''),
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
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
              baseColor: Colors.cyan[50],
              expandedColor: Colors.grey,
              expandedTextColor: Colors.black,
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
                                  child:
                                      Text(widget.Value['contactNumber'] ?? ''),
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
                                  child: Text(widget.Value['religion'] ?? ''),
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
                                  child: Text(widget.Value['education'] ?? ''),
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
                                      widget.Value['politicalCareeer'] ?? ''),
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
                                  child:
                                      Text(widget.Value['constitution'] ?? ''),
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
                                      Resultdata[index]['winnerVotes']) /
                                  (double.parse(
                                          Resultdata[index]['winnerVotes']) +
                                      double.parse(
                                          Resultdata[index]['runnerVotes']))) *
                              100;
                          double runnervotespercent = (double.parse(
                                      Resultdata[index]['runnerVotes']) /
                                  (double.parse(
                                          Resultdata[index]['winnerVotes']) +
                                      double.parse(
                                          Resultdata[index]['runnerVotes']))) *
                              100;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ExpansionTileCard(
                                baseColor: Colors.cyan[50],
                                expandedColor: Colors.white,
                                leading: Text('${Resultdata[index]['year']}'),
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
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Text(
                                                      'District',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Text(
                                                      'Constituency',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
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
                                                      const EdgeInsets.all(20),
                                                  child: Text(
                                                    'Party',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    'Votes',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    'Candidate Name',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    'Votes(%)',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                      const EdgeInsets.all(20),
                                                  child: Text(
                                                    '${Resultdata[index]['winnerParty']}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                      '${Resultdata[index]['winnerVotes']}'),
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                      '${Resultdata[index]['winnerCandidate']}'),
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                      '$winnervotespercent'
                                                              .toString()
                                                              .substring(0, 6) +
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
                                                      const EdgeInsets.all(20),
                                                  child: Text(
                                                    '${Resultdata[index]['runnerParty']}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                      '${Resultdata[index]['runnerVotes']}'),
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
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
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                      '$runnervotespercent'
                                                              .toString()
                                                              .substring(0, 6) +
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
                                                      const EdgeInsets.all(20),
                                                  child: Text(
                                                    'Margin-Votes',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                verticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .top,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Text(
                                                    '${Resultdata[index]['margin']}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ])
                                          ]),
                                    ],
                                  )
                                ]),
                          );
                        })
                  ])
          ],
        ));
  }

  var Resultdata;
  Future<dynamic> PartyResultAPI() async {
    var response = await get(
      Uri.parse(
          'http://192.169.1.211:8081/insights/2.89.0/eleResults/${widget.Value['name']}'),
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

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
