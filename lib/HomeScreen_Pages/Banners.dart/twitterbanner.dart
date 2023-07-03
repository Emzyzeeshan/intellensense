import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intellensense/LoginPages/widgets/ChartSampleData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Twitterbanner extends StatefulWidget {
  const Twitterbanner({Key? key}) : super(key: key);

  @override
  State<Twitterbanner> createState() => _TwitterbannerState();
}

class _TwitterbannerState extends State<Twitterbanner> {
  late Future<dynamic> LineChartfuturecall = TwitterBannerGraphApi();
  TooltipBehavior? _tooltipBehavior;
   TooltipBehavior? _tooltipBehavior1;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        format: 'point.x : point.y',
        header: '');
         _tooltipBehavior1 = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        format: 'point.x : point.y',
        header: '');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: const [
                      /*Color.fromARGB(255, 100, 149, 235),
                      Color(0xffe4e0f8),*/
                      Colors.white,
                      Colors.white
                    ],
                    tileMode: TileMode.decal,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 25,
                      left: 100,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Segoe UI',
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            RotateAnimatedText('TWITTER',
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Segoe UI',color: Colors.black)),
                            RotateAnimatedText('BATTLE',
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Segoe UI',color: Colors.black)),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                    ),
                    Positioned(
                        top: 20,
                        left: 20,
                        child: Image.asset(
                          'assets/icons/Social-Media-Icons-IS-08.png',
                          height: 50,
                          width: 50,
                        )),
                    Positioned(
                        top: 105,
                        left: 190,
                        child: Container(
                          height: 145,
                          width: 145,
                          child: SfCircularChart(
                            tooltipBehavior: _tooltipBehavior1,
                            palette: [
                            Color(0xff000000),
                            Color(0xff2178c3),
                            Color(0xff66ffe6),
                            Color(0xffc6dff6),
                            Color(0xff725138)
                          ], series: <PieSeries<ChartSampleData, String>>[
                            PieSeries<ChartSampleData, String>(
                                explode: true,
                                explodeIndex: 0,
                                explodeOffset: '10%',
                                dataSource: <ChartSampleData>[

                                  ...PiegraphChartData
                                  // ChartSampleData(
                                  //     x: 'David', y: 13, text: 'Dav \n 13%'),
                                  // ChartSampleData(
                                  //     x: 'Steve', y: 24, text: 'Ste\n 24%'),
                                  // ChartSampleData(
                                  //     x: 'Jack', y: 25, text: 'Jack \n 25%'),
                                  // ChartSampleData(
                                  //     x: 'Others', y: 38, text: 'Other \n 38%'),
                                ],
                                xValueMapper: (ChartSampleData data, _) =>
                                    data.x as String,
                                yValueMapper: (ChartSampleData data, _) =>
                                    data.y,
                                dataLabelMapper: (ChartSampleData data, _) =>
                                    data.text,
                                startAngle: 90,
                                endAngle: 90,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: true)),
                          ]),
                        )),
                                Positioned(
                          top: 10,
                          right: 45,
                          child:     Text('LIKES',style: TextStyle(fontSize: 10),)),
                        Positioned(
                          top: 232,
                          right: 35,
                          child:     Text('FOLLOWERS',style: TextStyle(fontSize: 10),)),
                    Positioned(
                      top: 0,
                      left: 190,
                      child: FutureBuilder<dynamic>(
                        future: LineChartfuturecall,
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<dynamic> snapshot,
                        ) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Text('Error');
                            } else if (snapshot.hasData) {
                              return Container(
                                height: 135,
                                width: 135,
                                child: SfCartesianChart(
                                  palette: <Color>[
                                    Color(0xffff7f50),
                                    Color(0xfff0ead6),
                                    Color(0xffffd700),
                                    Color(0xff264348),
                                  ],
                                  plotAreaBorderWidth: 0,
                                  primaryXAxis: CategoryAxis(
                                    labelStyle:
                                        const TextStyle(color: Colors.black,fontSize: 8),
                                    axisLine: const AxisLine(width: 0),
                                    labelPosition:
                                        ChartDataLabelPosition.outside,
                                    majorTickLines:
                                        const MajorTickLines(width: 0),
                                    majorGridLines:
                                        const MajorGridLines(width: 0),
                                  ),
                                  primaryYAxis: NumericAxis(
                                      labelStyle:
                                      const TextStyle(color: Colors.black,fontSize: 8),
                                    labelPosition:ChartDataLabelPosition.outside ,
                                      isVisible: false,
                                      minimum: 0,
                                      maximum: 2000),
                                  series: <ColumnSeries<ChartSampleData,
                                      String>>[
                                    ColumnSeries<ChartSampleData, String>(
                                      width: 0.9,
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                              isVisible: false,
                                              labelAlignment:
                                                  ChartDataLabelAlignment.top),
                                      dataSource: <ChartSampleData>[
                                        
                                        ...BargraphChartdata
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      xValueMapper:
                                          (ChartSampleData sales, _) =>
                                              sales.x as String,
                                      yValueMapper:
                                          (ChartSampleData sales, _) => sales.y,
                                    ),
                                  ],
                                  tooltipBehavior: _tooltipBehavior,
                                ),
                              );
                            } else {
                              return const Text('Empty data');
                            }
                          } else {
                            return Text('State: ${snapshot.connectionState}');
                          }
                        },
                      ),
                    ),
                    Positioned(
                      left: 22,
                      top: 150,
                      child: Container(
                        width: 180,
                        child: RichText(
                          text: new TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: new TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              new TextSpan(
                                  text:
                                      'With Huge Difference In counts for Tweets and Re-Tweets reports says that ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Segoe UI')),
                              new TextSpan(
                                  text: 'BJP',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      fontSize: 20,
                                      fontFamily: 'Segoe UI')),
                              new TextSpan(
                                  text:
                                      ' is relatively Dominant in Twitter Data',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Segoe UI')),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]);
  }

  //Bar Graph data
  var BarGraphdata;
  
  Map Selectionquery1 = new Map<String, dynamic>();
  List<ChartSampleData> BargraphChartdata = [];
  List<ChartSampleData> PiegraphChartData=[];
  Future<dynamic> TwitterBannerGraphApi() async {
    setState(() {
      Selectionquery1['type'] = 'party_data';
      Selectionquery1['STATE'] = 'TELANGANA';
      Selectionquery1['party_list'] = 'INC,TRS,BJP';
      //Selectionquery['channel'] = 'YOUTUBE';
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media/'),
        body: Selectionquery1);

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('inside loop');
      try {
        print('inside try');
        BarGraphdata = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          BarGraphdata['party_data'].forEach((key, value) {
            print(key);
           
            BargraphChartdata.add(
              ChartSampleData(
                  x: '$key',
                  y: BarGraphdata['party_data'][key][0]['LIKES']),
            );
            PiegraphChartData.add(ChartSampleData(
                                      x: '$key', y: BarGraphdata['party_data'][key][0]['USER_FOLLOWERS'], text: '$key'),);
          });
          
          // for(int i=0;i<BarGraphdata['party_data'])
          // BargraphChartdata.add(ChartSampleData(x: 'TDP', y: 8683),);
        });
print('data here');
          print(BarGraphdata);
        
      } catch (e) {
        print(BarGraphdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return BarGraphdata;
  }
}
