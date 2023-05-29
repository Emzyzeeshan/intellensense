import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:intellensense/SpalashScreen/widgets/ChartSampleData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class YoutubeHashTagInfo extends StatefulWidget {
  var choosenhashtag;
  YoutubeHashTagInfo(this.choosenhashtag, );

  @override
  State<YoutubeHashTagInfo> createState() => _YoutubeHashTagInfoState();
}

class _YoutubeHashTagInfoState extends State<YoutubeHashTagInfo> {
  List<ChartSampleData> chartData = [];

  @override
  void initState() {

    print(widget.choosenhashtag);

    super.initState();
  }

  @override
  void dispose() {
    chartData.clear();
    super.dispose();
  }

  late Future<dynamic> _value1 = DashboardApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xffd2dfff),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder<dynamic>(
              future: _value1,
              builder: (
                  BuildContext context,
                  AsyncSnapshot<dynamic> snapshot,
                  ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: SpinKitWave(
                        color: Colors.blue,
                        size: 18,
                      ));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return Card(
                      elevation: 7,
                      child:SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        title: ChartTitle(
                            text: '${widget.choosenhashtag} Analysis'),
                        legend: Legend(isVisible: true),
                        primaryXAxis: CategoryAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                            labelPlacement: LabelPlacement.onTicks),
                        primaryYAxis: NumericAxis(
                            minimum: 0,
                            maximum: 5,
                            axisLine: const AxisLine(width: 0),
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            labelFormat: '',
                            majorTickLines: const MajorTickLines(size: 0)),
                        series: <SplineSeries<ChartSampleData, String>>[
                          SplineSeries<ChartSampleData, String>(
                            dataSource: chartData,
                            xValueMapper: (ChartSampleData sales, _) =>
                            sales.x as String,
                            yValueMapper: (ChartSampleData sales, _) => sales.y,
                            markerSettings: const MarkerSettings(isVisible: true),
                            name: 'Count',
                          ),
                        ],
                        tooltipBehavior: TooltipBehavior(enable: true),
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
          ]),
    );
  }

//API
  var Dashboarddata;
  Map query = new Map<String, dynamic>();
  Future<dynamic> DashboardApi() async {
    setState(() {
      query['candidate_name'] = '${widget.choosenhashtag}';
      query['channel'] = 'YOUTUBE';
      query['type'] = 'channel_videos';
    });

    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6656/active_youtube_channel/'),
        body: query);

    if (response.statusCode == 200) {
      setState(() {
        Dashboarddata = json.decode(response.body);
      });
      for (int i = 0; i < Dashboarddata['channel_videos'].length; i++) {
        chartData.add(ChartSampleData(
          x: '${Dashboarddata['channel_videos'][i]['PUBLISHED_DATE']}'
              .substring(0, 10),
          y: Dashboarddata['channel_videos'][i]['COUNT'],
        ));
      }
      print(Dashboarddata);
    } else {
      print(response.reasonPhrase);
    }
    return Dashboarddata;
  }
}
