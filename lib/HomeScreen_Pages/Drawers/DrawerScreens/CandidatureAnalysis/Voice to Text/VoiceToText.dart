import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intellensense/Constants/constants.dart';
import 'package:intellensense/LoginPages/widgets/ChartSampleData.dart';
import 'package:intellensense/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VoiceToText extends StatefulWidget {
  var youtubelink;
  VoiceToText({@required this.youtubelink});
  @override
  State<VoiceToText> createState() => _VoiceToTextState();
}

class _VoiceToTextState extends State<VoiceToText> {
  late Future<dynamic> _value1 = VoiceToTextAPI();

  @override
  void initState() {
    print(widget.youtubelink);
    super.initState();
  }

  TextEditingController _editingController = TextEditingController();
  TextEditingController ResponseID = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var input = 'ENGLISH';
  List Language = ['ENGLISH', 'TELUGU', 'HINDI'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HomeColor,
        body: Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'RESULTS',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 22,
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      'assets/new Updated images/videoscan.gif',
                                      height: 170,
                                      width: 170),
                                ],
                              ),
                            ],
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text('Error');
                          } else if (snapshot.hasData) {
                            Text overallSentiment = Text('');
                            if (VoiceToTextdata['OVERALL_SENTIMENT_ANALYSIS']
                                    ['0'] ==
                                'NEGATIVE') {
                              overallSentiment = Text(
                                'NEGATIVE',
                                style: TextStyle(color: Colors.red),
                              );
                            } else if (VoiceToTextdata[
                                    'OVERALL_SENTIMENT_ANALYSIS']['0'] ==
                                'POSITIVE') {
                              overallSentiment = Text(
                                'POSITIVE',
                                style: TextStyle(color: Colors.green),
                              );
                            } else {
                              overallSentiment = Text(
                                'NEUTRAL',
                                style: TextStyle(color: Colors.black),
                              );
                            }
                            return Column(
                              children: [
                                Container(
                                  height: 50,
                                  child: Card(
                                      color: Color(0xffd2dfff),
                                      elevation: 7,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            Text('Overall Sentiment :  '),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            overallSentiment
                                          ],
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  color: Color(0xffd2dfff),
                                  elevation: 7,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'CONVERTED TEXT',
                                            style: TextStyle(
                                              fontFamily: 'Segoe UI',
                                              fontSize: 19,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              '${VoiceToTextdata['CONVERTED_TEXT']['0']}',
                                              style: GoogleFonts.nunitoSans(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Card(
                                  color: Color(0xffd2dfff),
                                  elevation: 7,
                                  child: SfCircularChart(
                                    title: ChartTitle(text: 'WORDS COUNT'),
                                    legend: Legend(isVisible: true),
                                    series: <PieSeries<ChartSampleData,
                                        String>>[
                                      PieSeries<ChartSampleData, String>(
                                          explode: true,
                                          explodeIndex: 0,
                                          explodeOffset: '10%',
                                          dataSource: <ChartSampleData>[
                                            ChartSampleData(
                                                x: 'POSITIVE',
                                                y: num.parse(VoiceToTextdata[
                                                        'POSITIVE_WORDS_COUNT']
                                                    ['0']),
                                                text: 'POSITIVE'),
                                            ChartSampleData(
                                                x: 'NEGATIVE',
                                                y: num.parse(VoiceToTextdata[
                                                        'NEGATIVE_WORDS_COUNT']
                                                    ['0']),
                                                text: 'NEGATIVE'),
                                            ChartSampleData(
                                                x: 'NEUTRAL',
                                                y: num.parse(VoiceToTextdata[
                                                        'NEUTRAL_WORDS_COUNT']
                                                    ['0']),
                                                text: 'NEUTRAL'),
                                          ],
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
                  ]),
            )));
  }

  var VoiceToTextdata;
  Map Selectionquery = new Map<String, dynamic>();
  Future<dynamic> VoiceToTextAPI() async {
    setState(() {
      Selectionquery['accessName'] = 'INSIGHTS';
      Selectionquery['audioLink'] = '${widget.youtubelink}';
      Selectionquery['audioLanguage'] = '$input';
      Selectionquery['responseId'] = '${logindata.getString('username')}';
    });
    var response = await post(
        Uri.parse('http://apihub.pilogcloud.com:6663/VoiceTranslator_mobile/'),
        body: Selectionquery);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        VoiceToTextdata = jsonDecode(utf8.decode(response.bodyBytes));

        print(VoiceToTextdata);
      } catch (e) {
        print(VoiceToTextdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return VoiceToTextdata;
  }
}
