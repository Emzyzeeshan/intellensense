import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intellensense/Pages/DrawerScreens/CandidatureAnalysis/Audio%20Emotion/Audioanalysis.dart';

import 'package:intellensense/SpalashScreen/constants.dart';
import 'package:youtube/youtube_thumbnail.dart';

class AudioEmotionlist extends StatefulWidget {
  const AudioEmotionlist({Key? key}) : super(key: key);

  @override
  State<AudioEmotionlist> createState() => _AudioEmotionlistState();
}

class _AudioEmotionlistState extends State<AudioEmotionlist> {
  late Future<dynamic> _value1 = AudioEmotionCardAPI();
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: HomeColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/voicedxps.png',
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Audio Emotion Analysis',
                      style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.45,
                          ),
                          Center(
                              child: SpinKitWave(
                            color: Colors.blue,
                            size: 18,
                          )),
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: AudioEmotionData['video_urls'].length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 3,
                                  crossAxisCount:
                                      (orientation == Orientation.portrait)
                                          ? 2
                                          : 3),
                          itemBuilder: (BuildContext context, int index) {

                            return  OpenContainer(
                                      openElevation: 10.0,
                                      closedShape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                      transitionType:
                                          ContainerTransitionType.fade,
                                      transitionDuration:
                                          const Duration(milliseconds: 1200),
                                      openBuilder: (context, action) {
                                        return AudioEmotion( ytlink: AudioEmotionData['video_urls'][index]
                                    ['AUDIO_LINK'] ,);
                                      },
                                      closedBuilder: (context, action) {
                                        return  InfoCard(
                                AudioEmotionData['video_urls'][index]
                                        ['AUDIO_TITLE']
                                    .toString(),
                                AudioEmotionData['video_urls'][index]
                                                ['PUBLISHED_DATE']
                                            .toString() ==
                                        'null'
                                    ? 'N/A'
                                    : AudioEmotionData['video_urls'][index]
                                            ['PUBLISHED_DATE'].toString(),
                                    AudioEmotionData['video_urls'][index]
                                                    ['PUBLISHED_DATE']
                                                .toString() ==
                                            'null'
                                        ? 'N/A'
                                        : AudioEmotionData['video_urls'][index]
                                                ['PUBLISHED_DATE']
                                            .toString(),
                                    AudioEmotionData['video_urls'][index]
                                        ['AUDIO_LINK'],
                                  );
                              },
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

  var AudioEmotionData;
  Map query = new Map<String, dynamic>();
  Future<dynamic> AudioEmotionCardAPI() async {
    setState(() {
      query['accessName'] = 'INSIGHTS';
      query['type'] = 'video_list';
    });

    var response = await post(
        Uri.parse('http://apihub.pilogcloud.com:6656/emotion_app_urls'),
        body: query);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        AudioEmotionData = json.decode(utf8.decode(response.bodyBytes));
      });
      print(AudioEmotionData);
    } else {
      print(response.reasonPhrase);
    }
    return AudioEmotionData;
  }

  Widget InfoCard(
      String title, String date, String thumbnailURL, String ytlink) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Color(0xffd2dfff),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          YoutubeThumbnail(
                                  youtubeId: convertUrlToId(thumbnailURL) ?? '')
                              .hd() as String,
                        ))),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                title,
                maxLines: 3,
                style: GoogleFonts.nunitoSans(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(date),
                ],
              ),
            ]),
      ),
    );
  }

  String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }
}
