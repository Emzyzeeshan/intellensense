import 'dart:convert';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:intellensense/Pages/DrawerScreens/CandidatureAnalysis/CandidatureAnalysis.dart';
import 'package:intellensense/SpalashScreen/widgets/ChartSampleData.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TwitterSentiment extends StatefulWidget {
  var Value;
  TwitterSentiment(this.Value,);

  @override
  State<TwitterSentiment> createState() => _TwitterSentimentState();
}

class _TwitterSentimentState extends State<TwitterSentiment> {
  List<ChartSampleData> TweetGraphData = [];
  List<ChartSampleData> CommentsGraphData = [];
  List<ChartSampleData> TweetGraphData1 = [];
  List<ChartSampleData> CommentsGraphData1 = [];
  late Future<dynamic> _value = SentimentAPI('', '', '');
  late Future<dynamic> _value1 = SelectionSentimentAPI('', '', '');
  final format = DateFormat("MM/dd/yyyy");
  TextEditingController FromDate = TextEditingController();
  TextEditingController ToDate = TextEditingController();
  PageController _pagecontroller = PageController();
  @override
  void dispose() {
    TweetGraphData.clear();
    CommentsGraphData.clear();

    Sentimentdata.clear();
    TweetGraphData1.clear();
    CommentsGraphData1.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                color: Color(0xff00196b),
                child: Center(
                  child: Text(
                    'Twitter Analysis',
                    style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 20,
                        color: Colors.white),
                  ),
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
                  return Center(
                      child: SpinKitWave(
                    color: Colors.blue,
                    size: 18,
                  ));
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
                                    'assets/icons/FollowersEmoji.png',
                                    '${Sentimentdata['user_info']['USER_FOLLOWERS']}'),
                                SocialInfoCard('assets/icons/LikesEmoji.png',
                                    '${Sentimentdata['user_info']['LIKES']}'),
                                SocialInfoCard('assets/icons/RetweetEmoji.png',
                                    '${Sentimentdata['user_info']['RETWEETS_COUNT']}'),
                                SocialInfoCard(
                                    'assets/icons/FollowersEmoji.png',
                                    '${Sentimentdata['user_info']['USER_MENTIONS']}'),
                                SocialInfoCard('assets/icons/HashTagsEmoji.png',
                                    '${Sentimentdata['user_info']['HASHTAG_COUNT']}'),
                                SocialInfoCard('assets/icons/TweetsEmoji.png',
                                    '${Sentimentdata['user_info']['TWEET_COUNT']}'),
                              ],
                            ),
                            Card(
                              elevation: 5,
                              child: SfCircularChart(
                                title: ChartTitle(
                                    text: 'Tweet Sentiment Analysis'),
                                legend: Legend(isVisible: true),
                                series: <PieSeries<ChartSampleData, String>>[
                                  PieSeries<ChartSampleData, String>(
                                      explode: true,
                                      explodeIndex: 0,
                                      explodeOffset: '10%',
                                      dataSource: TweetGraphData,
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
                    TweetGraphData1.clear();
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
                return Center(
                    child: SpinKitWave(
                  color: Colors.blue,
                  size: 18,
                ));
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            ' Analysis from ${FromDate.text} to ${ToDate.text}',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SocialInfoCard('assets/icons/FollowersEmoji.png',
                                  '${SelectionSentimentdata['user_info']['USER_FOLLOWERS']}'),
                              SocialInfoCard('assets/icons/LikesEmoji.png',
                                  '${SelectionSentimentdata['user_info']['LIKES']}'),
                              SocialInfoCard('assets/icons/RetweetEmoji.png',
                                  '${SelectionSentimentdata['user_info']['RETWEETS_COUNT']}'),
                              SocialInfoCard('assets/icons/FollowersEmoji.png',
                                  '${SelectionSentimentdata['user_info']['USER_MENTIONS']}'),
                              SocialInfoCard('assets/icons/HashTagsEmoji.png',
                                  '${SelectionSentimentdata['user_info']['HASHTAG_COUNT']}'),
                              SocialInfoCard('assets/icons/TweetsEmoji.png',
                                  '${SelectionSentimentdata['user_info']['TWEET_COUNT']}'),
                            ],
                          ),
                          Card(
                            elevation: 5,
                            child: SfCircularChart(
                              title:
                                  ChartTitle(text: 'Tweet Sentiment Analysis'),
                              legend: Legend(isVisible: true),
                              series: <PieSeries<ChartSampleData, String>>[
                                PieSeries<ChartSampleData, String>(
                                    explode: true,
                                    explodeIndex: 0,
                                    explodeOffset: '10%',
                                    dataSource: TweetGraphData1,
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
      query['social_handle'] = 'TWITTER';
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
            i < Sentimentdata['Tweet Sentiment Analysis'].length;
            i++) {
          TweetGraphData.add(
            ChartSampleData(
                x:
                    '${Sentimentdata['Tweet Sentiment Analysis'][i]['TWEET_SENTIMENT_RESULT']}',
                y: Sentimentdata['Tweet Sentiment Analysis'][i]
                    ['SENTIMENT_COUNT'],
                text:
                    '${Sentimentdata['Tweet Sentiment Analysis'][i]['TWEET_SENTIMENT_RESULT']}  ${Sentimentdata['Tweet Sentiment Analysis'][i]['PERCENTAGE']}%'),
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
      Selectionquery['social_handle'] = 'TWITTER';
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
            i < SelectionSentimentdata['Tweet Sentiment Analysis'].length;
            i++) {
          TweetGraphData1.add(
            ChartSampleData(
                x:
                    '${SelectionSentimentdata['Tweet Sentiment Analysis'][i]['TWEET_SENTIMENT_RESULT']}',
                y: SelectionSentimentdata['Tweet Sentiment Analysis'][i]
                    ['SENTIMENT_COUNT'],
                text:
                    '${SelectionSentimentdata['Tweet Sentiment Analysis'][i]['TWEET_SENTIMENT_RESULT']}  ${SelectionSentimentdata['Tweet Sentiment Analysis'][i]['PERCENTAGE']}%'),
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
