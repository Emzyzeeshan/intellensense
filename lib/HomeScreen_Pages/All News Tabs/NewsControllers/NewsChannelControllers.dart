import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intellensense/main.dart';

class NewsChannelController extends GetxController{
    @override
  Future<void> onInit() async {
    super.onInit();
       
         NewsNewsChanneListAPI();
   

  }
  void Function(String)? onChanged;
  List searchData=[].obs;
  //News channel API
var NewsChannelListResult ;
  var isNewsChanneLoading = false.obs;
  NewsNewsChanneListAPI() async {

      isNewsChanneLoading(true);
  

    try {
      
      var response = await get(
        Uri.parse(INSIGHTS + '/youtube-news?page=0,19'),
      );

      if (response.statusCode == 200) {
        NewsChannelListResult = jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print(NewsChannelListResult);
      NewsChannelListResult = [];
    } finally {
      Future.delayed(const Duration(seconds: 2), () {
isNewsChanneLoading(false);
});
      
    }

    return NewsChannelListResult;
  }

//search for newschannel
     onSearchTextChangedNewsChannel(String text) async {
 searchData.clear();
    if (text.isEmpty) {
      // Check textfield is empty or not

      return;
    }

   NewsChannelListResult .forEach((data) {
      if (data['candidatePartyName']
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase().toString())||data['candidateName']
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase().toString())) {
     searchData.add(
            data); // If not empty then add search data into search data list
      }
    });
     update();
  }


  //convert vedio to thumbnail
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