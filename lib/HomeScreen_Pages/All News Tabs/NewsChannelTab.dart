import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/NewsControllers/NewsChannelControllers.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/NewsControllers/NewsPaperController.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/widgets/NewsTile.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/widgets/webViewPages/NewsChannelWebView.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:youtube/youtube_thumbnail.dart';

Widget NewsChannnelTab(BuildContext context) {
  NewsChannelController newsChannelController = Get.put(NewsChannelController());

  return Obx(() => newsChannelController.isNewsChanneLoading.value
      ? Center(
          child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.blueAccent.shade200, size: 40),
        )
      : Obx(() => newsChannelController.searchData.isEmpty
          ? ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: newsChannelController.NewsChannelListResult.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.all(4),
                    elevation: 20,
                    child: NewspapertabTile(
                        onTap: () {
                          Get.to(NewsChannelWebView(urlID: newsChannelController.convertUrlToId(
                                        newsChannelController
                                                .NewsChannelListResult[index]
                                            ["sourceUrl"]) ??"", data: newsChannelController.NewsChannelListResult[index],));
                        },
                        image: YoutubeThumbnail(
                                youtubeId: newsChannelController.convertUrlToId(
                                        newsChannelController
                                                .NewsChannelListResult[index]
                                            ["sourceUrl"]) ??
                                    '')
                            .hd() as String,
                        title: newsChannelController.NewsChannelListResult[index]
                                ["videoTitle"]
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
                                  newsChannelController.NewsChannelListResult[index]
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
                                    newsChannelController
                                            .NewsChannelListResult[index]
                                        ["mediaChannelName"],
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
              })
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: newsChannelController.searchData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.all(4),
                    elevation: 20,
                    child: NewspapertabTile(
                        onTap: () {
                          Get.to(NewsChannelWebView(urlID: newsChannelController.convertUrlToId(
                                        newsChannelController
                                                .searchData[index]
                                            ["sourceUrl"]) ??"",data:newsChannelController.searchData[index]));
                        },
                        image: YoutubeThumbnail(
                                youtubeId: newsChannelController.convertUrlToId(
                                        newsChannelController.searchData[index]
                                            ["sourceUrl"]) ??
                                    '')
                            .hd() as String,
                        title: newsChannelController.searchData[index]["videoTitle"]
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
                                  newsChannelController.searchData[index]
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
                                    newsChannelController.searchData[index]
                                        ["mediaChannelName"],
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
