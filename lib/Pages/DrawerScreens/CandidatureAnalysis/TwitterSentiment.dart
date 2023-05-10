import 'dart:convert';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:intellensense/SpalashScreen/widgets/ChartSampleData.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TwitterSentiment extends StatefulWidget {
  var Value;
  TwitterSentiment(this.Value, {super.key});

  @override
  State<TwitterSentiment> createState() => _TwitterSentimentState();
}

class _TwitterSentimentState extends State<TwitterSentiment> {
  List<ChartSampleData> TweetGraphData = [];
  List<ChartSampleData> CommentsGraphData = [];
  late Future<dynamic> _value = SentimentAPI();
  final format = DateFormat("MM/dd/yyyy");
  TextEditingController FromDate = TextEditingController();
  TextEditingController ToDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ExpansionTileCard(
                      baseColor: Colors.cyan[50],
                      expandedColor: Colors.white,
                      leading: Text('Last seven days analysis'),
                      // Text(
                      //     '${Sentimentdata['Tweet Sentiment Analysis'][0]['TWEET_SENTIMENT_RESULT']}'),
                      title: Container(),
                      children: [
                        FutureBuilder<dynamic>(
                          future: _value,
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<dynamic> snapshot,
                          ) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: SpinKitWave(
                                color: Colors.blue,
                                size: 18,
                              ));
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Text('Error');
                              } else if (snapshot.hasData) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SocialInfoCard(
                                              'assets/icons/FollowersEmoji.png',
                                              '${Sentimentdata['user_info']['USER_FOLLOWERS']}'),
                                          SocialInfoCard(
                                              'assets/icons/LikesEmoji.png',
                                              '${Sentimentdata['user_info']['LIKES']}'),
                                          SocialInfoCard(
                                              'assets/icons/RetweetEmoji.png',
                                              '${Sentimentdata['user_info']['RETWEETS_COUNT']}'),
                                          SocialInfoCard(
                                              'assets/icons/FollowersEmoji.png',
                                              '${Sentimentdata['user_info']['USER_MENTIONS']}'),
                                          SocialInfoCard(
                                              'assets/icons/HashTagsEmoji.png',
                                              '${Sentimentdata['user_info']['HASHTAG_COUNT']}'),
                                          SocialInfoCard(
                                              'assets/icons/TweetsEmoji.png',
                                              '${Sentimentdata['user_info']['TWEET_COUNT']}'),
                                        ],
                                      ),
                                      SfCircularChart(
                                        title: ChartTitle(
                                            text: 'Tweet Sentiment Analysis'),
                                        legend: Legend(isVisible: true),
                                        series: <
                                            PieSeries<ChartSampleData, String>>[
                                          PieSeries<ChartSampleData, String>(
                                              explode: true,
                                              explodeIndex: 0,
                                              explodeOffset: '10%',
                                              dataSource: TweetGraphData,
                                              xValueMapper:
                                                  (ChartSampleData data, _) =>
                                                      data.x as String,
                                              yValueMapper:
                                                  (ChartSampleData data, _) =>
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
                                      Divider(
                                        color: Colors.grey.shade300,
                                        thickness: 1,
                                      ),
                                      SfCircularChart(
                                        title: ChartTitle(
                                            text:
                                                'Comments Sentiment Analysis'),
                                        legend: Legend(isVisible: true),
                                        series: <
                                            PieSeries<ChartSampleData, String>>[
                                          PieSeries<ChartSampleData, String>(
                                              explode: true,
                                              explodeIndex: 0,
                                              explodeOffset: '10%',
                                              dataSource: CommentsGraphData,
                                              xValueMapper:
                                                  (ChartSampleData data, _) =>
                                                      data.x as String,
                                              yValueMapper:
                                                  (ChartSampleData data, _) =>
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
                                    ]);
                              } else {
                                return const Text('Empty data');
                              }
                            } else {
                              return Text('State: ${snapshot.connectionState}');
                            }
                          },
                        ),
                      ])),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ExpansionTileCard(
                      baseColor: Colors.cyan[50],
                      expandedColor: Colors.white,
                      leading: Text('Select duration for analysis'),
                      // Text(
                      //     '${Sentimentdata['Tweet Sentiment Analysis'][0]['TWEET_SENTIMENT_RESULT']}'),
                      title: Container(),
                      children: [
                        FutureBuilder<dynamic>(
                          future: _value,
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<dynamic> snapshot,
                          ) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: SpinKitWave(
                                size: 18,
                              ));
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Text('Error');
                              } else if (snapshot.hasData) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'From: ',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  DateTimeField(
                                                    controller: FromDate,
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        hintText: 'mm/dd/yyyy',
                                                        isDense: true,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderSide: BorderSide
                                                                    .none,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        fillColor: Colors.white,
                                                        focusColor:
                                                            Colors.grey),
                                                    format: format,
                                                    onShowPicker: (context,
                                                        currentValue) {
                                                      return showDatePicker(
                                                          context: context,
                                                          firstDate:
                                                              DateTime(1900),
                                                          initialDate:
                                                              currentValue ??
                                                                  DateTime
                                                                      .now(),
                                                          lastDate:
                                                              DateTime(2100));
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'To : ',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  DateTimeField(
                                                    controller: ToDate,
                                                    decoration: InputDecoration(
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide
                                                                        .none,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        filled: true,
                                                        hintText: 'mm/dd/yyyy',
                                                        isDense: true,
                                                        fillColor: Colors.white,
                                                        focusColor:
                                                            Colors.grey),
                                                    format: format,
                                                    onShowPicker: (context,
                                                        currentValue) {
                                                      return showDatePicker(
                                                          context: context,
                                                          firstDate:
                                                              DateTime(1900),
                                                          initialDate:
                                                              currentValue ??
                                                                  DateTime
                                                                      .now(),
                                                          lastDate:
                                                              DateTime(2100));
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]);
                              } else {
                                return const Text('Empty data');
                              }
                            } else {
                              return Text('State: ${snapshot.connectionState}');
                            }
                          },
                        ),
                      ])),
            ),
          ],
        ),
      ),
    );
  }

  //sentiment APi
  var Sentimentdata;
  Map query = new Map<String, dynamic>();
  Future<dynamic> SentimentAPI() async {
    setState(() {
      query['social_handle'] = 'TWITTER';
      query['candidate_name'] = '${widget.Value['name']}';
      query['type'] = '';
      query['today1'] = '';
      query['yesterday1'] = '';
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
              i < Sentimentdata['Tweet Sentiment Analysis'].length;
              i++) {
            CommentsGraphData.add(
              ChartSampleData(
                  x:
                      '${Sentimentdata['Comment Sentiment Analysis'][i]['TWEET_SENTIMENT_RESULT']}',
                  y: Sentimentdata['Comment Sentiment Analysis'][i]
                      ['SENTIMENT_COUNT'],
                  text:
                      '${Sentimentdata['Comment Sentiment Analysis'][i]['TWEET_SENTIMENT_RESULT']}  ${Sentimentdata['Tweet Sentiment Analysis'][i]['PERCENTAGE']}%'),
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

  SocialInfoCard(String imagepath, String info) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Container(
            height: 30,
            width: 30,
            child: Image.asset(
              imagepath,
              height: 30,
              width: 30,
            ),
          ),
          SizedBox(
            width: 2,
          ),
          Text(info)
        ],
      ),
    );
  }
}
