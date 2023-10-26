import 'dart:convert';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intellensense/LoginPages/widgets/ChartSampleData.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NewsPaperSentiment extends StatefulWidget {
  var Value;
  NewsPaperSentiment(this.Value, );

  @override
  State<NewsPaperSentiment> createState() => _NewsPaperSentimentState();
}

class _NewsPaperSentimentState extends State<NewsPaperSentiment> {
  ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    NewspaperSentimentTabledata1.clear();
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final format = DateFormat("MM/dd/yyyy");
  TextEditingController FromDate = TextEditingController();
  TextEditingController ToDate = TextEditingController();
  late Future<dynamic> _value = NewsPaperSentimentAPI('', '', '');
  late Future<dynamic> _value1 = SelectionSentimentAPI('', '', '');
  PageController _pagecontroller = PageController();
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
            'NewsPaper Analysis',
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
                        Card(
                          child: Scrollbar(
                            controller: _scrollController,
                            thickness: 5,
                            thumbVisibility: true,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: SingleChildScrollView(
                                child: Table(
                                    border: TableBorder.all(
                                        color: Colors.blue.shade200),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                            height: 30,
                                            color:Color(0xff86a8e7),
                                            child: Center(
                                                child: Text(
                                              'News Titles',
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ))),
                                        Container(
                                            height: 30,
                                            color:Color(0xff86a8e7),
                                            child: Center(
                                                child: Text(
                                              'News Media Name',
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ))),
                                      ]),
                                      ...NewspaperSentimentTabledata1,
                                    ]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            elevation: 5,
                            child: SfCircularChart(
                              title: ChartTitle(
                                  text: 'News Paper Sentiment Analysis'),
                              legend: Legend(isVisible: true),
                              series: <PieSeries<ChartSampleData, String>>[
                                PieSeries<ChartSampleData, String>(
                                    explode: true,
                                    explodeIndex: 0,
                                    explodeOffset: '10%',
                                    dataSource: NPSentimentGraphData,
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
          ])),
    );
  }

  Selectdurationforanalysis() {
    return SingleChildScrollView(
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
                NPSlectionSentimentGraphData.clear();
                NewspaperSelectionSentimentTabledata1.clear();
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
                        Card(
                          child: Scrollbar(
                            controller: _scrollController,
                            thickness: 5,
                            thumbVisibility: true,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: SingleChildScrollView(
                                child: Table(
                                    border: TableBorder.all(
                                        color: Colors.blue.shade200),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                            height: 30,
                                            color:Color(0xff86a8e7),
                                            child: Center(
                                                child: Text(
                                              'News Titles',
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ))),
                                        Container(
                                            height: 30,
                                            color:Color(0xff86a8e7),
                                            child: Center(
                                                child: Text(
                                              'News Media Name',
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ))),
                                      ]),
                                      ...NewspaperSelectionSentimentTabledata1,
                                    ]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            elevation: 5,
                            child: SfCircularChart(
                              title: ChartTitle(
                                  text: 'News Paper Sentiment Analysis'),
                              legend: Legend(isVisible: true),
                              series: <PieSeries<ChartSampleData, String>>[
                                PieSeries<ChartSampleData, String>(
                                    explode: true,
                                    explodeIndex: 0,
                                    explodeOffset: '10%',
                                    dataSource: NPSlectionSentimentGraphData,
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
    ]));
  }

  //Newspaper 7 days Seniment
  var NewspaperSentimentdata;
  List<ChartSampleData> NPSentimentGraphData = [];
  Map Selectionquery = new Map<String, dynamic>();
  List<TableRow> NewspaperSentimentTabledata1 = [];
  Future<dynamic> NewsPaperSentimentAPI(
      String type, String today1, String yesterday1) async {
    setState(() {
      Selectionquery['social_handle'] = 'NEWS_PAPER';
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
        NewspaperSentimentdata = jsonDecode(utf8.decode(response.bodyBytes));
        for (int i = 0;
            i < NewspaperSentimentdata['News Paper Analysis'].length;
            i++) {
          NewspaperSentimentTabledata1.add(TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '${NewspaperSentimentdata['News Paper Analysis'][i]['HEAD_LINE']}',
                style: GoogleFonts.nunitoSans(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '${NewspaperSentimentdata['News Paper Analysis'][i]['MEDIA_NAME']}',
                style: GoogleFonts.nunitoSans(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
          ]));
        }
        for (int i = 0;
            i < NewspaperSentimentdata['NP Sentiment Analysis'].length;
            i++) {
          NPSentimentGraphData.add(
            ChartSampleData(
                x:
                    '${NewspaperSentimentdata['NP Sentiment Analysis'][i]['SENTIMENT_ANALYSIS_RESULT']}',
                y: NewspaperSentimentdata['NP Sentiment Analysis'][i]['COUNT'],
                text:
                    '${NewspaperSentimentdata['NP Sentiment Analysis'][i]['SENTIMENT_ANALYSIS_RESULT']}'),
          );
        }
        print(NewspaperSentimentdata);
      } catch (e) {
        print(NewspaperSentimentdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return NewspaperSentimentdata;
  }

//Selection Sentiment
  List<ChartSampleData> NPSlectionSentimentGraphData = [];
  List<TableRow> NewspaperSelectionSentimentTabledata1 = [];
  var SelectionSentimentdata;
  Map query = new Map<String, dynamic>();
  Future<dynamic> SelectionSentimentAPI(
      String type, String today1, String yesterday1) async {
    setState(() {
      query['social_handle'] = 'NEWS_PAPER';
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
            i < SelectionSentimentdata['News Paper Analysis'].length;
            i++) {
          NewspaperSelectionSentimentTabledata1.add(TableRow(children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '${SelectionSentimentdata['News Paper Analysis'][i]['HEAD_LINE']}',
                style: GoogleFonts.nunitoSans(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '${SelectionSentimentdata['News Paper Analysis'][i]['MEDIA_NAME']}',
                style: GoogleFonts.nunitoSans(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
          ]));
        }
        for (int i = 0;
            i < SelectionSentimentdata['News Paper Analysis'].length;
            i++) {
          NPSlectionSentimentGraphData.add(
            ChartSampleData(
                x:
                    '${SelectionSentimentdata['NP Sentiment Analysis'][i]['SENTIMENT_ANALYSIS_RESULT']}',
                y: SelectionSentimentdata['NP Sentiment Analysis'][i]['COUNT'],
                text:
                    '${SelectionSentimentdata['NP Sentiment Analysis'][i]['SENTIMENT_ANALYSIS_RESULT']}'),
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
