import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:intellensense/LoginPages/widgets/ChartSampleData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TwitterExpBanner extends StatefulWidget {
  const TwitterExpBanner({Key? key}) : super(key: key);

  @override
  State<TwitterExpBanner> createState() => _TwitterExpBannerState();
}

class _TwitterExpBannerState extends State<TwitterExpBanner> {
  late Future<dynamic> LineChartfuturecall = TwitterBannerGraphApi();
  TooltipBehavior? _tooltipBehavior;
  TooltipBehavior? _tooltipBehavior1;
  List<ChartSampleData>? chartData;
  @override
  void initState() {
    chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'Jan', y: 43, secondSeriesYValue: 37, thirdSeriesYValue: 41),
      ChartSampleData(
          x: 'Feb', y: 45, secondSeriesYValue: 37, thirdSeriesYValue: 45),
      ChartSampleData(
          x: 'Mar', y: 50, secondSeriesYValue: 39, thirdSeriesYValue: 48),
    ];
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
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Image.asset(
            'assets/new Updated images/AppIcon.gif',
            width: 60,
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: FutureBuilder<dynamic>(
                  future: LineChartfuturecall,
                  builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snapshot,
                      ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SpinKitWave(
                        color: Colors.blue,
                        size: 18,
                      );
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        return Column(
                          children: [
                            Card(
                              elevation: 5,
                              child: SfCircularChart(legend: Legend(isVisible: true),
                                  title: ChartTitle(text: 'Comments Data In Youtube'),
                                  borderColor: Colors.blue,
                                  tooltipBehavior: _tooltipBehavior1,
                                  palette: [
                                    Colors.yellow,
                                    Colors.yellowAccent,
                                    Color.fromRGBO(
                                        218, 40, 36, 0),
                                  ],
                                  series: <PieSeries<ChartSampleData, String>>[
                                    PieSeries<ChartSampleData, String>(
                                        explode: true,
                                        explodeIndex: 0,
                                        explodeOffset: '10%',
                                        dataSource: <ChartSampleData>[
                                          ...TwitterPiegraphChartData
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
                                        dataLabelMapper:
                                            (ChartSampleData data, _) => data.text,
                                        startAngle: 90,
                                        endAngle: 90,
                                        dataLabelSettings: const DataLabelSettings(
                                            isVisible: true)),
                                  ]),
                            ),
                            Card(
                              elevation: 5,
                              child:
                              SfFunnelChart(
                                  legend: Legend(isVisible: true),
                                  borderColor: Colors.blue,
                                  palette: [
                                    Colors.yellow,
                                    Colors.yellowAccent,
                                    Color.fromRGBO(
                                        218, 40, 36, 0),
                                  ],
                                  title: ChartTitle(text:'Views Data In Twitter'),
                                  tooltipBehavior: TooltipBehavior(enable: true),
                                  series: FunnelSeries<ChartSampleData, String>(
                                      dataSource: <ChartSampleData>[
                                        ...TwitterFunnelgraphChartData,
                                      ],
                                      xValueMapper: (ChartSampleData data, _) =>
                                      data.x as String,
                                      yValueMapper: (ChartSampleData data, _) =>
                                      data.y,
                                      /*  explode: isCardView ? false : explode,
    gapRatio: isCardView ? 0 : gapRatio,*/
                                      neckHeight: /*isCardView ? */
                                      '20%' /*: neckHeight.toString()*/ + '%',
                                      neckWidth: /*isCardView ?*/
                                      '25%' /*: neckWidth.toString()*/ + '%',
                                      dataLabelSettings: const DataLabelSettings(
                                          textStyle: TextStyle(fontSize: 8),
                                          isVisible: true))),
                            ),
                            Card(elevation: 5,
                              child: SfCartesianChart(
                                title: ChartTitle(text: 'Likes Data In Twitter'),
                                borderColor: Colors.blue,
                                //legend: Legend(isVisible: true),
                                palette: <Color>[
                                  Color(0xffff7f50),
                                  Color(0xfff0ead6),
                                  Color(0xffffd700),
                                  Color(0xff264348),
                                ],
                                plotAreaBorderWidth: 0,
                                primaryXAxis: CategoryAxis(
                                  labelStyle: const TextStyle(
                                      color: Colors.black, fontSize: 8),
                                  axisLine: const AxisLine(width: 0),
                                  labelPosition: ChartDataLabelPosition.outside,
                                  majorTickLines: const MajorTickLines(width: 0),
                                  majorGridLines: const MajorGridLines(width: 0),
                                ),
                                primaryYAxis: NumericAxis(
                                    labelStyle: const TextStyle(
                                        color: Colors.black, fontSize: 8),
                                    labelPosition: ChartDataLabelPosition.outside,
                                    isVisible: true,
                                    minimum: 0,
                                    maximum: 2500),
                                series: <ColumnSeries<ChartSampleData, String>>[
                                  ColumnSeries<ChartSampleData, String>(
                                    width: 0.9,
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true,
                                        labelAlignment:
                                        ChartDataLabelAlignment.top),
                                    dataSource: <ChartSampleData>[
                                      ...TwitterBargraphChartdata
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    xValueMapper: (ChartSampleData sales, _) =>
                                    sales.x as String,
                                    yValueMapper: (ChartSampleData sales, _) =>
                                    sales.y,
                                  ),
                                ],
                                tooltipBehavior: _tooltipBehavior,
                              ),
                            )
                          ],
                        );
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

//Bar Graph data
  var TwiterBarGraphdata;

  Map TwitterSelectionquery1 = new Map<String, dynamic>();
  List<ChartSampleData> TwitterBargraphChartdata = [];
  List<ChartSampleData> TwitterPiegraphChartData = [];
  List<ChartSampleData> TwitterFunnelgraphChartData = [];
  Future<dynamic> TwitterBannerGraphApi() async {

    TwitterSelectionquery1['type'] = 'party_data';
    TwitterSelectionquery1['STATE'] = 'ANDHRA PRADESH';
    TwitterSelectionquery1['party_list'] = 'TDP,YSRCP,JSP';
    //Selectionquery['channel'] = 'YOUTUBE';

    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media/'),
        body: TwitterSelectionquery1);

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('inside loop');
      try {
        print('inside try');
        TwiterBarGraphdata = jsonDecode(utf8.decode(response.bodyBytes));

        TwiterBarGraphdata['party_data'].forEach((key, value) {
          print(key);

          TwitterBargraphChartdata.add(
            ChartSampleData(
                x: '$key', y: TwiterBarGraphdata['party_data'][key][0]['LIKES']),
          );
          TwitterPiegraphChartData.add(
            ChartSampleData(
                x: '$key',
                y: TwiterBarGraphdata['party_data'][key][0]['USER_FOLLOWERS'],
                text: '$key'),
          );
          TwitterFunnelgraphChartData.add(
            ChartSampleData(
                x: '$key',
                y: TwiterBarGraphdata['party_data'][key][0]['RETWEET_COUNT'],
                text: '$key'),
          );
        });

        // for(int i=0;i<TwiterBarGraphdata['party_data'])
        // TwitterBargraphChartdata.add(ChartSampleData(x: 'TDP', y: 8683),);

        print('data here');
        print(TwiterBarGraphdata);
      } catch (e) {
        print(TwiterBarGraphdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return TwiterBarGraphdata;
  }
}


