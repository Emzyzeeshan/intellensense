import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/NewsControllers/GoogleTrendsController.dart';

import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/widgets/NewsTile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget GoogleTrendsTab(BuildContext context) {
 
  GoogleTrendsController googleTrendsController = Get.put(GoogleTrendsController());

  return Obx(() => googleTrendsController.isLoading.value
      ? Center(
          child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.blueAccent.shade200, size: 40),
        )
      : Obx(() => googleTrendsController.searchData.isEmpty
          ? RefreshIndicator(
            onRefresh: () => googleTrendsController.fetch(),
            child: ListView.builder(
              controller: googleTrendsController.googleTrendsscrollController,
                physics: BouncingScrollPhysics(),
                itemCount: googleTrendsController.item.length+1,
                itemBuilder: (context, index) {
                  if(index<googleTrendsController.item.length){
               
                // googleTrendsController.item =googleTrendsController.NewsPaperListResult;
                      return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.all(4),
                      elevation: 20,
                      child: NewspapertabTile(
                          // onTap: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => InAppWeb(
                          //         url:googleTrendsController.item[index]["sourceUrl"],
                          //         mediaName: googleTrendsController.item[index]["mediaName"],
                          //       ),
                          //     )),
                          image:
                              "https://pbs.twimg.com/profile_images/880534343008927744/cRCD7iF7_400x400.jpg",
                          title: googleTrendsController.item[index]["id"]
                                  ["candidateName"]
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
                                    googleTrendsController.item[index]
                                            ["editDate"]
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
                                    googleTrendsController.item[index]
                                          ["partyName"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87,
                                          fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.search,
                                    size: 17,
                                  ),
                                  Flexible(
                                    child: Text(
                                    googleTrendsController.item[index]["id"]
                                          ["saerchCount"].toString(),
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
            googleTrendsController.hasmore.value?
             LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blueAccent.shade200, size: 40):Text("No more Data"),
                  ));
                  }
                
                }),
          )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: googleTrendsController.searchData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.all(4),
                    elevation: 20,
                    child: NewspapertabTile(
                        // onTap: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => InAppWeb(
                        //         url: googleTrendsController.searchData[index]
                        //             ["sourceUrl"],
                        //         mediaName: googleTrendsController.searchData[index]
                        //             ["mediaName"],
                        //       ),
                        //     ),),
                        image:
                            'https://pbs.twimg.com/profile_images/880534343008927744/cRCD7iF7_400x400.jpg',
                        title: googleTrendsController.searchData[index]["id"]["candidateName"]
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
                                  googleTrendsController.searchData[index]
                                          ["editDate"]
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
                                    googleTrendsController.searchData[index]
                                        ["partyName"],
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
