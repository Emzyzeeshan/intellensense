import 'dart:convert';
import 'dart:isolate';

import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../main.dart';
class HomePageController extends GetxController {

  var newchannelldata;
  var newsdata;
  var Livenewsdata;
  var GoogleTrendsdata;
  var TwitterData;
  var Instagramdata;
  var Facebookdata;
  var Youtubedata;
  Future fetchNewsDataIsolate(SendPort sendPort) async {
      List allnewsData = [];
    var headers = {'Content-Type': 'application/json'};
    final results = await Future.wait([
      get(Uri.parse(INSIGHTS + '/newspaper?page=0,13')),
      get(
        Uri.parse(INSIGHTS + '/youtube-news/partyName/TDP?page=0,15'),
        headers: headers,
      ),
      get(
        Uri.parse(INSIGHTS + '/livenews?page=0,17'),
        headers: headers,
      ),
      get(
        Uri.parse(INSIGHTS + '/googleTrends?page=0,13'),
        headers: headers,
      )
    ]);
    allnewsData.add(json.decode(utf8.decode(results[0].bodyBytes) ));
    allnewsData.add(json.decode(utf8.decode(results[1].bodyBytes) ));
    allnewsData.add(json.decode(utf8.decode(results[2].bodyBytes) ));
    allnewsData.add(json.decode(utf8.decode(results[3].bodyBytes) ));
    sendPort.send(allnewsData);
    update();
  }

  newspaperApi() async {
    var recievePort = new ReceivePort(); //creating new port to listen data
    await Isolate.spawn(fetchNewsDataIsolate,
        recievePort.sendPort); //spawing/creating new thread as isolates.
    recievePort.listen((message) {
      //listening data from isolate
      print("listening data from isolate");
      newsdata = message[0];
      newchannelldata = message[1];
      Livenewsdata = message[2];
      GoogleTrendsdata = message[3];
          update();
    });

  
  }


  //Social media news
    Future fetchSocialMediaIsolate(SendPort sendPort) async {
        List allnewsData = [];
    var headers = {'Content-Type': 'application/json'};
    final results = await Future.wait([
     get(
    Uri.parse(INSIGHTS + '/youtube-news/partyName/TDP?page=0,15'),
    headers: headers,
  ),
    get(
    Uri.parse(INSIGHTS + '/twitter'),
    headers: headers,
  ),
      get(
    Uri.parse(INSIGHTS + '/facebookAnalysis?page=0,12'),
    headers: headers,
  ),
      get(
    Uri.parse(INSIGHTS + '/instagram/partyName?page=0,12&partyName=TDP'),
    headers: headers,
  )
    ]);
    allnewsData.add(json.decode(utf8.decode(results[0].bodyBytes) ));
    allnewsData.add(json.decode(utf8.decode(results[1].bodyBytes) ));
    allnewsData.add(json.decode(utf8.decode(results[2].bodyBytes) ));
    allnewsData.add(json.decode(utf8.decode(results[3].bodyBytes) ));
    sendPort.send(allnewsData);
    update();
  }

   socialMediaApi() async {
    var recievePort = new ReceivePort(); //creating new port to listen data
    await Isolate.spawn(fetchSocialMediaIsolate,
        recievePort.sendPort,); //spawing/creating new thread as isolates.
    recievePort.listen((message) {
      //listening data from isolate
      print("listening data from isolate");
      Youtubedata = message[0];
      TwitterData = message[1];
      Facebookdata = message[2];
      Instagramdata = message[3];
          update();
    });


  }
}
