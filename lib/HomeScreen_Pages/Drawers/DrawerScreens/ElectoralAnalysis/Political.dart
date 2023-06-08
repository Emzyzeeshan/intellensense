import 'dart:async';
import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    ///permission for Location
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
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
    /*Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    position = pos;*/
    isposloading = true;
    //print(pos);
    return isposloading;
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  late Future<dynamic> finaldata = PoliticalAPI1();
  late Future<dynamic> finaldata1 = VotewisedataAPI();
  late Future<dynamic> ElectoraldataFuture = ElectoraldataAPI();
  late Future<dynamic> AssemblydataFuture = AssemblyConstituencydataAPI();
  void initState() {
    _ElectoralTabledata.clear();
    // TODO: implement initState
    super.initState();
  }

  void Dispose() {
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
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 8, right: 8),
              child: Container(
                height: 300,
                width: 400,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
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
                                child: SkeletonParagraph(
                                  style: SkeletonParagraphStyle(
                                      lines: 5,
                                      spacing: 6,
                                      lineStyle: SkeletonLineStyle(
                                        randomLength: true,
                                        height: 13,
                                        borderRadius: BorderRadius.circular(8),
                                        minLength:
                                            MediaQuery.of(context).size.width /
                                                2,
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
                        color: Color(0xffd2dfff),
                        elevation: 10,
                        child: Column(
                          children: [
                            Table(children: [
                              TableRow(children: [
                                Container(
                                    height: 30,
                                    color: Color(0xff00196b),
                                    child: Center(
                                        child: Text(
                                      'Party',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ))),
                                Container(
                                    height: 30,
                                    color: Color(0xff00196b),
                                    child: Center(
                                        child: Text(
                                      'Seats',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ))),
                                Container(
                                    height: 30,
                                    color: Color(0xff00196b),
                                    child: Center(
                                        child: Text(
                                      'Rank',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
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
                            child: SkeletonParagraph(
                              style: SkeletonParagraphStyle(
                                  lines: 5,
                                  spacing: 6,
                                  lineStyle: SkeletonLineStyle(
                                    randomLength: true,
                                    height: 13,
                                    borderRadius: BorderRadius.circular(8),
                                    minLength:
                                        MediaQuery.of(context).size.width / 2,
                                  )),
                            )),
                      ));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: const Text('Data Error'));
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Color(0xffd2dfff),
                        elevation: 10,
                        child: Column(
                          children: [
                            Table(children: [
                              TableRow(children: [
                                Container(
                                    height: 30,
                                    color: Color(0xff00196b),
                                    child: Center(
                                        child: Text(
                                      'Party',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ))),
                                Container(
                                    height: 30,
                                    color: Color(0xff00196b),
                                    child: Center(
                                        child: Text(
                                      'Votes',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ))),
                                Container(
                                    height: 30,
                                    color: Color(0xff00196b),
                                    child: Center(
                                        child: Text(
                                      'Rank',
                                      style: GoogleFonts.nunitoSans(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
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
                          child: SkeletonParagraph(
                            style: SkeletonParagraphStyle(
                                lines: 12,
                                spacing: 6,
                                lineStyle: SkeletonLineStyle(
                                  randomLength: true,
                                  height: 13,
                                  borderRadius: BorderRadius.circular(8),
                                  minLength:
                                      MediaQuery.of(context).size.width / 2,
                                )),
                          )));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: const Text('Data Error'));
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Color(0xffd2dfff),
                        elevation: 10,
                        child: Table(children: [
                          TableRow(children: [
                            Container(
                                height: 30,
                                color: Color(0xff00196b),
                                child: Center(
                                    child: Text(
                                  'Andhra Pradesh',
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ))),
                            Container(
                                height: 30,
                                color: Color(0xff00196b),
                                child: Center(
                                    child: Text(
                                  'Electoral Data',
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
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
                          child: SkeletonParagraph(
                            style: SkeletonParagraphStyle(
                                lines: 12,
                                spacing: 6,
                                lineStyle: SkeletonLineStyle(
                                  randomLength: true,
                                  height: 13,
                                  borderRadius: BorderRadius.circular(8),
                                  minLength:
                                      MediaQuery.of(context).size.width / 2,
                                )),
                          )));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: const Text('Data Error'));
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Color(0xffd2dfff),
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
                                      color: Colors.black),
                                ),
                              ),
                              Table(border: TableBorder.all(color: Colors.grey),
                                  defaultColumnWidth: FixedColumnWidth(130.0),
                                  children: [
                                    TableRow(
                                     
                                      children: [
                                      Container(
                                          height: 30,
                                          color: Color(0xff00196b),
                                          child: Center(
                                              child: Text(
                                            'Constituency',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ))),
                                      Container(
                                          height: 30,
                                          color: Color(0xff00196b),
                                          child: Center(
                                              child: Text(
                                            'Winner',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ))),
                                      Container(
                                          height: 30,
                                          color: Color(0xff00196b),
                                          child: Center(
                                              child: Text(
                                            'Winner Party',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ))),
                                      Container(
                                          height: 30,
                                          color: Color(0xff00196b),
                                          child: Center(
                                              child: Text(
                                            'Winner Votes',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ))),
                                      Container(
                                          height: 30,
                                          color: Color(0xff00196b),
                                          child: Center(
                                              child: Text(
                                            'Runner',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ))),
                                      Container(
                                          height: 30,
                                          color: Color(0xff00196b),
                                          child: Center(
                                              child: Text(
                                            'Runner Party',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ))),
                                      Container(
                                          height: 30,
                                          color: Color(0xff00196b),
                                          child: Center(
                                              child: Text(
                                            'Runner votes',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ))),
                                      Container(
                                          height: 30,
                                          color: Color(0xff00196b),
                                          child: Center(
                                              child: Text(
                                            'Margin',
                                            style: GoogleFonts.nunitoSans(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
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
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${PoliticaData[i]['WINNER_PARTY']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${PoliticaData[i]['COUNT_NUM']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${PoliticaData[i]['ROWNUM']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ))
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
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${Votewisedata[i]['WINNER_PARTY']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${Votewisedata[i]['WINNER_VOTES']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${Votewisedata[i]['ROWNUM']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ))
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
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    '${key}',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                )),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    '${ElectoralData['${key}']}',
                    style: GoogleFonts.nunitoSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                )),
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
            TableRow(
             
              children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${AssemblyConstituencyData[i]['ASSEMBLY_CONSTITUENCY']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${AssemblyConstituencyData[i]['WINNER_CANDIDATE']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${AssemblyConstituencyData[i]['WINNER_PARTY']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${AssemblyConstituencyData[i]['WINNER_VOTES']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${AssemblyConstituencyData[i]['RUNNER_CANDIDATE']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${AssemblyConstituencyData[i]['RUNNER_PARTY']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${AssemblyConstituencyData[i]['RUNNER_VOTES']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '${AssemblyConstituencyData[i]['MARGIN']}',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ))
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
