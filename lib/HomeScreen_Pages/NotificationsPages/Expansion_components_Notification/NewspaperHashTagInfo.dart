import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:intellensense/LoginPages/widgets/ChartSampleData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NewspaperHashTagInfo extends StatefulWidget {
  var choosenhashtag;
  NewspaperHashTagInfo(this.choosenhashtag, );

  @override
  State<NewspaperHashTagInfo> createState() => _NewspaperHashTagInfoState();
}

class _NewspaperHashTagInfoState extends State<NewspaperHashTagInfo> {
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
    return Scaffold(
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
                      child:SfCartesianChart(    backgroundColor: Color(0xff86a8e7).withOpacity(0.5),
                        plotAreaBorderWidth: 0,
                        title: ChartTitle(
                            text: '${widget.choosenhashtag} Analysis'),
                        legend: Legend(isVisible: true),
                        primaryXAxis: CategoryAxis(labelRotation: 90,
                            majorGridLines: const MajorGridLines(width: 0),
                            labelPlacement: LabelPlacement.onTicks),
                        primaryYAxis: NumericAxis(
                            minimum: min.toDouble(),
                            maximum: max.toDouble(),
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
    List COUNT=[];
var max;
var min;
  Map query = new Map<String, dynamic>();
  Future<dynamic> DashboardApi() async {
    setState(() {
      query['candidate_name'] = '${widget.choosenhashtag}';
      //query['channel'] = 'YOUTUBE';
      query['type'] = 'news_channel';
    });

    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6656/active_news_channel/'),
        body: query);

    if (response.statusCode == 200) {
      setState(() {
        Dashboarddata = json.decode(response.body);
      });
      for (int i = 0; i < Dashboarddata['channel_videos'].length; i++) {
        chartData.add(ChartSampleData(
          x: '${Dashboarddata['channel_videos'][i]['PUBLISHED_DATE']}'
              .substring(5, 10),
          y: Dashboarddata['channel_videos'][i]['COUNT'],
        ));
        COUNT.add(Dashboarddata['channel_videos'][i]['COUNT']);
            
      }
       print(COUNT.reduce((curr, next) => curr > next? curr: next));
      max=COUNT.reduce((curr, next) => curr > next? curr: next);
      min=COUNT.reduce((curr, next) => curr < next? curr: next);
       print(COUNT.reduce((curr, next) => curr < next? curr: next));
      print(Dashboarddata);
    } else {
      print(response.reasonPhrase);
    }
    return Dashboarddata;
  }
}
