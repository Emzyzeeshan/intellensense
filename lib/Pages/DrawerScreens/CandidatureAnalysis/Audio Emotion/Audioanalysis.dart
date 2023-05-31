import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:intellensense/SpalashScreen/constants.dart';

class FaceEmotion extends StatefulWidget {
  var ytlink;
  FaceEmotion({@required this.ytlink, Key? key}) : super(key: key);

  @override
  State<FaceEmotion> createState() => _FaceEmotionState();
}

class _FaceEmotionState extends State<FaceEmotion> {
  @override
  void initState() {
    print(widget.ytlink);
    super.initState();
  }

  TextEditingController _editingController = TextEditingController();
  late Future<dynamic> _value1 = FaceEmotionAPI();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: HomeColor,
      body: Padding(
        padding:
            const EdgeInsets.only(left: 8.0, right: 8, top: 40, bottom: 10),
        child: SingleChildScrollView(
          child: Column(children: [
          
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      'assets/new Updated images/faceEmotion.gif',
                                      height: 170,
                                      width: 170),
                                ],
                              ),
                            ],
                          );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: FaceEmotiontdata['res'].length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 2,
                          crossAxisCount:
                              (orientation == Orientation.portrait) ? 2 : 3),
                      itemBuilder: (BuildContext context, int index) {
                        return FrameCard(
                            'data:image/png;base64,' +
                                FaceEmotiontdata['res'][index]['EMOTION_IMAGE'],
                            FaceEmotiontdata['res'][index]['SAD'].toString()+'%',
                            FaceEmotiontdata['res'][index]['ANGRY'].toString()+'%',
                            FaceEmotiontdata['res'][index]['DISGUST'].toString()+'%',
                            FaceEmotiontdata['res'][index]['FEAR'].toString()+'%',
                            FaceEmotiontdata['res'][index]['HAPPY'].toString()+'%',
                            FaceEmotiontdata['res'][index]['SURPRISE'].toString()+'%',
                            FaceEmotiontdata['res'][index]['NEUTRAL'].toString()+'%',

                            );
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
          ]),
        ),
      ),
    );
  }

  var FaceEmotiontdata;
  Map Selectionquery = new Map<String, dynamic>();
  Future<dynamic> FaceEmotionAPI() async {
    setState(() {
      Selectionquery['URL'] = '${widget.ytlink}';
    });
    var response = await post(
        Uri.parse(
            'http://idxp.pilogcloud.com:6650/facial_emotion_analysis_mobile/'),
        body: Selectionquery);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        FaceEmotiontdata = json.decode(utf8.decode(response.bodyBytes));

        print(FaceEmotiontdata);
      } catch (e) {
        print(FaceEmotiontdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return FaceEmotiontdata;
  }

  FrameCard(String base64String, String sad, String angry, String disgusting,
      String fear, String happy, String surprised, String neutral) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade300, width: 1)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Image.memory(
                base64Decode(base64String.substring(22) ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/icons/sademoji.png',
                  height: 20,
                  width: 20,
                ),
                Text(sad),
                Spacer(),
                Image.asset(
                  'assets/icons/angryicon.png',
                  height: 20,
                  width: 20,
                ),
                Text(angry),
                Spacer(),
                Image.asset(
                  'assets/icons/disgusting emoji.jpg',
                  height: 20,
                  width: 20,
                ),
                Text(angry),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/icons/fear emoji.jpg',
                  height: 20,
                  width: 20,
                ),
                Text(sad),
                Spacer(),
                Image.asset(
                  'assets/icons/happy emoji.jpg',
                  height: 20,
                  width: 20,
                ),
                Text(angry),
                Spacer(),
                Image.asset(
                  'assets/icons/surprised emoji.jpg',
                  height: 20,
                  width: 20,
                ),
                Text(angry),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/icons/neutral emoji.jpg',
                  height: 20,
                  width: 20,
                ),
                Text(sad),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
