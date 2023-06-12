import 'dart:convert';

import 'package:http/http.dart';

import '../main.dart';

var TeslaStocksData;
TeslaStocksDataAPI() async {
  var headers = {'Content-Type': 'application/json'};
  var response = await get(
    Uri.parse(
        'https://finnhub.io/api/v1/quote?symbol=TSLA&token=cgih1s1r01qnl59fmghgcgih1s1r01qnl59fmgi0'),
    headers: headers,
  );

  print(response.toString());
  if (response.statusCode == 200) {
    print(response.body);
    try {
      TeslaStocksData = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {}
  } else {
    print(response.reasonPhrase);
  }
  return TeslaStocksData;
}

//NewsChannel Api
var newchannelldata;
NewsChannelAPI() async {
  var headers = {'Content-Type': 'application/json'};
  var response = await get(
    Uri.parse(INSIGHTS + '/youtube-news/partyName/TDP?page=0,15'),
    headers: headers,
  );
  print(response.toString());
  if (response.statusCode == 200) {
    print(response.body);
    try {
      newchannelldata = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {}
  } else {
    print(response.reasonPhrase);
  }
  return newchannelldata;
}

//NewsPaper Api
var newsdata;
NEWSpaperAPI() async {
  List<String> hastags = [];
  var response = await get(
    Uri.parse(INSIGHTS + '/newspaper?page=0,13'),
  );
  //print(response.toString());
  if (response.statusCode == 200) {
    print(response.body);
    try {
      newsdata = jsonDecode(utf8.decode(response.bodyBytes));
      print(newsdata);
    } catch (e) {
      newsdata = [];
    }
  } else {
    print(response.reasonPhrase);
  }
  return newsdata;
}

//Live News Api
var Livenewsdata;
LiveUpdatesAPI() async {
  var headers = {'Content-Type': 'application/json'};
  var response = await get(
    Uri.parse(INSIGHTS + '/livenews?page=0,17'),
    headers: headers,
  );
  print(response.toString());
  if (response.statusCode == 200) {
    print(response.body);
    try {
      Livenewsdata = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      print(Livenewsdata);
      Livenewsdata = [];
    }
  } else {
    print(response.reasonPhrase);
  }
  return Livenewsdata;
}

//Google Trends Api
var GoogleTrendsdata;
GoogleTrendsAPI() async {
  var headers = {'Content-Type': 'application/json'};
  var response = await get(
    Uri.parse(INSIGHTS + '/googleTrends?page=0,13'),
    headers: headers,
  );
  print(response.toString());
  if (response.statusCode == 200) {
    print(response.body);
    try {
      GoogleTrendsdata = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      print(GoogleTrendsdata);
      GoogleTrendsdata = [];
    }
  } else {
    print(response.reasonPhrase);
  }
  return GoogleTrendsdata;
}

//youtube Api
var Youtubedata;
YouTubeAPI() async {
  var headers = {'Content-Type': 'application/json'};
  /*var body = json.encode({});*/
  var response = await get(
    Uri.parse(INSIGHTS + '/youtube-news/partyName/TDP?page=0,15'),
    headers: headers,
    //body: body,
  );
  print(response.toString());
  if (response.statusCode == 200) {
    print(response.body);
    try {
      Youtubedata = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      print(Youtubedata);
      Youtubedata = [];
    }
  } else {
    print(response.reasonPhrase);
  }
  return Youtubedata;
}

//twitter api
var TwitterData;
TwitterAPI() async {
  var headers = {'Content-Type': 'application/json'};
  var response = await get(
    Uri.parse(INSIGHTS + '/twitter/partyName/TDP?page=0,11'),
    headers: headers,
  );
  print(response.toString());
  if (response.statusCode == 200) {
    print(response.body);

    try {
      TwitterData = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      print(TwitterData);
      TwitterData = [];
    }
  } else {
    print(response.reasonPhrase);
  }
  return TwitterData;
}

//FaceBook News
var Facebookdata;
FacebookAPI() async {
  var headers = {'Content-Type': 'application/json'};
  var response = await get(
    Uri.parse(INSIGHTS + '/facebookAnalysis?page=0,12'),
    headers: headers,
  );
  print(response.toString());
  if (response.statusCode == 200) {
    print(response.body);
    try {
      Facebookdata = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      print(Facebookdata);
      Facebookdata = [];
    }
  } else {
    print(response.reasonPhrase);
  }
  return Facebookdata;
}

// Instagram news
var Instagramdata;
InstagramAPI() async {
  var headers = {'Content-Type': 'application/json'};
  /*var body = json.encode({});*/
  var response = await get(
    Uri.parse(INSIGHTS + '/instagram/partyName?page=0,12&partyName=TDP'),
    headers: headers,
    //body: body,
  );
  print(response.toString());
  if (response.statusCode == 200) {
    print(response.body);
    try {
      Instagramdata = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      print(Instagramdata);
      Instagramdata = [];
    }
  } else {
    print(response.reasonPhrase);
  }
  return Instagramdata;
}

//weather api
var Weatherdata;
WeatherAPI(String lat, String lon) async {
  var response = await get(
    Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=1206d9df2cd129a8e17e3ee9df30d47a'),
  );
  //print(response.toString());
  if (response.statusCode == 200) {
    print(response.body);
    try {
      Weatherdata = jsonDecode(utf8.decode(response.bodyBytes));
      print(Weatherdata);
    } catch (e) {
      Weatherdata = [];
    }
  } else {
    print(response.reasonPhrase);
  }
  return Weatherdata;
}


