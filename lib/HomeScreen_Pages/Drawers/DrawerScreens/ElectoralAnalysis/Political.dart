import 'dart:async';
import 'dart:convert';


import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:intellensense/LoginPages/widgets/ChartSampleData.dart';
import 'package:skeletons/skeletons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Political extends StatefulWidget {
  @override
  State<Political> createState() => _PoliticalState();
}

class _PoliticalState extends State<Political> {
  //late Position position;
  bool isposloading = false;
  //List<LatLng> _items = [LatLng(0,0)];
  /*Future<void> readJson() async {
    try {
      final String response = await rootBundle.loadString(
          'assets/telangana_dist.json');
      final data = await json.decode(response);
      setState(() {
        _items = data["features"]
            .expand((feature) => List.from(feature['geometry']['type'].toLowerCase() == 'polygon'
            ? feature['geometry']['coordinates'][0]
            : feature['geometry']['coordinates'].expand((coords) => List.from(coords[0]))))
            .map<LatLng>((coords) => LatLng(coords[1], coords[0])).toList();
      });
    } catch (e) {
      print("caught error");
      print(e);
    }
  }
  ///get location
  getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print(serviceEnabled);
    if (!serviceEnabled) {
      return getCurrentLocation();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return CoolAlert.show(
          barrierDismissible: false,
          context: context,
          type: CoolAlertType.loading,
          text: "Please Restart Application And Allow Permission ",
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return CoolAlert.show(
        barrierDismissible: false,
        context: context,
        type: CoolAlertType.loading,
        text: "Please Enable Location From Setting ",
      );
    }
    *//*Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    position = pos;*//*
    isposloading = true;
    //print(pos);
    return isposloading;
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(18.1124,79.0193),
    zoom: 3,
  );*/
  late Future<dynamic> finaldata = PoliticalAPI1();
  late Future<dynamic> finaldata1 = VotewisedataAPI();
  late Future<dynamic> ElectoraldataFuture = ElectoraldataAPI();
  late Future<dynamic> AssemblydataFuture = AssemblyConstituencydataAPI();
  void initState() {
    _ElectoralTabledata.clear();
    // TODO: implement initState
    super.initState();
    //readJson();
  }

  void dispose() {
    _ElectoralTabledata.clear();
    AssemblyConstituencyTabledata.clear();
    // TODO: implement initState
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      child: SingleChildScrollView(
        child: Column(
          children: [
            /*Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 8, right: 8),
              child: Container(
                height: 300,
                width: 400,
                child: GoogleMap(zoomControlsEnabled: true,zoomGesturesEnabled: true,scrollGesturesEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  polygons:
                  {
                    Polygon(
                      polygonId: const PolygonId("1"),
                        fillColor: Colors.green.withOpacity(0.3),visible: true,
                      strokeWidth: 2,
                      points: _items
                      *//*points: const [
                        LatLng(32.3078, -64.7505),
                        LatLng(15.9129, 79.7400),
                        LatLng(15.9129, 79.7400),
                        LatLng( 77.987007141113452, 15.04408073425293),
                        LatLng(78.089401245117358, 14.71306037902832),
                        LatLng(78.419197082519702, 14.146200180053825),
                        LatLng( 76.974212646484375, 14.0577096939089198),
                        LatLng(76.846916198730753, 14.802310943603459),
                      ],*//*
                    ),
                  },
                ),
              ),
            ),*/
            FutureBuilder(
              future: finaldata,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 120,
                            child: Card(
                                color: Color(0xffd2dfff),
                                elevation: 10,
                                child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Center(
                                      child:
                                          SpinKitWave(
                                    color:
                                        Colors.blue,
                                    size: 18,
                                  )),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: const Text('Data Error'));
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        // color: Color(0xff86a8e7),
                        elevation: 10,
                        child: Column(
                          children: [
                            Table(children: [
                              TableRow(children: [
                                Container(
                                    height: 30,
                                    color: Color(0xff86a8e7),
                                    child: Center(
                                        child: Text(
                                      'Party',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          ),
                                    ))),
                                Container(
                                    height: 30,
                                    color: Color(0xff86a8e7),
                                    child: Center(
                                        child: Text(
                                      'Seats',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          ),
                                    ))),
                                Container(
                                    height: 30,
                                    color: Color(0xff86a8e7),
                                    child: Center(
                                        child: Text(
                                      'Rank',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          ),
                                    ))),
                              ]),
                              ..._tablerow,
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(color: Colors.white, thickness: 1),
                            SfCartesianChart(
                              plotAreaBorderWidth: 0,
                              title: ChartTitle(text: 'Party Wise Seats'),
                              primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(width: 0),
                              ),
                              primaryYAxis: NumericAxis(
                                  axisLine: const AxisLine(width: 0),
                                  labelFormat: '{value}',
                                  majorTickLines:
                                      const MajorTickLines(size: 0)),
                              series: <ColumnSeries<ChartSampleData, String>>[
                                ColumnSeries<ChartSampleData, String>(
                                  dataSource: Graph1Data,
                                  xValueMapper: (ChartSampleData sales, _) =>
                                      sales.x as String,
                                  yValueMapper: (ChartSampleData sales, _) =>
                                      sales.y,
                                  dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                      textStyle: TextStyle(fontSize: 10)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(child: const Text('Server Error'));
                  }
                } else {
                  return Center(
                      child: Text('State: ${snapshot.connectionState}'));
                }
              }),
            ),

            //Party wise votes
            FutureBuilder(
              future: finaldata1,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 120,
                        child: Card(
                            color: Color(0xffd2dfff),
                            elevation: 10,
                            child: Center(
                       
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Center(
                              child: SpinKitWave(
                            color: Colors.blue,
                            size: 18,
                          )),
                        ),
                      )),
                      ));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: const Text('Data Error'));
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        // color: Color(0xffd2dfff),
                        elevation: 10,
                        child: Column(
                          children: [
                            Table(children: [
                              TableRow(children: [
                                Container(
                                    height: 30,
                                    color: Color(0xff86a8e7),
                                    child: Center(
                                        child: Text(
                                      'Party',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          ),
                                    ))),
                                Container(
                                    height: 30,
                                    color: Color(0xff86a8e7),
                                    child: Center(
                                        child: Text(
                                      'Votes',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          ),
                                    ))),
                                Container(
                                    height: 30,
                                    color: Color(0xff86a8e7),
                                    child: Center(
                                        child: Text(
                                      'Rank',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          ),
                                    ))),
                              ]),
                              ..._votewisedata
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(color: Colors.white, thickness: 1),
                            SfCartesianChart(
                              plotAreaBorderWidth: 0,
                              title: ChartTitle(text: 'Party Wise Votes'),
                              primaryXAxis: CategoryAxis(
                                majorGridLines: const MajorGridLines(width: 0),
                              ),
                              primaryYAxis: NumericAxis(
                                  axisLine: const AxisLine(width: 0),
                                  labelFormat: '{value}',
                                  majorTickLines:
                                      const MajorTickLines(size: 0)),
                              series: <ColumnSeries<ChartSampleData, String>>[
                                ColumnSeries<ChartSampleData, String>(
                                  dataSource: Votechartdata,
                                  xValueMapper: (ChartSampleData sales, _) =>
                                      sales.x as String,
                                  yValueMapper: (ChartSampleData sales, _) =>
                                      sales.y,
                                  dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                      textStyle: TextStyle(fontSize: 10)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(child: const Text('Server Error'));
                  }
                } else {
                  return Center(
                      child: Text('State: ${snapshot.connectionState}'));
                }
              }),
            ),
            //Electoral Data
            FutureBuilder(
              future: ElectoraldataFuture,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          color: Color(0xffd2dfff),
                          elevation: 10,
                          child: Center(
                       
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Center(
                              child: SpinKitWave(
                            color: Colors.blue,
                            size: 18,
                          )),
                        ),
                      )));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: const Text('Data Error'));
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        // color: Color(0xffd2dfff),
                        elevation: 10,
                        child: Table(children: [
                          TableRow(children: [
                            Container(
                                height: 30,
                                color: Color(0xff86a8e7),
                                child: Center(
                                    child: Text(
                                  'Andhra Pradesh',
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      ),
                                ))),
                            Container(
                                height: 30,
                                color: Color(0xff86a8e7),
                                child: Center(
                                    child: Text(
                                  'Electoral Data',
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      ),
                                ))),
                          ]),
                          ..._ElectoralTabledata
                        ]),
                      ),
                    );
                  } else {
                    return Center(child: const Text('Server Error'));
                  }
                } else {
                  return Center(
                      child: Text('State: ${snapshot.connectionState}'));
                }
              }),
            ),
            //Assembly Constituency
            FutureBuilder(
              future: AssemblydataFuture,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          color: Color(0xffd2dfff),
                          elevation: 10,
                          child: Center(
                       
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Center(
                              child: SpinKitWave(
                            color: Colors.blue,
                            size: 18,
                          )),
                        ),
                      )));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: const Text('Data Error'));
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        // color: Color(0xffd2dfff),
                        elevation: 10,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Assembly Constituencies',
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              Table(
                                  border: TableBorder.all(color: Colors.grey),
                                  defaultColumnWidth: FixedColumnWidth(130.0),
                                  children: [
                                    TableRow(children: [
                                      Container(
                                          height: 30,
                                          color: Color(0xff86a8e7),
                                          child: Center(
                                              child: Text(
                                            'Constituency',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                ),
                                          ))),
                                      Container(
                                          height: 30,
                                          color: Color(0xff86a8e7),
                                          child: Center(
                                              child: Text(
                                            'Winner',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                ),
                                          ))),
                                      Container(
                                          height: 30,
                                          color: Color(0xff86a8e7),
                                          child: Center(
                                              child: Text(
                                            'Winner Party',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                ),
                                          ))),
                                      Container(
                                          height: 30,
                                          color: Color(0xff86a8e7),
                                          child: Center(
                                              child: Text(
                                            'Winner Votes',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                ),
                                          ))),
                                      Container(
                                          height: 30,
                                          color: Color(0xff86a8e7),
                                          child: Center(
                                              child: Text(
                                            'Runner',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                ),
                                          ))),
                                      Container(
                                          height: 30,
                                          color: Color(0xff86a8e7),
                                          child: Center(
                                              child: Text(
                                            'Runner Party',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                ),
                                          ))),
                                      Container(
                                          height: 30,
                                          color: Color(0xff86a8e7),
                                          child: Center(
                                              child: Text(
                                            'Runner votes',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                ),
                                          ))),
                                      Container(
                                          height: 30,
                                          color:Color(0xff86a8e7),
                                          child: Center(
                                              child: Text(
                                            'Margin',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                ),
                                          ))),
                                    ]),
                                    ...AssemblyConstituencyTabledata
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: const Text('Server Error'));
                  }
                } else {
                  return Center(
                      child: Text('State: ${snapshot.connectionState}'));
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  //API party wise
  Map map1 = new Map<String, dynamic>();

  var PoliticaData;

  List<TableRow> _tablerow = [];
  List<ChartSampleData> Graph1Data = [];
  Future PoliticalAPI1() async {
    setState(() {
      map1['type'] = 'party_wise_seats';
      map1['state'] = 'andhra pradesh';
      map1['year'] = '2019';
      map1['constituency_type'] = 'ac';
    });

    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6652/electoral_analysis/'),
        body: map1);

    if (response.statusCode == 200) {
      try {
        PoliticaData = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0; i < PoliticaData.length; i++) {
          Graph1Data.add(
            ChartSampleData(
                x: '${PoliticaData[i]['WINNER_PARTY']}',
                y: int.parse(PoliticaData[i]['COUNT_NUM'])),
          );
          _tablerow.add(
            TableRow(children: [
              Row(
                  children:[ Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${PoliticaData[i]['WINNER_PARTY']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      ),
                ),
              )]),
              Row(mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                  '${PoliticaData[i]['COUNT_NUM']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                  '${PoliticaData[i]['ROWNUM']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )
            ]),
          );
        }
      } catch (e) {}
    } else {
      print(response.reasonPhrase);
    }
    return PoliticaData;
  }

  //Api vote wise
  var Votewisedata;
  Map VoteWisemap = new Map<String, dynamic>();
  List<TableRow> _votewisedata = [];
  List<ChartSampleData> Votechartdata = [];
  Future VotewisedataAPI() async {
    setState(() {
      VoteWisemap['type'] = 'party_wise_votes';
      VoteWisemap['state'] = 'andhra pradesh';
      VoteWisemap['year'] = '2019';
      VoteWisemap['constituency_type'] = 'ac';
    });

    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6652/electoral_analysis/'),
        body: VoteWisemap);

    if (response.statusCode == 200) {
      try {
        Votewisedata = jsonDecode(utf8.decode(response.bodyBytes));

        for (int i = 0; i < Votewisedata.length; i++) {
          Votechartdata.add(
            ChartSampleData(
                x: '${Votewisedata[i]['WINNER_PARTY']}',
                y: int.parse(Votewisedata[i]['WINNER_VOTES'])),
          );
          _votewisedata.add(
            TableRow(children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                  '${Votewisedata[i]['WINNER_PARTY']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                  '${Votewisedata[i]['WINNER_VOTES']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                  '${Votewisedata[i]['ROWNUM']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )
            ]),
          );
        }
      } catch (e) {}
    } else {
      print(response.reasonPhrase);
    }
    return Votewisedata;
  }

  //API Electoral Data
  var ElectoralData;
  Map Electoralmap = new Map<String, dynamic>();
  List keyss = [];
  List<TableRow> _ElectoralTabledata = [];
  Future ElectoraldataAPI() async {
    setState(() {
      Electoralmap['type'] = 'electoral_data';
      Electoralmap['state'] = 'andhra pradesh';
      Electoralmap['year'] = '2019';
      Electoralmap['constituency_type'] = 'ac';
    });

    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6652/electoral_analysis/'),
        body: Electoralmap);

    if (response.statusCode == 200) {
      try {
        ElectoralData = jsonDecode(utf8.decode(response.bodyBytes));

        ElectoralData.keys.forEach((key) {
          setState(() {
            _ElectoralTabledata.add(
              TableRow(children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                    '${key}',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                    '${ElectoralData['${key}']}',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            );
          });
        });
      } catch (e) {}
    } else {
      print(response.reasonPhrase);
    }
    return ElectoralData;
  }

  //Assembly Contution data
  var AssemblyConstituencyData;
  Map AssemblyConstituencymap = new Map<String, dynamic>();
  List<TableRow> AssemblyConstituencyTabledata = [];
  Future AssemblyConstituencydataAPI() async {
    setState(() {
      AssemblyConstituencymap['type'] = 'assembly_constituencies';
      AssemblyConstituencymap['state'] = 'andhra pradesh';
      AssemblyConstituencymap['year'] = '2019';
      AssemblyConstituencymap['constituency_type'] = 'ac';
    });

    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6652/electoral_analysis/'),
        body: AssemblyConstituencymap);

    if (response.statusCode == 200) {
      try {
        AssemblyConstituencyData = jsonDecode(utf8.decode(response.bodyBytes));

        for (int i = 0; i < AssemblyConstituencyData.length; i++) {
          AssemblyConstituencyTabledata.add(
            TableRow(children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                  '${AssemblyConstituencyData[i]['ASSEMBLY_CONSTITUENCY']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                '${AssemblyConstituencyData[i]['WINNER_CANDIDATE']}',
                style: GoogleFonts.nunitoSans(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                  '${AssemblyConstituencyData[i]['WINNER_PARTY']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                  '${AssemblyConstituencyData[i]['WINNER_VOTES']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                '${AssemblyConstituencyData[i]['RUNNER_CANDIDATE']}',
                style: GoogleFonts.nunitoSans(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                  '${AssemblyConstituencyData[i]['RUNNER_PARTY']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                  '${AssemblyConstituencyData[i]['RUNNER_VOTES']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                  '${AssemblyConstituencyData[i]['MARGIN']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )
            ]),
          );
        }
      } catch (e) {}
    } else {
      print(response.reasonPhrase);
    }
    return AssemblyConstituencyData;
  }
}
