import 'dart:convert';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:intellensense/Pages/DrawerScreens/CandidatureAnalysis/CandidatureAnalysis.dart';
import 'package:intellensense/SpalashScreen/widgets/ChartSampleData.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class YoutubeSentiment extends StatefulWidget {
  var Value;
  YoutubeSentiment(this.Value, {super.key});

  @override
  State<YoutubeSentiment> createState() => _YoutubeSentimentState();
}

class _YoutubeSentimentState extends State<YoutubeSentiment> {
  List<ChartSampleData> YoutubeGraphData = [];
  List<ChartSampleData> CommentsGraphData = [];
  List<ChartSampleData> YoutubeGraphData1 = [];
  List<ChartSampleData> CommentsGraphData1 = [];
  late Future<dynamic> _value = SentimentAPI('', '', '');
  late Future<dynamic> _value1 = SelectionSentimentAPI('', '', '');
  final format = DateFormat("MM/dd/yyyy");
  TextEditingController FromDate = TextEditingController();
  TextEditingController ToDate = TextEditingController();
  PageController _pagecontroller = PageController();
  @override
  void dispose() {
    YoutubeGraphData.clear();
    CommentsGraphData.clear();
    SelectionSentimentdata.clear();
    Sentimentdata.clear();
    YoutubeGraphData1.clear();
    CommentsGraphData1.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Youtube Analysis',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: PageView(
                    controller: _pagecontroller,
                    children: [
                      LastSevenDaysAnalysis(),
                      Selectdurationforanalysis(),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  LastSevenDaysAnalysis() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            ' Last seven days analysis',
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 16,
            ),
          ),
          Center(
            child: FutureBuilder<dynamic>(
              future: _value,
              builder: (
                BuildContext context,
                AsyncSnapshot<dynamic> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SpinKitWave(
                        color: Colors.blue,
                        size: 18,
                      ),
                    ],
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SocialInfoCard(
                                    'assets/icons/Video ViewsEmoji.png', '0'),
                                SocialInfoCard(
                                    'assets/icons/Video LikesEmoji.png', '1'),
                                SocialInfoCard(
                                    'assets/icons/Video DislikesEmoji.png',
                                    '2'),
                                SocialInfoCard(
                                    'assets/icons/Video CommentsEmoji.png',
                                    '3'),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset(
                                          'assets/icons/Video LikesEmoji.png',
                                          height: 30,
                                          width: 30,
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text('5')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset(
                                          'assets/icons/Video DislikesEmoji.png',
                                          height: 30,
                                          width: 30,
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text('6')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Card(
                              elevation: 5,
                              child: SfCircularChart(
                                title: ChartTitle(
                                    text: 'Youtube Sentiment Analysis'),
                                legend: Legend(isVisible: true),
                                series: <PieSeries<ChartSampleData, String>>[
                                  PieSeries<ChartSampleData, String>(
                                      explode: true,
                                      explodeIndex: 0,
                                      explodeOffset: '10%',
                                      dataSource: YoutubeGraphData,
                                      xValueMapper: (ChartSampleData data, _) =>
                                          data.x as String,
                                      yValueMapper: (ChartSampleData data, _) =>
                                          data.y,
                                      dataLabelMapper:
                                          (ChartSampleData data, _) =>
                                              data.text,
                                      startAngle: 90,
                                      endAngle: 90,
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                              isVisible: true)),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                            Card(
                              elevation: 5,
                              child: SfCircularChart(
                                title: ChartTitle(
                                    text: 'Comments Sentiment Analysis'),
                                legend: Legend(isVisible: true),
                                series: <PieSeries<ChartSampleData, String>>[
                                  PieSeries<ChartSampleData, String>(
                                      explode: true,
                                      explodeIndex: 0,
                                      explodeOffset: '10%',
                                      dataSource: CommentsGraphData,
                                      xValueMapper: (ChartSampleData data, _) =>
                                          data.x as String,
                                      yValueMapper: (ChartSampleData data, _) =>
                                          data.y,
                                      dataLabelMapper:
                                          (ChartSampleData data, _) =>
                                              data.text,
                                      startAngle: 90,
                                      endAngle: 90,
                                      dataLabelSettings:
                                          const DataLabelSettings(
                                              isVisible: true)),
                                ],
                              ),
                            ),
                          ]),
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
        ],
      ),
    );
  }

  //Select duration for analysis
  Selectdurationforanalysis() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Select duration for analysis',
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'From: ',
                        style: TextStyle(color: Colors.black),
                      ),
                      DateTimeField(
                        controller: FromDate,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: 'mm/dd/yyyy',
                            isDense: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                            fillColor: Colors.white,
                            focusColor: Colors.grey),
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'To : ',
                        style: TextStyle(color: Colors.black),
                      ),
                      DateTimeField(
                        controller: ToDate,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5)),
                            filled: true,
                            hintText: 'mm/dd/yyyy',
                            isDense: true,
                            fillColor: Colors.white,
                            focusColor: Colors.grey),
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  setState(() {
                    YoutubeGraphData1.clear();
                    CommentsGraphData1.clear();

                    SelectionSentimentdata.clear();
                    _value1 = SelectionSentimentAPI(
                        'between', '${ToDate.text}', '${FromDate.text}');
                  });
                },
                child: Text('Search'),
                color: Colors.blueAccent,
              )
            ],
          ),
          FutureBuilder<dynamic>(
            future: _value1,
            builder: (
              BuildContext context,
              AsyncSnapshot<dynamic> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SpinKitWave(
                      color: Colors.blue,
                      size: 18,
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //todo:cards
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SocialInfoCard(
                                  'assets/icons/Video ViewsEmoji.png', '0'),
                              SocialInfoCard(
                                  'assets/icons/Video LikesEmoji.png', '1'),
                              SocialInfoCard(
                                  'assets/icons/Video DislikesEmoji.png', '2'),
                              SocialInfoCard(
                                  'assets/icons/Video CommentsEmoji.png', '3'),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset(
                                        'assets/icons/Video LikesEmoji.png',
                                        height: 30,
                                        width: 30,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('4')
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset(
                                        'assets/icons/Video DislikesEmoji.png',
                                        height: 30,
                                        width: 30,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('5')
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Card(
                            elevation: 5,
                            child: SfCircularChart(
                              title: ChartTitle(
                                  text: 'Youtube Sentiment Analysis'),
                              legend: Legend(isVisible: true),
                              series: <PieSeries<ChartSampleData, String>>[
                                PieSeries<ChartSampleData, String>(
                                    explode: true,
                                    explodeIndex: 0,
                                    explodeOffset: '10%',
                                    dataSource: YoutubeGraphData1,
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
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                          Card(
                            elevation: 5,
                            child: SfCircularChart(
                              title: ChartTitle(
                                  text: 'Comments Sentiment Analysis'),
                              legend: Legend(isVisible: true),
                              series: <PieSeries<ChartSampleData, String>>[
                                PieSeries<ChartSampleData, String>(
                                    explode: true,
                                    explodeIndex: 0,
                                    explodeOffset: '10%',
                                    dataSource: CommentsGraphData1,
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
                              ],
                            ),
                          ),
                        ]),
                  );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
        ],
      ),
    );
  }

  // Last Seven sentiment APi
  var Sentimentdata;
  Map query = new Map<String, dynamic>();
  Future<dynamic> SentimentAPI(
      String type, String today1, String yesterday1) async {
    setState(() {
      query['social_handle'] = 'YOUTUBE';
      query['candidate_name'] = '${widget.Value['name']}';
      query['type'] = type;
      query['today1'] = today1;
      query['yesterday1'] = yesterday1;
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6652/candidature_analysis/'),
        body: query);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        Sentimentdata = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0;
            i < Sentimentdata['Youtube Sentiment Analysis'].length;
            i++) {
          YoutubeGraphData.add(
            ChartSampleData(
                x:
                    '${Sentimentdata['Youtube Sentiment Analysis'][i]['TWEET_SENTIMENT_RESULT']}',
                y: Sentimentdata['Youtube Sentiment Analysis'][i]
                    ['SENTIMENT_COUNT'],
                text:
                    '${Sentimentdata['Youtube Sentiment Analysis'][i]['TWEET_SENTIMENT_RESULT']}  ${Sentimentdata['Youtube Sentiment Analysis'][i]['PERCENTAGE']}%'),
          );
        }

        if (Sentimentdata['Comment Sentiment Analysis'].isEmpty) {
          CommentsGraphData.add(
            ChartSampleData(x: 'N/A', y: 50, text: 'N/A'),
          );
        } else {
          for (int i = 0;
              i < Sentimentdata['Comment Sentiment Analysis'].length;
              i++) {
            CommentsGraphData.add(
              ChartSampleData(
                  x:
                      '${Sentimentdata['Comment Sentiment Analysis'][i]['TWEET_SENTIMENT_RESULT']}',
                  y: Sentimentdata['Comment Sentiment Analysis'][i]
                      ['SENTIMENT_COUNT'],
                  text:
                      '${Sentimentdata['Comment Sentiment Analysis'][i]['TWEET_SENTIMENT_RESULT']}  ${Sentimentdata['Comment Sentiment Analysis'][i]['PERCENT']}%'),
            );
          }
        }
        print(Sentimentdata);
      } catch (e) {
        print(Sentimentdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return Sentimentdata;
  }

//Selection date API
  var SelectionSentimentdata;
  Map Selectionquery = new Map<String, dynamic>();
  Future<dynamic> SelectionSentimentAPI(
      String type, String today1, String yesterday1) async {
    setState(() {
      Selectionquery['social_handle'] = 'YOUTUBE';
      Selectionquery['candidate_name'] = '${widget.Value['name']}';
      Selectionquery['type'] = type;
      Selectionquery['today1'] = today1;
      Selectionquery['yesterday1'] = yesterday1;
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6652/candidature_analysis/'),
        body: Selectionquery);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        SelectionSentimentdata = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0;
            i < SelectionSentimentdata['Youtube Sentiment Analysis'].length;
            i++) {
          YoutubeGraphData1.add(
            ChartSampleData(
                x:
                    '${SelectionSentimentdata['Youtube Sentiment Analysis'][i]['TWEET_SENTIMENT_RESULT']}',
                y: SelectionSentimentdata['Youtube Sentiment Analysis'][i]
                    ['SENTIMENT_COUNT'],
                text:
                    '${SelectionSentimentdata['Youtube Sentiment Analysis'][i]['TWEET_SENTIMENT_RESULT']}  ${SelectionSentimentdata['Youtube Sentiment Analysis'][i]['PERCENTAGE']}%'),
          );
        }

        if (SelectionSentimentdata['Comment Sentiment Analysis'].isEmpty) {
          CommentsGraphData1.add(
            ChartSampleData(x: 'N/A', y: 50, text: 'N/A'),
          );
        } else {
          for (int i = 0;
              i < SelectionSentimentdata['Comment Sentiment Analysis'].length;
              i++) {
            CommentsGraphData1.add(
              ChartSampleData(
                  x:
                      '${SelectionSentimentdata['Comment Sentiment Analysis'][i]['TWEET_SENTIMENT_RESULT']}',
                  y: SelectionSentimentdata['Comment Sentiment Analysis'][i]
                      ['SENTIMENT_COUNT'],
                  text:
                      '${SelectionSentimentdata['Comment Sentiment Analysis'][i]['TWEET_SENTIMENT_RESULT']}  ${SelectionSentimentdata['Comment Sentiment Analysis'][i]['PERCENT']}%'),
            );
          }
        }
        print(SelectionSentimentdata);
      } catch (e) {
        print(SelectionSentimentdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return SelectionSentimentdata;
  }
}
