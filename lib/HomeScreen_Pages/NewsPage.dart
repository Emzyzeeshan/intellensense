import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellensense/Constants/constants.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/GoogleTrendsTab.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/LiveNewsTab.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/NewsControllers/GoogleTrendsController.dart';

import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/NewsControllers/LiveNewsController.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/NewsControllers/NewsChannelControllers.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/NewsControllers/NewsPaperController.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/NewsChannelTab.dart';
import 'package:intellensense/HomeScreen_Pages/All%20News%20Tabs/NewspaperTab.dart';

import '../constants.dart';

class DiscoverPage extends StatefulWidget {
  final int initialPage;
  const DiscoverPage({Key? key,required this.initialPage}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  // PageController controller = PageController();
  static dynamic currentPageValue = 0.0;
  NewsPaperController newsPaperController = Get.put(NewsPaperController());
  NewsChannelController newsChannelController =
      Get.put(NewsChannelController());
      LiveNewsController liveNewsController=Get.put(LiveNewsController());
          GoogleTrendsController googleTrendsControllerr=Get.put(GoogleTrendsController());
  void Function(String)? ontap;
  @override
  void initState() {
    newsPaperController.page.value=0;
    liveNewsController.page.value=0;
    googleTrendsControllerr.page.value=0;
    super.initState();
    // controller.addListener(() {
    //   setState(() {
    //     currentPageValue = controller.page;
    //   });
    // });
    newsPaperController.newsPaperscrollController.addListener(() {
      if (newsPaperController
              .newsPaperscrollController.position.maxScrollExtent ==
          newsPaperController.newsPaperscrollController.offset) {
        newsPaperController.page = newsPaperController.page + 1;
        newsPaperController.NewsPaperListAPI(newsPaperController.page.value.toString());
      }
    });
     liveNewsController.liveNewsscrollController.addListener(() {
      if (liveNewsController
              .liveNewsscrollController.position.maxScrollExtent ==
          liveNewsController.liveNewsscrollController.offset) {
        liveNewsController.page = liveNewsController.page + 1;
        liveNewsController.LiveNewsListAPI(liveNewsController.page.value.toString());
      }
    });
    ontap = liveNewsController.onLiveNewsSearchTextChanged;
        googleTrendsControllerr.googleTrendsscrollController.addListener(() {
      if (googleTrendsControllerr
              .googleTrendsscrollController.position.maxScrollExtent ==
          googleTrendsControllerr.googleTrendsscrollController.offset) {
        googleTrendsControllerr.page = googleTrendsControllerr.page + 1;
        googleTrendsControllerr.GoogleTrendsListAPI(googleTrendsControllerr.page.value.toString());
      }
    });
    ontap = googleTrendsControllerr.onGoogleTrendsSearchTextChanged;
  }

  late TabController tabController = TabController(
    length: 4,
    vsync: this,initialIndex: widget.initialPage
  );
  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //     newsPaperController.dispose();
    // newsChannelController.dispose();
    // liveNewsController.dispose();
    // googleTrendsControllerr.dispose();
    tabController.dispose();
    textEditingController.dispose();
    // controller.dispose();
    
  }
  @override
  Widget build(BuildContext context) {
    List <Widget>pageViewItem = [
      NewspaperTab(context),
      NewsChannnelTab(context),
      LiveNewsTab(context),
      GoogleTrendsTab(context)
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SafeArea(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text(
                  "Discover",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "News from political world",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: Colors.grey.shade500),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          _showAlertDialog();
                        },
                        icon: Icon(Icons.filter_list_rounded)),
                    hintText: 'Search....',
                    hintStyle: TextStyle(fontWeight: FontWeight.w400),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 25,
                    ),
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    focusColor: Colors.grey),
                onChanged: ontap,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TabBar(
              controller: tabController,
              isScrollable: true, // Required
              labelColor: Colors.black87,
              labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              unselectedLabelColor: Colors.black54, // Other tabs color
              labelPadding:
                  EdgeInsets.symmetric(horizontal: 25), // Space between tabs
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                    color: Colors.black45, width: 2), // Indicator height
                insets: EdgeInsets.symmetric(horizontal: 30), // Indicator width
              ),
              tabs: [
                Tab(text: 'Newspaper',),
                Tab(text: 'News Channel'),
                Tab(text: 'Live Updates'),
                Tab(text: 'Trends'),
              ],
              onTap: (value) {
                switch (value) {
                  case 0:
                  
                    tabController.animateTo(0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);

                    newsPaperController.searchData.clear();
                    ontap = newsPaperController.onSearchTextChanged;
                    newsChannelController.dispose();

                    break;
                  case 1:
                    tabController.animateTo(1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                    newsChannelController.searchData.clear();
                    ontap =
                        newsChannelController.onSearchTextChangedNewsChannel;
                    break;
                  case 2:
                   tabController.animateTo(2,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                    liveNewsController.searchData.clear();
                    ontap =
                        liveNewsController.onLiveNewsSearchTextChanged;
                    break;
                  case 3:
                    tabController.animateTo(3,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                    newsPaperController.searchData.clear();
                    break;
                  default:
                    print(' invalid entry');
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: TabBarView(
              controller: tabController,
              children: pageViewItem,))
          ],
        ),
      )),
    );
  }

  void _showAlertDialog() async {
    List<Party> selectedUserList = [];
    await FilterListDialog.display<Party>(
      context,
      listData: partyList,
      selectedListData: selectedUserList,
      choiceChipLabel: (Party) => Party!.name,
      enableOnlySingleSelection: true,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (Party, query) {
        return Party.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = List.from(list!);
          textEditingController.text = selectedUserList[0].name.toString();
        });
        newsPaperController
            .onSearchTextChanged(selectedUserList[0].name.toString());
        print(selectedUserList[0].name);
        Navigator.pop(context);
      },
    );
  }
}

class Party {
  final String? name;

  Party({
    this.name,
  });
}
