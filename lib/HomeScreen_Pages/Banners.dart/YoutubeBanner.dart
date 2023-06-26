import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intellensense/LoginPages/widgets/ChartSampleData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Youtubebanner extends StatefulWidget {
  const Youtubebanner({Key? key}) : super(key: key);

  @override
  State<Youtubebanner> createState() => _YoutubebannerState();
}

class _YoutubebannerState extends State<Youtubebanner> {
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        format: 'point.x : point.y sq.km',
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
                  Color(0xFFE57373),
                Color(0xffe4e0f8),
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
                        left: 125,
                        
                        child: DefaultTextStyle(
      style: const TextStyle(
        fontSize: 25.0,
        fontFamily: 'Segoe UI',
      ),
      child: AnimatedTextKit(repeatForever: true,
        animatedTexts: [
          RotateAnimatedText('YOUTUBE',textStyle:  TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Segoe UI')),
          RotateAnimatedText('BATTLE',textStyle:  TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Segoe UI')),
          
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
                            'assets/icons/youtubedxps.png',
                            height: 100,
                            width: 100,
                          )),
                      Positioned(
                          top: 105,
                          left: 230,
                          child: Container(
                            height: 145,
                            width: 145,
                            child: SfCircularChart(palette: [
                              Color(0xff900d09),
                              Color(0xffb90e0a),
                              Color(0xff66ffe6),
                              Color(0xffc6dff6),
                              Color(0xff725138)
                            ], series: <PieSeries<ChartSampleData, String>>[
                              PieSeries<ChartSampleData, String>(
                                  explode: true,
                                  explodeIndex: 0,
                                  explodeOffset: '10%',
                                  dataSource: <ChartSampleData>[
                                    ChartSampleData(
                                        x: 'David', y: 13, text: 'Dav \n 13%'),
                                    ChartSampleData(
                                        x: 'Steve', y: 24, text: 'Ste\n 24%'),
                                    ChartSampleData(
                                        x: 'Jack', y: 25, text: 'Jack \n 25%'),
                                    ChartSampleData(
                                        x: 'Others',
                                        y: 38,
                                        text: 'Other \n 38%'),
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
                          top: 0,
                          left: 230,
                          child: Container(
                            height: 135,
                            width: 135,
                            child: SfCartesianChart(
                              palette: <Color>[
                                Color(0xfff55145),
                                Color(0xfff0ead6),
                                Color(0xffffd700),
                                Color(0xff264348),
                              ],
                              plotAreaBorderWidth: 0,
                              primaryXAxis: CategoryAxis(
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                axisLine: const AxisLine(width: 0),
                                labelPosition: ChartDataLabelPosition.inside,
                                majorTickLines: const MajorTickLines(width: 0),
                                majorGridLines: const MajorGridLines(width: 0),
                              ),
                              primaryYAxis: NumericAxis(
                                  isVisible: false, minimum: 0, maximum: 9000),
                              series: <ColumnSeries<ChartSampleData, String>>[
                                ColumnSeries<ChartSampleData, String>(
                                  width: 0.9,
                                  dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                      labelAlignment:
                                          ChartDataLabelAlignment.top),
                                  dataSource: <ChartSampleData>[
                                    ChartSampleData(x: 'TDP', y: 8683),
                                    ChartSampleData(x: 'TRS', y: 6993),
                                    ChartSampleData(x: 'BRS', y: 5498),
                                    ChartSampleData(x: 'BJP', y: 5083),
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
                          )),
                      Positioned(
                        left: 22,
                        top: 150,
                        child: Container(
                          width: 230,
                          child: RichText(
                            text: new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text:
                                        'With Huge Difference In counts for Tweets and Re-Tweets reports says that ',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Segoe UI')),
                                new TextSpan(
                                    text: 'JSP',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontSize: 25, fontFamily: 'Segoe UI')),
                                new TextSpan(
                                    text:
                                        ' is relatively Dominant in Twitter Data',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Segoe UI')),
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
}
