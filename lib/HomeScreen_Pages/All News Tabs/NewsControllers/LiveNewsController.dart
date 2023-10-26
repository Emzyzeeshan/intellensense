import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart';
import 'package:intellensense/main.dart';

class LiveNewsController extends GetxController {
void Function(String)? onChanged;
RxInt page=0.obs;
bool hasmore=true;
List item=[].obs;
final liveNewsscrollController=ScrollController();
List searchData=[].obs;
  @override
  Future<void> onInit() async {
    super.onInit();
      LiveNewsListAPI(page.toString());
        
   

  }

  //News Paper API

  var isLoading = false.obs;
  Future LiveNewsListAPI(String limit) async {
  if(item.isEmpty){
      isLoading(true);
  }


    try {
      
      var response = await get(
        Uri.parse(INSIGHTS + '/livenews?page=${page.toString()},17'),
      );

      if (response.statusCode == 200) {
        final newlist=json.decode(utf8.decode(response.bodyBytes) );

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
    onLiveNewsSearchTextChanged(String text) async {
 searchData.clear();
    if (text.isEmpty) {
      // Check textfield is empty or not

      return;
    }

   item .forEach((data) {
      if (data['mediaName']
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
