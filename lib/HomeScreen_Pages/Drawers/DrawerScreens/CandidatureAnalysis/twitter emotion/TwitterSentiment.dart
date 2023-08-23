import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:intellensense/LoginPages/widgets/ChartSampleData.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Candidature Analysis/PartyMemberDetails.dart';
import '../CandidatureAnalysis.dart';

class TwitterSentiment extends StatefulWidget {
  var Value;
  TwitterSentiment(
    this.Value,
  );

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
  late Future<dynamic> cloud = TwitterwordcloudApi();
  final format = DateFormat("MM/dd/yyyy");
  TextEditingController FromDate = TextEditingController();
  TextEditingController ToDate = TextEditingController();
  PageController _pagecontroller = PageController();
  @override
  void initState(){
    super.initState();
  }
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(Icons.arrow_back_ios,color: Colors.black,),),
        title: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.6,
              height: 30,
              color:Color(0xff86a8e7),
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
        Spacer(),
            FutureBuilder<dynamic>(
              future: cloud,
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
                    return OpenContainer(
                      closedColor: Color(0xffd2dfff),
                      openColor: Color(0xffd2dfff),
                      /*closedElevation: 10.0,*/
                      /*    openElevation: 10.0,*/
                      closedShape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0)),
                      ),
                      transitionType: ContainerTransitionType.fade,
                      transitionDuration:
                      const Duration(milliseconds: 1200),
                      openBuilder: (context, action) {
                        return SafeArea(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    color: Colors.grey.shade700,
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                              Container(
                                height: 500,
                                  decoration: BoxDecoration(image: DecorationImage(
                                      image: MemoryImage(
                                          base64Decode(Twitterwordcloud[0]
                                              .replaceAll(RegExp(r'\s+'), ''
                                          ),
                                          )
                                      )),
                                  )),
                            ],
                          ),
                        );
                      },
                      closedBuilder: (context, action) {
                        return Image.asset('assets/new Updated images/WordCloud.png',height: 40,);
                      },
                    );
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            ),
                //icon: Image.asset('assets/new Updated images/WordCloud.png'))
          ],
        ),
              centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8),
            child: Column(
              children: [
                
                
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: PageView(
                        physics: NeverScrollableScrollPhysics(),
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
        ),
      ),
    );
  }

  LastSevenDaysAnalysis() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Last seven days analysis',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SocialInfoCard(
                                      'assets/icons/FollowersEmoji.png',
                                      '${Sentimentdata['user_info']['USER_FOLLOWERS']}'),
                                  SocialInfoCard('assets/icons/LikesEmoji.png',
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
                                  SocialInfoCard('assets/icons/TweetsEmoji.png',
                                      '${Sentimentdata['user_info']['TWEET_COUNT']}'),
                                ],
                              ),
                              Card(
                                elevation: 5,
                                child: SfCircularChart(backgroundColor: Color(0xff86a8e7).withOpacity(0.4),
                                  title: ChartTitle(
                                      text: 'Tweet Sentiment Analysis'),
                                  legend: Legend(isVisible: true),
                                  series: <PieSeries<ChartSampleData, String>>[
                                    PieSeries<ChartSampleData, String>(
                                        explode: true,
                                        explodeIndex: 0,
                                        explodeOffset: '10%',
                                        dataSource: TweetGraphData,
                                        xValueMapper:
                                            (ChartSampleData data, _) =>
                                                data.x as String,
                                        yValueMapper:
                                            (ChartSampleData data, _) => data.y,
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
                                child: SfCircularChart(backgroundColor: Color(0xff86a8e7).withOpacity(0.4),
                                  title: ChartTitle(
                                      text: 'Comments Sentiment Analysis'),
                                  legend: Legend(isVisible: true),
                                  series: <PieSeries<ChartSampleData, String>>[
                                    PieSeries<ChartSampleData, String>(
                                        explode: true,
                                        explodeIndex: 0,
                                        explodeOffset: '10%',
                                        dataSource: CommentsGraphData,
                                        xValueMapper:
                                            (ChartSampleData data, _) =>
                                                data.x as String,
                                        yValueMapper:
                                            (ChartSampleData data, _) => data.y,
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
                              Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                     
                        _pagecontroller.jumpToPage(1);
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                    color:Color(0xff86a8e7),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Custom Analysis',
                            style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          Icon(
                              Icons.navigate_next_outlined,
                            size: 25,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
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
      ),
    );
  }

  //Select duration for analysis
  Selectdurationforanalysis() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:100.0),
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
                    color: Color(0xff86a8e7),
                  )
                ],
              ),
              SafeArea(
                child: FutureBuilder<dynamic>(
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
                        return SingleChildScrollView(
                          child: Padding(
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
                                    child: SfCircularChart(backgroundColor: Color(0xff86a8e7).withOpacity(0.4),
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
                                    child: SfCircularChart(backgroundColor: Color(0xff86a8e7).withOpacity(0.4),
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
             Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                           
                              _pagecontroller.jumpToPage(0);
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 30,
                          color:Color(0xff86a8e7),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                    Icons.navigate_before,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Recent Analysis',
                                  style: TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                                
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
  var Twitterwordcloud;
  Future<dynamic> TwitterwordcloudApi() async {
    // String partylist=locallist.join(",");
print('in');
    setState(() {
      query['social_handle'] = 'TWITTER_LEADER';
      query['name'] = '${widget.Value['name']}';
      query['start_date'] = '2023-01-20';
      query['end_date'] = '2023-01-23';
    });

    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6649/word_cloud/'),
        body: query);


    if (response.statusCode == 200) {
      print(response.statusCode);
      try {
        Twitterwordcloud = jsonDecode(utf8.decode(response.bodyBytes));
        print(Twitterwordcloud.toString());
        /*setState(() {
          istablevisible = true;
          statedropdownvisible = true;
          for (int i = 0;
          i < YoutubeTopPartylistdata['top_parties'].length;
          i++) {
            Youtubetablecolumn.add(
              DataColumn(
                label: Text(
                  '${YoutubeTopPartylistdata['top_parties'][i]}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        }*/
      } catch (e) {
        print(Twitterwordcloud.toString());
        print('error');
        print(Twitterwordcloud);
      }
    } else {
      print('success');
      print(response.reasonPhrase);
    }
    return Twitterwordcloud;
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
