import 'dart:convert';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intellensense/LoginPages/widgets/ChartSampleData.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../CandidatureAnalysis.dart';

class NewsChannel extends StatefulWidget {
  var Value;
  NewsChannel(this.Value, );

  @override
  State<NewsChannel> createState() => _NewsChannelState();
}

class _NewsChannelState extends State<NewsChannel> {
  final format = DateFormat("MM/dd/yyyy");
  TextEditingController FromDate = TextEditingController();
  TextEditingController ToDate = TextEditingController();
  PageController _pagecontroller = PageController();
  late Future<dynamic> _value = NewsChannelSentimentAPI('', '', '');
  late Future<dynamic> _value1 = SelectionSentimentAPI('', '', '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(Icons.arrow_back_ios,color: Colors.black,),),
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: 30,
          color:Color(0xff86a8e7),
          child: Center(
            child: Text(
              'NewsChannel Analysis',
              style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 20,
                  color: Colors.white),
            ),
          ),
        ),
              centerTitle: true,
      ),
      body: SingleChildScrollView(
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
    );
  }

  LastSevenDaysAnalysis() {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Text(
              ' Last seven days analysis',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder<dynamic>(
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
                    return Column(
                      children: [
                        Text(
                          'Sentiment Result',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SocialInfoCard('assets/icons/Video ViewsEmoji.png',
                                '${NewsChannelSentimentdata['user_info']['VIDEO_VIEWS']}'),
                            SocialInfoCard('assets/icons/Video LikesEmoji.png',
                                '${NewsChannelSentimentdata['user_info']['VIDEO_LIKES']}'),
                            SocialInfoCard(
                                'assets/icons/Video DislikesEmoji.png',
                                '${NewsChannelSentimentdata['user_info']['VIDEO_DISLIKES']}'),
                            SocialInfoCard(
                                'assets/icons/Video CommentsEmoji.png',
                                '${NewsChannelSentimentdata['user_info']['VIDEO_COMMENTS_COUNT']}'),
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
                                  Text(
                                      '${NewsChannelSentimentdata['user_info']['POSITIVE']}')
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
                                  Text(
                                      '${NewsChannelSentimentdata['user_info']['NEGATIVE']}')
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            elevation: 5,
                            child: SfCircularChart(
                              title: ChartTitle(
                                  text: 'News Channel Sentiment Analysis'),
                              legend: Legend(isVisible: true),
                              series: <PieSeries<ChartSampleData, String>>[
                                PieSeries<ChartSampleData, String>(
                                    explode: true,
                                    explodeIndex: 0,
                                    explodeOffset: '10%',
                                    dataSource: NCSentimentGraphData,
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
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            elevation: 5,
                            child: SfCircularChart(
                              title: ChartTitle(
                                  text:
                                      'News Channel Comment Sentiment Analysis'),
                              legend: Legend(isVisible: true),
                              series: <PieSeries<ChartSampleData, String>>[
                                PieSeries<ChartSampleData, String>(
                                    explode: true,
                                    explodeIndex: 0,
                                    explodeOffset: '10%',
                                    dataSource: NCcommentsSentimentGraphData,
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
          ])),
    );
  }

  Selectdurationforanalysis() {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:100.0),
          child: Column(children: [
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
                  NCSelectionSentimentGraphData.clear();
                  NCSelectioncommentsSentimentGraphData.clear();
                  _value1 = SelectionSentimentAPI(
                      'between', '${ToDate.text}', '${FromDate.text}');
                });
              },
              child: Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
              color: Color(0xff86a8e7),
            )
          ],
              ),
              Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SizedBox(
                height: 10,
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
                      return Column(
                        children: [
                          Text(
                            'Sentiment Result',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SocialInfoCard('assets/icons/Video ViewsEmoji.png',
                                  '${SelectionSentimentdata['user_info']['VIDEO_VIEWS']}'),
                              SocialInfoCard('assets/icons/Video LikesEmoji.png',
                                  '${SelectionSentimentdata['user_info']['VIDEO_LIKES']}'),
                              SocialInfoCard(
                                  'assets/icons/Video DislikesEmoji.png',
                                  '${SelectionSentimentdata['user_info']['VIDEO_DISLIKES']}'),
                              SocialInfoCard(
                                  'assets/icons/Video CommentsEmoji.png',
                                  '${SelectionSentimentdata['user_info']['VIDEO_COMMENTS_COUNT']}'),
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
                                    Text(
                                        '${SelectionSentimentdata['user_info']['POSITIVE']}')
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
                                    Text(
                                        '${SelectionSentimentdata['user_info']['NEGATIVE']}')
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Card(
                              elevation: 5,
                              child: SfCircularChart(backgroundColor: Color(0xff86a8e7).withOpacity(0.4),
                                title: ChartTitle(
                                    text: 'News Channel Sentiment Analysis'),
                                legend: Legend(isVisible: true),
                                series: <PieSeries<ChartSampleData, String>>[
                                  PieSeries<ChartSampleData, String>(
                                      explode: true,
                                      explodeIndex: 0,
                                      explodeOffset: '10%',
                                      dataSource: NCSelectionSentimentGraphData,
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
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Card(
                              elevation: 5,
                              child: SfCircularChart(
                                backgroundColor: Color(0xff86a8e7).withOpacity(0.4),
                                title: ChartTitle(
                                    text:
                                        'News Channel Comment Sentiment Analysis'),
                                legend: Legend(isVisible: true),
                                series: <PieSeries<ChartSampleData, String>>[
                                  PieSeries<ChartSampleData, String>(
                                      explode: true,
                                      explodeIndex: 0,
                                      explodeOffset: '10%',
                                      dataSource:
                                          NCSelectioncommentsSentimentGraphData,
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
                      );
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
            ])),
            ]),
        ));
  }

  //NewsChannel 7 days Seniment
  var NewsChannelSentimentdata;
  List<ChartSampleData> NCSentimentGraphData = [];
  List<ChartSampleData> NCcommentsSentimentGraphData = [];
  Map Selectionquery = new Map<String, dynamic>();
  List<TableRow> NewspaperSentimentTabledata1 = [];
  Future<dynamic> NewsChannelSentimentAPI(
      String type, String today1, String yesterday1) async {
    setState(() {
      Selectionquery['social_handle'] = 'NEWS_CHANNEL';
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
        NewsChannelSentimentdata = jsonDecode(utf8.decode(response.bodyBytes));

        for (int i = 0;
            i <
                NewsChannelSentimentdata['NEWS CHANNEL Sentiment Analysis']
                    .length;
            i++) {
          NCSentimentGraphData.add(
            ChartSampleData(
                x:
                    '${NewsChannelSentimentdata['NEWS CHANNEL Sentiment Analysis'][i]['OVERALL_SENTIMENT_ANALYSIS']}',
                y: NewsChannelSentimentdata['NEWS CHANNEL Sentiment Analysis']
                    [i]['SENTIMENT_COUNT'],
                text:
                    '${NewsChannelSentimentdata['NEWS CHANNEL Sentiment Analysis'][i]['OVERALL_SENTIMENT_ANALYSIS']} ${NewsChannelSentimentdata['NEWS CHANNEL Sentiment Analysis'][i]['PERCENTAGE']}%'),
          );
        }

        for (int i = 0;
            i < NewsChannelSentimentdata['Comment Sentiment Analysis'].length;
            i++) {
          NCcommentsSentimentGraphData.add(
            ChartSampleData(
                x:
                    '${NewsChannelSentimentdata['Comment Sentiment Analysis'][i]['OVERALL_SENTIMENT_ANALYSIS']}',
                y: NewsChannelSentimentdata['Comment Sentiment Analysis'][i]
                    ['SENTIMENT_COUNT'],
                text:
                    '${NewsChannelSentimentdata['Comment Sentiment Analysis'][i]['OVERALL_SENTIMENT_ANALYSIS']} ${NewsChannelSentimentdata['Comment Sentiment Analysis'][i]['PERCENT']}%'),
          );
        }
        print(NewsChannelSentimentdata);
      } catch (e) {
        print(NewsChannelSentimentdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return NewsChannelSentimentdata;
  }

  //News Channel Selection Sentiment
  List<ChartSampleData> NCSelectionSentimentGraphData = [];
  List<ChartSampleData> NCSelectioncommentsSentimentGraphData = [];
  List<TableRow> NewsChannelSelectionSentimentTabledata1 = [];
  var SelectionSentimentdata;
  Map query = new Map<String, dynamic>();
  Future<dynamic> SelectionSentimentAPI(
      String type, String today1, String yesterday1) async {
    setState(() {
      query['social_handle'] = 'NEWS_CHANNEL';
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
        SelectionSentimentdata = jsonDecode(utf8.decode(response.bodyBytes));

        for (int i = 0;
            i <
                SelectionSentimentdata['NEWS CHANNEL Sentiment Analysis']
                    .length;
            i++) {
          NCSelectionSentimentGraphData.add(
            ChartSampleData(
                x:
                    '${SelectionSentimentdata['NEWS CHANNEL Sentiment Analysis'][i]['OVERALL_SENTIMENT_ANALYSIS']}',
                y: SelectionSentimentdata['NEWS CHANNEL Sentiment Analysis'][i]
                    ['SENTIMENT_COUNT'],
                text:
                    '${SelectionSentimentdata['NEWS CHANNEL Sentiment Analysis'][i]['OVERALL_SENTIMENT_ANALYSIS']} ${NewsChannelSentimentdata['NEWS CHANNEL Sentiment Analysis'][i]['PERCENTAGE']}%'),
          );
        }

        for (int i = 0;
            i < SelectionSentimentdata['Comment Sentiment Analysis'].length;
            i++) {
          NCSelectioncommentsSentimentGraphData.add(
            ChartSampleData(
                x:
                    '${SelectionSentimentdata['Comment Sentiment Analysis'][i]['OVERALL_SENTIMENT_ANALYSIS']}',
                y: SelectionSentimentdata['Comment Sentiment Analysis'][i]
                    ['SENTIMENT_COUNT'],
                text:
                    '${SelectionSentimentdata['Comment Sentiment Analysis'][i]['OVERALL_SENTIMENT_ANALYSIS']} ${SelectionSentimentdata['Comment Sentiment Analysis'][i]['PERCENT']}%'),
          );
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
