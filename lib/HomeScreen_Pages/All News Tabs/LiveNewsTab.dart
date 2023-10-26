import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/NewsControllers/LiveNewsController.dart';

import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/widgets/NewsTile.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/widgets/webViewPages/NewsPaperWebView.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget LiveNewsTab(BuildContext context) {
 
  LiveNewsController liveNewsController = Get.put(LiveNewsController());

  return Obx(() => liveNewsController.isLoading.value
      ? Center(
          child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.blueAccent.shade200, size: 40),
        )
      : Obx(() => liveNewsController.searchData.isEmpty
          ? ListView.builder(
            controller: liveNewsController.liveNewsscrollController,
              physics: BouncingScrollPhysics(),
              itemCount: liveNewsController.item.length+1,
              itemBuilder: (context, index) {
                if(index<liveNewsController.item.length){
             
              // liveNewsController.item =liveNewsController.NewsPaperListResult;
                    return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.all(4),
                    elevation: 20,
                    child: NewspapertabTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InAppWeb(
                                url:liveNewsController.item[index]["sourceUrl"],
                                mediaName: liveNewsController.item[index]["mediaName"],
                              ),
                            )),
                        image:
                            liveNewsController.item[index]["sourceImg"],
                        title: liveNewsController.item[index]
                                ["headLine"]
                            .toString()
                            .toLowerCase(),
                        subtitle: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  size: 17,
                                ),
                                Text(
                                  liveNewsController.item[index]
                                          ["createDate"]
                                      .join("/")
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.screenshot_monitor_rounded,
                                  size: 17,
                                ),
                                Flexible(
                                  child: Text(
                                  liveNewsController.item[index]
                                        ["mediaName"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87,
                                        fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                );
                }else{
                  return  Padding(padding: EdgeInsets.symmetric(vertical: 32),child:   Center(
          child:
          liveNewsController.hasmore?
           LoadingAnimationWidget.fourRotatingDots(
              color: Colors.blueAccent.shade200, size: 40):Text("No more Data"),
        ));
                }
              
              })
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: liveNewsController.searchData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.all(4),
                    elevation: 20,
                    child: NewspapertabTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InAppWeb(
                                url: liveNewsController.searchData[index]
                                    ["sourceUrl"],
                                mediaName: liveNewsController.searchData[index]
                                    ["mediaName"],
                              ),
                            ),),
                        image:
                            liveNewsController.searchData[index]
                                    ["sourceImg"],
                        title: liveNewsController.searchData[index]["headLine"]
                            .toString()
                            .toLowerCase(),

                        // "WHY NBK AND LOKESH SILENT AT JAIL PRESS MEET?",
                        subtitle: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  size: 17,
                                ),
                                Text(
                                  liveNewsController.searchData[index]
                                          ["createDate"]
                                      .join("/")
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.screenshot_monitor_rounded,
                                  size: 17,
                                ),
                                Flexible(
                                  child: Text(
                                    liveNewsController.searchData[index]
                                        ["mediaName"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87,
                                        fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                );
              })));
}
