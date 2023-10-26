import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/NewsControllers/NewsPaperController.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/widgets/NewsTile.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/widgets/webViewPages/NewsPaperWebView.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget NewspaperTab(BuildContext context) {
  NewsPaperController newsPaperController = Get.put(NewsPaperController());

  String imageurl = '';
  return Obx(() => newsPaperController.isLoading.value
      ? Center(
          child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.blueAccent.shade200, size: 40),
        )
      : Obx(() => newsPaperController.searchData.isEmpty
          ? ListView.builder(
              controller: newsPaperController.newsPaperscrollController,
              physics: BouncingScrollPhysics(),
              itemCount: newsPaperController.item.length + 1,
              itemBuilder: (context, index) {
                if (index < newsPaperController.item.length) {
                  newsPaperController.getProfileImageUrl(
                      newsPaperController.item[index]["sourceUrl"]);
                  // newsPaperController.item =newsPaperController.NewsPaperListResult;
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
                                  url: newsPaperController.item[index]
                                      ["sourceUrl"],
                                  mediaName: newsPaperController.item[index]
                                      ["mediaName"],
                                ),
                              )),
                          image: newsPaperController.imageurl.value,
                          title: newsPaperController.item[index]["headLine"]
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
                                    newsPaperController.item[index]
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
                                      newsPaperController.item[index]
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
                } else {
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: newsPaperController.hasmore
                            ? LoadingAnimationWidget.fourRotatingDots(
                                color: Colors.blueAccent.shade200, size: 40)
                            : Text("No more Data"),
                      ));
                }
              })
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: newsPaperController.searchData.length,
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
                                  url: newsPaperController.searchData[index]
                                      ["sourceUrl"],
                                  mediaName: newsPaperController
                                      .searchData[index]["mediaName"],
                                ),
                              ),
                            ),
                        image:
                            "https://static.vecteezy.com/system/resources/previews/000/124/615/original/free-old-newspaper-vector.jpg",
                        title: newsPaperController.searchData[index]["headLine"]
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
                                  newsPaperController.searchData[index]
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
                                    newsPaperController.searchData[index]
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
