import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart';
import 'package:intellensense/main.dart';
import 'package:http/http.dart' as http;
class NewsPaperController extends GetxController {
RxString imageurl=RxString("");
  Future<String> getProfileImageUrl(String url ) async {
    // Download the content of the site
    http.Response response = await http.get(Uri.parse(url));
    String html = response.body;

    // The html contains the following string exactly one time.
    // After this specific string the url of the profile picture starts.
    String needle = '<meta property="og:image" content="';
    int index = html.indexOf(needle);

    // The result of indexOf() equals -1 if the needle didn't occurred in the html.
    // In that case the received username may be invalid.
    if (index == -1)
      return null!;

    // Remove all characters up to the start of the text snippet that we want.
    html = html.substring(html.indexOf(needle) + needle.length);

    // return all chars until the first occurrence of '"'
    print(html.substring(0, html.indexOf('"')));
    imageurl.value=html.substring(0, html.indexOf('"'));
    update();
    return html.substring(0, html.indexOf('"'));
  }
  
void Function(String)? onChanged;
RxInt page=0.obs;
bool hasmore=true;
List item=[].obs;
final newsPaperscrollController=ScrollController();
List searchData=[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
        NewsPaperListAPI(page.toString());
        
   

  }

  //News Paper API

  var isLoading = false.obs;
  Future NewsPaperListAPI(String limit) async {
  if(item.isEmpty){
      isLoading(true);
  }


    try {
      
      var response = await get(
        Uri.parse(INSIGHTS + '/newspaper?page=${page.toString()},15'),
      );

      if (response.statusCode == 200) {
        final newlist=json.decode(utf8.decode(response.bodyBytes) );
        // NewsPaperListResult = jsonDecode(utf8.decode(response.bodyBytes));
        item.addAll(newlist.map((item){
return item;
        }).toList());
      } else {
        print('error fetching data');
      }
    } catch (e) {

    } finally {
      Future.delayed(const Duration(seconds: 2), () {
isLoading(false);
});
      
    }

    return item;
  }




//search 
    onSearchTextChanged(String text) async {
 searchData.clear();
    if (text.isEmpty) {
      // Check textfield is empty or not

      return;
    }

   item .forEach((data) {
      if (data['partyName']
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase().toString())) {
     searchData.add(
            data); // If not empty then add search data into search data list
      }
    });
     update();
  }


  
}
