import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:animations/animations.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellensense/HomeScreen_Pages/NewsPage.dart';

import 'package:intellensense/HomeScreen_Pages/NewsWIdget/FaceBookScreen.dart';
//import 'package:intellensense/HomeScreen_Pages/SocialMediaPage.dart';

import 'package:intellensense/HomeScreen_Pages/Widgets/Newstemplate.dart';
import 'package:intellensense/HomeScreen_Pages/Drawers/DrawerScreens/ScoreCard/ScoreCardsScreen.dart';
import 'package:intellensense/HomeScreen_Pages/NotificationsPages/Notification.dart';

import 'package:intellensense/HomeScreen_Pages/Drawers/Drawer.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart';
import 'package:intellensense/HomeScreen_Pages/Widgets/Socialmediatemplate.dart';
import 'package:intellensense/HomeScreen_Pages/Widgets/opencontainers.dart';
//import 'package:intellensense/HomeScreen_Pages/constants.dart';
import 'package:intellensense/LoginPages/widgets/ChartSampleData.dart';
//import 'package:intellensense/Payments/PaymentPage.dart';
import 'package:intellensense/HomeScreen_Pages/Controllers/HomeScreenController.dart';
import 'package:intellensense/main.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import '../constants.dart';
import 'Banners.dart/FaceBookExpScreen.dart';
import 'Banners.dart/NewsChannelExpScreen.dart';
import 'Banners.dart/YoutubeExpScreen.dart';
import 'Banners.dart/twitterExpScreen.dart';
import 'Drawers/DrawerScreens/CandidatureAnalysis/AllCandidateList.dart';
import 'Drawers/DrawerScreens/Constituency Analysis/ConstituencyAnalysis.dart';
import 'Drawers/DrawerScreens/ElectoralAnalysis/ElectoralAnalysis.dart';

import 'NewsWIdget/InstagramScreen.dart';

import 'NewsWIdget/TwitterScreen.dart';
import 'NewsWIdget/YouTubeScreen.dart';
import 'StateOverViewScreens/StateOverview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isoverlayOn = false;
  String NewsHeading = '';
  bool isnewshidden = false;
  bool shownews = true;
  bool showSocialnews = true;
  bool newson = false;
  bool newson1 = false;
  bool isanimationcomplete = true;

  late Future<dynamic> LineChartfuturecall;
  TooltipBehavior? _tooltipBehavior;
  TooltipBehavior? _tooltipBehavior1;
  List<ChartSampleData>? chartData;
  HomePageController homePageController = Get.put(HomePageController());
  @override
  void initState() {
    homePageController.newspaperApi();
    homePageController.socialMediaApi();
    super.initState();
    YoutubeTopPartylistApi();
    NewsChannelTopPartylistApi();
    FaceBookTopPartylistApi();
    TwitterTopParty();
    //_initBannerAd();
    chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'Jan', y: 43, secondSeriesYValue: 37, thirdSeriesYValue: 41),
      ChartSampleData(
          x: 'Feb', y: 45, secondSeriesYValue: 37, thirdSeriesYValue: 45),
      ChartSampleData(
          x: 'Mar', y: 50, secondSeriesYValue: 39, thirdSeriesYValue: 48),
    ];
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        format: 'point.x : point.y',
        header: '');
    _tooltipBehavior1 = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        format: 'point.x : point.y',
        header: '');
    _TwittertooltipBehavior = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        format: 'point.x : point.y',
        header: '');
    _TwittertooltipBehavior1 = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        format: 'point.x : point.y',
        header: '');
    _FacebooktooltipBehavior = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        format: 'point.x : point.y',
        header: '');
    _FacebooktooltipBehavior1 = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        format: 'point.x : point.y',
        header: '');
    _NewsChanneltooltipBehavior = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        format: 'point.x : point.y',
        header: '');
    _NewsChanneltooltipBehavior1 = TooltipBehavior(
        enable: true,
        canShowMarker: false,
        format: 'point.x : point.y',
        header: '');
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool tempbool = false;

  SwiperLayout swiperlayout = SwiperLayout.DEFAULT;
  PageController PageCount = PageController();

  bool touchtoflip = false;
  bool carddirection = false;
  List youtubelink = [];
  int duration = Duration.microsecondsPerMillisecond;
  List<String> assetimage = [
    'assets/news.gif',
    'assets/social.gif',
    'assets/analysis.gif',
    'assets/survey.gif'
  ];
  ScrollController? scrollController = ScrollController();
  FlipCardController? flipCardController = FlipCardController();

  var WeatherDataResult;

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final GlobalKey _first = GlobalKey();
  final GlobalKey _second = GlobalKey();
  final GlobalKey _fourth = GlobalKey();
  final GlobalKey _third = GlobalKey();
  final GlobalKey _fifth = GlobalKey();
  final GlobalKey _sixth = GlobalKey();
  bool selected = false;

  double _height = 270;

  bool ishidden = true;

  @override
  Widget build(BuildContext context) {
    List<Widget>? swipeimage = [
      YoutubeBanner(),
      NewsChannelBanner(),
      FaceBookBanner(),
      TwitterBanner(),
    ];
    List<Widget>? Expswiperimage = [
      YoutubeExpBanner(),
      NewsChannelExpBanner(),
      FacebookExpBanner(),
      TwitterExpBanner(),
    ];
    final themeMode = Provider.of<DarkMode>(context);

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            floatingActionButton: DraggableFab(
              child: SpeedDial(
                //Speed dial menu
                //margin bottom
                icon: Icons
                    .dashboard_customize_outlined, //icon on Floating action button
                activeIcon: Icons.close, //icon when menu is expanded on button
                backgroundColor: Color(0xff86a8e7), //background color of button
                foregroundColor:
                Colors.black, //font color, icon color in button
                activeBackgroundColor:
                Color(0xff86a8e7), //background color when menu is expanded
                activeForegroundColor: Colors.black,
                buttonSize: Size(56, 56), //button size
                visible: true,
                closeManually: false,
                curve: Curves.bounceIn,
                overlayColor: Colors.black,
                overlayOpacity: 0.0,
                onOpen: () => print('OPENING DIAL'), // action when menu opens
                onClose: () => print('DIAL CLOSED'), //action when menu closes

                elevation: 8.0, //shadow elevation of button
                shape: CircleBorder(), //shape of button

                children: [
                  SpeedDialChild(
                    //speed dial child
                    child: Icon(Icons.info),
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    label: 'TUTORIAL',
                    labelStyle: TextStyle(fontSize: 13.0),
                    onTap: () {
                      WidgetsBinding.instance.addPostFrameCallback(
                            (_) => ShowCaseWidget.of(context).startShowCase(
                            [_fifth, _second, _sixth, _first, _third, _fourth]),
                      );
                    },
                    onLongPress: () => print('FIRST CHILD LONG PRESS'),
                  ),
                  SpeedDialChild(
                    child: Icon(Icons.brush),
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    label: 'CUSTOMISATION',
                    labelStyle: TextStyle(fontSize: 13.0),
                    onTap: () {
                      showMaterialModalBottomSheet(
                          elevation: 10,
                          bounce: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('PREFERENCES',
                                          style: GoogleFonts.bebasNeue(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(15)),
                                          tileColor: Colors.blue.shade100,
                                          onTap: () {
                                            setState(() {
                                              carddirection = !carddirection;
                                            });
                                            Navigator.pop(context);
                                          },
                                          leading: Text(
                                            'Scroll Direction',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          trailing: carddirection == false
                                              ? Text('Vertical')
                                              : Text('Horizontal')),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ExpansionTile(
                                        collapsedShape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                        title: Text(''),
                                        backgroundColor: Colors.blue.shade100,
                                        leading: Text('Custom Swipe'),
                                        collapsedBackgroundColor:
                                        Colors.blue.shade100,
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              setState(() {
                                                swiperlayout =
                                                    SwiperLayout.STACK;
                                              });

                                              Navigator.pop(context);
                                            },
                                            leading: Text(
                                              'STACKED',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              setState(() {
                                                swiperlayout =
                                                    SwiperLayout.TINDER;
                                              });

                                              Navigator.pop(context);
                                            },
                                            leading: Text(
                                              'SHADOW VIEW',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              setState(() {
                                                swiperlayout =
                                                    SwiperLayout.DEFAULT;
                                              });

                                              Navigator.pop(context);
                                            },
                                            leading: Text(
                                              'DEFAULT VIEW',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ExpansionTile(
                                        collapsedShape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                        title: Text(''),
                                        backgroundColor: Colors.blue.shade100,
                                        leading: Text('Swipe Speed'),
                                        collapsedBackgroundColor:
                                        Colors.blue.shade100,
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              setState(() {
                                                duration = 2200;
                                              });

                                              Navigator.pop(context);
                                            },
                                            leading: Text(
                                              'SLOW',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              setState(() {
                                                duration = Duration
                                                    .microsecondsPerMillisecond;
                                              });

                                              Navigator.pop(context);
                                            },
                                            leading: Text(
                                              'MEDIUM',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          ListTile(
                                            onTap: () {
                                              setState(() {
                                                duration = 10;
                                              });

                                              Navigator.pop(context);
                                            },
                                            leading: Text(
                                              'FAST',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    onLongPress: () => print('SECOND CHILD LONG PRESS'),
                  ),

                  //add more menu item childs here
                ],
              ),
            ),
            key: _key,
            appBar: AppBar(
              leading: Showcase(
                tooltipBackgroundColor: Colors.green.shade100,
                title: "APP DRAWER",
                description: "DS Knowlegde Base",
                descTextStyle: TextStyle(fontSize: 13, color: Colors.black),
                descriptionPadding: EdgeInsets.all(4),
                titleAlignment: TextAlign.center,
                titleTextStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                key: _fifth,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _key.currentState!.openDrawer();
                      },
                    ),
                  ],
                ),
              ),
              title: Image.asset(
                'assets/new Updated images/AppIcon.gif',
                fit: BoxFit.contain,
                height: 45,
                width: 200,
              ),
              elevation: 0,
              backgroundColor:
              themeMode.darkMode ? Color(0xff333333) : Colors.white,
              actions: [
                Showcase(
                  tooltipBackgroundColor: Colors.green.shade100,
                  key: _second,
                  title: "STATE ANALYTICS",
                  descTextStyle: TextStyle(fontSize: 13, color: Colors.black),
                  descriptionPadding: EdgeInsets.all(4),
                  titleAlignment: TextAlign.center,
                  titleTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  description:
                  'Trending\nShow data based on keyword, hashtag and etc.',
                  child: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StateOverviewScreen()));
                      },
                      icon: Image.asset(
                        'assets/new Updated images/megaphone.png',
                        height: 20,
                      )),
                ),
                Showcase(
                  tooltipBackgroundColor: Colors.green.shade100,
                  key: _sixth,
                  title: "NOTIFICATION",
                  description: "Show analytics data",
                  descTextStyle: TextStyle(fontSize: 13, color: Colors.black),
                  descriptionPadding: EdgeInsets.all(4),
                  titleAlignment: TextAlign.center,
                  titleTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  child: IconButton(
                      color: Colors.black,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Notifications()));
                      },
                      icon: Image.asset(
                        'assets/new Updated images/Notifications.png',
                        height: 20,
                      )),
                ),
                // IconButton(
                //     onPressed: () {

                //     },
                //     icon: Icon(
                //       Icons.info_rounded,
                //       color: Colors.blueAccent,
                //     )),
              ],
            ),
            drawer: drawer(),
            body: ListView(shrinkWrap: true, children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: FadeInUp(
                  from: 100,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/new Updated images/animation-lnk4dhsw-small-unscreen.gif',
                        height: 25,
                        width: 25,
                      ),
                      Text(
                        'QUICK BATTLES',
                        style: GoogleFonts.teko(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              ishidden = !ishidden;
                            });
                          },
                          icon: Icon(ishidden
                              ? Icons.arrow_drop_up_outlined
                              : Icons.arrow_drop_down_outlined)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Showcase(
                  tooltipBackgroundColor: Colors.green.shade100,
                  key: _first,
                  description: 'Banners with latest analytics',
                  child: FadeInUp(
                    from: 350,
                    duration: Duration(milliseconds: 700),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: ishidden ? _height : 0,
                      onEnd: () {
                        setState(() {
                          if (ishidden == false) {
                            isanimationcomplete = false;
                          } else if (ishidden == true) {
                            isanimationcomplete = true;
                          }
                        });
                      },
                      width: MediaQuery.of(context).size.width,
                      child: ishidden
                          ? Swiper(
                        duration: 1500,
                        itemBuilder: (BuildContext context, int index) {
                          return OpenContainer(
                            closedElevation: 0,
                            closedColor: themeMode.darkMode
                                ? Color(0xff333333)
                                : Colors.white,
                            openShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            closedShape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                            ),
                            transitionType: ContainerTransitionType.fade,
                            transitionDuration:
                            const Duration(milliseconds: 1500),
                            openBuilder: (context, action) {
                              return Expswiperimage[index];
                            },
                            closedBuilder: (context, action) {
                              return isanimationcomplete
                                  ? swipeimage[index]
                                  : Container();
                            },
                          );
                        },
                        itemCount: 4,
                        autoplay: true,
                      )
                          : Container(),
                    ),
                  ),
                ),
              ),

              FadeInUp(
                from: 300,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/NotificationIcons/News-Paper.png',
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(width: 5,),
                      Text(
                        'NEWS',
                        style: GoogleFonts.teko(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            shownews = !shownews;
                          });
                        },
                        icon: shownews == true
                            ? Icon(Icons.arrow_drop_up_outlined)
                            : Icon(Icons.arrow_drop_down_outlined),
                      ),
                    ],
                  ),
                ),
              ),

              //main card
              Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: shownews == true
                      ? FadeInUp(
                    from: 350,
                    duration: Duration(milliseconds: 700),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Showcase(
                          tooltipBackgroundColor: Colors.green.shade100,
                          key: _third,
                          description: "Television Media News Analytics",
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                homePageController.newsdata == null
                                    ? loader()
                                    : NewsPaperWidget(),
                                //Newschannel
                                homePageController.newchannelldata == null
                                    ? loader()
                                    : NewsChannelWidget(),
                                //Live News
                                homePageController.Livenewsdata == null
                                    ? loader()
                                    : LiveNewsWidget(),
                                //Google Trends
                                homePageController.GoogleTrendsdata ==
                                    null
                                    ? loader()
                                    : GoogletrendsWidget()
                              ]),
                        )),
                  )
                      : Container()),

              //todo:social media

              FadeInUp(
                from: 300,
                child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: AnimatedContainer(
                        duration: Duration(seconds: 2),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/new Updated images/social-media-icons-unscreen.gif',
                              height: 30,
                              width: 30,
                            ),
                            Text(
                              'SOCIAL MEDIA',
                              style: GoogleFonts.teko(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  showSocialnews = !showSocialnews;
                                });
                              },
                              icon: showSocialnews == true
                                  ? Icon(Icons.arrow_drop_up_outlined)
                                  : Icon(Icons.arrow_drop_down_outlined),
                            ),
                          ],
                        ))),
              ),

              showSocialnews == true
                  ? FadeInUp(
                from: 400,
                child: Padding(
                  padding:  EdgeInsets.only(left: 8.0, right: 8),
                  child: SingleChildScrollView(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    scrollDirection: Axis.horizontal,
                    child: Showcase(
                      tooltipBackgroundColor: Colors.green.shade100,
                      key: _fourth,
                      description: "Social Media News Analytics",
                      child: Row(
                        children: [
                          //Youtube News
                          homePageController.Youtubedata == null
                              ? loader()
                              : YoutubeWidget(),

                          //Twitter news
                          homePageController.TwitterData == null
                              ? loader()
                              : TwitterWidget(),
                          //FaceBook News
                          homePageController.Facebookdata == null
                              ? loader()
                              : FacebookWidget(),
                          //Instagram news
                          homePageController.Instagramdata == null
                              ? loader()
                              : InstagramWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
                  : Container(),
              SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 5,
                      crossAxisSpacing: 0,
                      shrinkWrap: true,
                      children: [
                        Column(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllCandidateList()));
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Image.asset(
                                  "assets/new Updated images/intellisensesolutions-Icons-62.png",
                                  height: 30,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Candidature Analysis',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          )
                        ]),
                        Column(children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Image.asset(
                                  "assets/new Updated images/intellisensesolutions-Icons-73 (1).png",
                                  height: 30,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                          Text(
                            'Constituency Analysis',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ]),
                        Column(children: [
                          GestureDetector(
                            onTap: () {
                              PageCount.jumpToPage(7);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Image.asset(
                                  "assets/new Updated images/intellisensesolutions-Icons-78.png",
                                  height: 30,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                          Text(
                            'District Analysis',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ]),
                        Column(children: [
                          GestureDetector(
                            onTap: () {
                              PageCount.jumpToPage(7);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Image.asset(
                                  "assets/new Updated images/intellisensesolutions-Icons-74.png",
                                  height: 30,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                          Text(
                            'Communication Channel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ]),
                        Column(children: [
                          GestureDetector(
                            onTap: () {
                              PageCount.jumpToPage(7);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Image.asset(
                                  "assets/new Updated images/intellisensesolutions-Icons-75.png",
                                  height: 30,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                          Text(
                            'Survey',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ]),
                        Column(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ElectoralAnalysis()));
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Image.asset(
                                  "assets/new Updated images/intellisensesolutions-Icons-79.png",
                                  height: 30,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                          Text(
                            'Electoral Analysis',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ]),
                        Column(children: [
                          GestureDetector(
                            onTap: () {
                              PageCount.jumpToPage(7);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Image.asset(
                                  "assets/new Updated images/news-71.png",
                                  height: 30,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                          Text(
                            'News Feed',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ]),
                        Column(children: [
                          GestureDetector(
                            onTap: () {
                              PageCount.jumpToPage(7);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Image.asset(
                                  "assets/new Updated images/intellisensesolutions-Icons-80.png",
                                  height: 30,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                          Text(
                            'Face Emotion Analysis',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ]),
                        Column(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScoreCardsScreen()));
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Image.asset(
                                  "assets/new Updated images/intellisensesolutions-Icons-77.png",
                                  height: 30,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                          Text(
                            'Score Card',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ]),
                        Column(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScoreCardsScreen()));
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Image.asset(
                                  "assets/new Updated images/intellisensesolutions-Icons-81.png",
                                  height: 30,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                          Text(
                            'Chat Analysis',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ]),
                        Column(children: [
                          GestureDetector(
                            onTap: () {
                              PageCount.jumpToPage(7);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Image.asset(
                                  "assets/new Updated images/intellisensesolutions-Icons-76.png",
                                  height: 30,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                          Text(
                            'Sentiment Analysis',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          )
                        ]),
                      ],
                    ),
                  ],
                ),
              ),


            ])));
  }

  OverlayEntry? overlay1;
  void _showOverlay(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);

    overlay1 = OverlayEntry(builder: (context) {
      return Positioned(
        left: MediaQuery.of(context).size.width * 0.1,
        top: MediaQuery.of(context).size.height * 0.3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.11,
            color: Colors.white,
            child: Material(
              color: Colors.transparent,
              child: Text('The Flutter app developers at FlutterDevs have',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      //fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ),
          ),
        ),
      );
    });

    overlayState.insertAll([
      overlay1!,
    ]);
  }

  bool viewnews = true;

  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
    "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
  ];
  bool isytvisible = false;
  YoutubeBanner() {
    final themeMode = Provider.of<DarkMode>(context);
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: isytvisible
              ? FutureBuilder<dynamic>(
            future: LineChartfuturecall,
            builder: (
                BuildContext context,
                AsyncSnapshot<dynamic> snapshot,
                ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinKitCubeGrid(
                  color: Colors.blue,
                  size: 50,
                );
              } else if (snapshot.connectionState ==
                  ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 40,
                          left: 105,
                          child: Image.asset(
                            'assets/new Updated images/versus.png',
                            height: 84,
                          ),
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.redAccent,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(15)),
                                  height: 120,
                                  width: 120,
                                  child: SfCircularChart(
                                      tooltipBehavior: _tooltipBehavior1,
                                      palette: [
                                        Color.fromRGBO(19, 136, 8, 0),
                                        Color.fromRGBO(254, 1, 117, 0),
                                        Color.fromRGBO(249, 125, 9, 0),
                                      ],
                                      series: <PieSeries<ChartSampleData,
                                          String>>[
                                        PieSeries<ChartSampleData,
                                            String>(
                                            explode: true,
                                            explodeIndex: 0,
                                            explodeOffset: '10%',
                                            dataSource: <ChartSampleData>[
                                              ...PiegraphChartData
                                            ],
                                            xValueMapper:
                                                (ChartSampleData data,
                                                _) =>
                                            data.x as String,
                                            yValueMapper:
                                                (ChartSampleData data,
                                                _) =>
                                            data.y,
                                            dataLabelMapper:
                                                (ChartSampleData data,
                                                _) =>
                                            data.text,
                                            startAngle: 90,
                                            endAngle: 90,
                                            dataLabelSettings:
                                            const DataLabelSettings(
                                                isVisible: true)),
                                      ]),
                                ),
                                Text(
                                  'FOLLOWERS',
                                  style: GoogleFonts.bitter(fontSize: 10),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Column(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.redAccent),
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                    height: 120,
                                    width: 120,
                                    child: SfFunnelChart(
                                        palette: [
                                          Color.fromRGBO(19, 136, 8, 0),
                                          Color.fromRGBO(254, 1, 117, 0),
                                          Color.fromRGBO(249, 125, 9, 0),
                                        ],
                                        //title: ChartTitle(text: isCardView ? '' : 'Website conversion rate'),
                                        tooltipBehavior:
                                        TooltipBehavior(enable: true),
                                        series: FunnelSeries<
                                            ChartSampleData, String>(
                                            dataSource: <ChartSampleData>[
                                              ...FunnelgraphChartData,
                                            ],
                                            xValueMapper:
                                                (ChartSampleData data, _) =>
                                            data.x as String,
                                            yValueMapper:
                                                (ChartSampleData data, _) =>
                                            data.y,
                                            /*  explode: isCardView ? false : explode,
                              gapRatio: isCardView ? 0 : gapRatio,*/
                                            neckHeight: /*isCardView ? */
                                            '20%' /*: neckHeight.toString()*/ +
                                                '%',
                                            neckWidth: /*isCardView ?*/
                                            '25%' /*: neckWidth.toString()*/ +
                                                '%',
                                            dataLabelSettings:
                                            const DataLabelSettings(
                                                textStyle:
                                                TextStyle(fontSize: 8),
                                                isVisible: true)))),
                                Text(
                                  'Re-Tweet',
                                  style: GoogleFonts.bitter(fontSize: 10),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 1.0, top: 60),
                              child: Image.asset(
                                'assets/icons/Social-Media-Icons-IS-10.png',
                                height: 18,
                                width: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 140.0, left: 5),
                              child: Container(
                                height: 150,
                                width: 150,
                                child: RichText(
                                  text: new TextSpan(
                                    style: new TextStyle(
                                      fontSize: 12.0,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: BarGraphdata['lead'][0],
                                          style:  GoogleFonts.bitter(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 16,
                                          )),
                                      TextSpan(
                                          text: ' is overpowering ',
                                          style: GoogleFonts.bitter(
                                            fontWeight: FontWeight.bold,
                                            color: themeMode.darkMode
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16,
                                          )),
                                      TextSpan(
                                          text: "BJP",
                                          style:  GoogleFonts.bitter(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 16,
                                          )),
                                      TextSpan(
                                          text: ' in all aspects',
                                          style: GoogleFonts.bitter(
                                            fontWeight: FontWeight.bold,
                                            color: themeMode.darkMode
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 100.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.redAccent),
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                    height: 100,
                                    width: 135,
                                    child: SfCartesianChart(
                                      palette: <Color>[
                                        Color(0xffff7f50),
                                        Color(0xfff0ead6),
                                        Color(0xffffd700),
                                      ],
                                      plotAreaBorderWidth: 0,
                                      primaryXAxis: CategoryAxis(
                                        labelStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 8),
                                        axisLine:
                                        const AxisLine(width: 0),
                                        labelPosition:
                                        ChartDataLabelPosition
                                            .outside,
                                        majorTickLines:
                                        const MajorTickLines(
                                            width: 0),
                                        majorGridLines:
                                        const MajorGridLines(
                                            width: 0),
                                      ),
                                      primaryYAxis: NumericAxis(
                                          labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 8),
                                          labelPosition:
                                          ChartDataLabelPosition
                                              .outside,
                                          isVisible: false,
                                          minimum: 0,
                                          maximum: 2000),
                                      series: <ColumnSeries<
                                          ChartSampleData, String>>[
                                        ColumnSeries<ChartSampleData,
                                            String>(
                                          width: 0.9,
                                          dataLabelSettings:
                                          const DataLabelSettings(
                                              isVisible: false,
                                              labelAlignment:
                                              ChartDataLabelAlignment
                                                  .top),
                                          dataSource: <ChartSampleData>[
                                            ...BargraphChartdata
                                          ],
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          xValueMapper:
                                              (ChartSampleData sales,
                                              _) =>
                                          sales.x as String,
                                          yValueMapper:
                                              (ChartSampleData sales,
                                              _) =>
                                          sales.y,
                                        ),
                                      ],
                                      tooltipBehavior: _tooltipBehavior,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Likes',
                                  style: GoogleFonts.bitter(fontSize: 10),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          )
              : Center(
              child: SpinKitCubeGrid(
                color: Colors.blue,
                size: 50,
              )

            // Text('Loading...'),
          ),
        ),
      ),
    );
  }

//Youtube top party list api
  var YoutubeTopPartylistdata;
  var locallist = [];
  List<DataColumn> Youtubetablecolumn = [];
  YoutubeTopPartylistApi() async {
    //print('YT top');
    var body = json.encode({
      "type": "top_parties",
      "STATE": "TELANGANA",
      "social_handle": "YOUTUBE"
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_YT/'),
        headers: headers,
        body: body);

    //print(response.statusCode);
    if (response.statusCode == 200) {
      //debugPrint("i have loaded");
      try {
        setState(() {
          YoutubeTopPartylistdata = jsonDecode(utf8.decode(response.bodyBytes));
          locallist = YoutubeTopPartylistdata['top_parties'];
          LineChartfuturecall = YoutubeBannerGraphApi();
          isytvisible = true;
        });
        //print(locallist.toList());
      } catch (e) {
        //print(YoutubeTopPartylistdata);
      }
    } else {
      //print(response.reasonPhrase);
    }
    return YoutubeTopPartylistdata;
  }

  //Bar Graph data
  var BarGraphdata;
  Map Selectionquery1 = new Map<String, dynamic>();
  List<ChartSampleData> BargraphChartdata = [];
  List<ChartSampleData> PiegraphChartData = [];
  List<ChartSampleData> FunnelgraphChartData = [];
  Future<dynamic> YoutubeBannerGraphApi() async {
    var body = json.encode({
      "type": "party_data",
      "STATE": 'TELANGANA',
      "party_list": locallist.join(""),
      "social_handle": "YOUTUBE"
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_YT/'),
        headers: headers,
        body: body);
    //print(response.statusCode);
    if (response.statusCode == 200) {
      //print('inside loop');
      try {
        //print('inside try');
        BarGraphdata = jsonDecode(utf8.decode(response.bodyBytes));

        BarGraphdata['party_data'].forEach((key, value) {
          //print(key);

          BargraphChartdata.add(
            ChartSampleData(
                x: '$key', y: BarGraphdata['party_data'][key][0]['LIKES']),
          );
          PiegraphChartData.add(
            ChartSampleData(
                x: '$key',
                y: BarGraphdata['party_data'][key][0]['COMMENTS'],
                text: '$key'),
          );
          FunnelgraphChartData.add(
            ChartSampleData(
                x: '$key',
                y: BarGraphdata['party_data'][key][0]['VIEWS'],
                text: '$key'),
          );
        });

        //print('data here');
        //print(BarGraphdata);
      } catch (e) {
        //print(BarGraphdata);
      }
    } else {
      //print(response.reasonPhrase);
    }
    return BarGraphdata;
  }

  //Twitter Banner
  late Future<dynamic> TwitterLineChartfuturecall;
  TooltipBehavior? _TwittertooltipBehavior;
  TooltipBehavior? _TwittertooltipBehavior1;
  bool isTwitterdataloaded = false;
  TwitterBanner() {
    final themeMode = Provider.of<DarkMode>(context);
    return Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: isTwitterdataloaded
                ? FutureBuilder<dynamic>(
              future: TwitterLineChartfuturecall,
              builder: (
                  BuildContext context,
                  AsyncSnapshot<dynamic> snapshot,
                  ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitCubeGrid(
                    color: Colors.blue,
                    size: 50,
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 40,
                            left: 105,
                            child: Image.asset(
                              'assets/new Updated images/versus.png',
                              height: 84,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blue.shade600),
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                    height: 120,
                                    width: 120,
                                    child: SfCircularChart(
                                        tooltipBehavior:
                                        _TwittertooltipBehavior1,
                                        palette: [
                                          Colors.yellow,
                                          Colors.yellowAccent,
                                          Color.fromRGBO(218, 40, 36, 0),
                                        ],
                                        series: <PieSeries<ChartSampleData,
                                            String>>[
                                          PieSeries<ChartSampleData, String>(
                                              explode: true,
                                              explodeIndex: 0,
                                              explodeOffset: '10%',
                                              dataSource: <ChartSampleData>[
                                                ...TwitterPiegraphChartData
                                              ],
                                              xValueMapper:
                                                  (ChartSampleData data, _) =>
                                              data.x as String,
                                              yValueMapper:
                                                  (ChartSampleData data, _) =>
                                              data.y,
                                              dataLabelMapper:
                                                  (ChartSampleData data, _) =>
                                              data.text,
                                              startAngle: 90,
                                              endAngle: 90,
                                              dataLabelSettings:
                                              const DataLabelSettings(
                                                  isVisible: true)),
                                        ]),
                                  ),
                                  Text(
                                    'FOLLOWERS',
                                    style: GoogleFonts.bitter(fontSize: 10),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blue.shade600),
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                        height: 120,
                                        width: 120,
                                        child: SfFunnelChart(
                                            palette: [
                                              Colors.yellow,
                                              Colors.yellowAccent,
                                              Color.fromRGBO(218, 40, 36, 0),
                                            ],
                                            //title: ChartTitle(text: isCardView ? '' : 'Website conversion rate'),
                                            tooltipBehavior:
                                            TooltipBehavior(enable: true),
                                            series: FunnelSeries<
                                                ChartSampleData, String>(
                                                dataSource: <ChartSampleData>[
                                                  ...TwitterFunnelgraphChartData,
                                                ],
                                                xValueMapper:
                                                    (ChartSampleData data, _) =>
                                                data.x as String,
                                                yValueMapper:
                                                    (ChartSampleData data, _) =>
                                                data.y,
                                                /*  explode: isCardView ? false : explode,
              gapRatio: isCardView ? 0 : gapRatio,*/
                                                neckHeight: /*isCardView ? */
                                                '20%' /*: neckHeight.toString()*/ +
                                                    '%',
                                                neckWidth: /*isCardView ?*/
                                                '25%' /*: neckWidth.toString()*/ +
                                                    '%',
                                                dataLabelSettings:
                                                const DataLabelSettings(
                                                    textStyle:
                                                    TextStyle(fontSize: 8),
                                                    isVisible: true)))),
                                  ),
                                  Text(
                                    'Re-Tweet',
                                    style: GoogleFonts.bitter(fontSize: 10),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 1.0, top: 50),
                                child: Image.asset(
                                  'assets/icons/Social-Media-Icons-IS-08.png',
                                  height: 18,
                                  width: 18,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 140.0, left: 5),
                                child: Container(
                                  height: 165,
                                  width: 165,
                                  child: RichText(
                                    text: new TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: new TextStyle(
                                        fontSize: 12.0,
                                        // color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                            'With Huge Difference In counts for Tweets and Re-Tweets reports says that ',
                                            style: GoogleFonts.bitter(
                                                fontWeight: FontWeight.bold,
                                                color: themeMode.darkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 13
                                            )),
                                        TextSpan(
                                            text: TwiterBarGraphdata['lead']
                                            [0],
                                            style:  GoogleFonts.bitter(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                              fontSize: 13,
                                            )),
                                        TextSpan(
                                            text:
                                            ' is relatively Dominant in Twitter Data.',
                                            style: GoogleFonts.bitter(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: themeMode.darkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 100.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue.shade600),
                                          borderRadius:
                                          BorderRadius.circular(15)),
                                      height: 100,
                                      width: 135,
                                      child: SfCartesianChart(
                                        palette: <Color>[
                                          Color(0xffff7f50),
                                          Color(0xfff0ead6),
                                          Color(0xffffd700),
                                          Color(0xff264348),
                                        ],
                                        plotAreaBorderWidth: 0,
                                        primaryXAxis: CategoryAxis(
                                          labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 8),
                                          axisLine: const AxisLine(width: 0),
                                          labelPosition:
                                          ChartDataLabelPosition.outside,
                                          majorTickLines:
                                          const MajorTickLines(width: 0),
                                          majorGridLines:
                                          const MajorGridLines(width: 0),
                                        ),
                                        primaryYAxis: NumericAxis(
                                            labelStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 8),
                                            labelPosition:
                                            ChartDataLabelPosition
                                                .outside,
                                            isVisible: false,
                                            minimum: 0,
                                            maximum: 3000),
                                        series: <ColumnSeries<ChartSampleData,
                                            String>>[
                                          ColumnSeries<ChartSampleData,
                                              String>(
                                            width: 0.9,
                                            dataLabelSettings:
                                            const DataLabelSettings(
                                                isVisible: false,
                                                labelAlignment:
                                                ChartDataLabelAlignment
                                                    .top),
                                            dataSource: <ChartSampleData>[
                                              ...TwitterBargraphChartdata
                                            ],
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            xValueMapper:
                                                (ChartSampleData sales, _) =>
                                            sales.x as String,
                                            yValueMapper:
                                                (ChartSampleData sales, _) =>
                                            sales.y,
                                          ),
                                        ],
                                        tooltipBehavior:
                                        _TwittertooltipBehavior,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Likes',
                                    style: GoogleFonts.bitter(fontSize: 10),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            )
                : Center(
              child: SpinKitCubeGrid(
                color: Colors.blue,
                size: 50,
              ),
            ),
          ),
        ));
  }

//twitter top party list
  var TopPartylistdata;
  Map TopPartylistquery = new Map<String, dynamic>();
  List twittertoppartyList = [];
  TwitterTopParty() async {
    setState(() {
      TopPartylistquery['type'] = 'top_parties';
      TopPartylistquery['STATE'] = "ANDHRA PRADESH";
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media/'),
        body: TopPartylistquery);

    print(response.statusCode);
    if (response.statusCode == 200) {
      print("in");
      try {
        print("i am dodo");
        setState(() {
          TopPartylistdata = json.decode(response.body);
          twittertoppartyList = TopPartylistdata["top_parties"];

          isTwitterdataloaded = true;
          TwitterLineChartfuturecall = TwitterBannerGraphApi();
        });

        print(twittertoppartyList.toList());
      } catch (e) {
        print(e);
        //print(TopPartylistdata);
      }
    } else {
      //print(response.reasonPhrase);
    }
    return TopPartylistdata;
  }

  //Bar Graph data
  var TwiterBarGraphdata;

  Map TwitterSelectionquery1 = new Map<String, dynamic>();
  List<ChartSampleData> TwitterBargraphChartdata = [];
  List<ChartSampleData> TwitterPiegraphChartData = [];
  List<ChartSampleData> TwitterFunnelgraphChartData = [];
  Future<dynamic> TwitterBannerGraphApi() async {
    TwitterSelectionquery1['type'] = 'party_data';
    TwitterSelectionquery1['STATE'] = 'ANDHRA PRADESH';
    TwitterSelectionquery1['party_list'] = "${twittertoppartyList.join(",")}";
    //Selectionquery['channel'] = 'YOUTUBE';

    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media/'),
        body: TwitterSelectionquery1);

    print(response.statusCode);
    if (response.statusCode == 200) {
      //print('inside loop');
      try {
        //print('inside try');
        TwiterBarGraphdata = json.decode(response.body);
        print(TwiterBarGraphdata);
        TwiterBarGraphdata['party_data'].forEach((key, value) {
          //print(key);

          TwitterBargraphChartdata.add(
            ChartSampleData(
                x: '$key',
                y: TwiterBarGraphdata['party_data'][key][0]['LIKES']),
          );
          TwitterPiegraphChartData.add(
            ChartSampleData(
                x: '$key',
                y: TwiterBarGraphdata['party_data'][key][0]['USER_FOLLOWERS'],
                text: '$key'),
          );
          TwitterFunnelgraphChartData.add(
            ChartSampleData(
                x: '$key',
                y: TwiterBarGraphdata['party_data'][key][0]['RETWEET_COUNT'],
                text: '$key'),
          );
        });


      } catch (e) {
        //print(TwiterBarGraphdata);
      }
    } else {
      //print(response.reasonPhrase);
    }
    return TwiterBarGraphdata;
  }

//FaceBook top party list api
  var FaceBookTopPartylistdata;
  var FaceBooklocallist = [];

  FaceBookTopPartylistApi() async {
    //print('FaceBook top');
    var body = json.encode({
      "type": "top_parties",
      "STATE": "TELANGANA",
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_FB/'),
        headers: headers,
        body: body);

    //print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        setState(() {
          FaceBookTopPartylistdata = json.decode(response.body);
          FaceBooklocallist = FaceBookTopPartylistdata['top_parties'];
          // Youtubefinaldata=YoutubeOverViewApi();
          FacebookLineChartfuturecall = FaceBookBannerGraphApi();
          isFacebookBannerVisible = true;
        });
        //print(FaceBooklocallist.toList());
      } catch (e) {
        //print(FaceBookTopPartylistdata);
      }
    } else {
      //print(response.reasonPhrase);
    }
    return FaceBookTopPartylistdata;
  }

//FaceBookBanners
  late Future<dynamic> FacebookLineChartfuturecall;
  TooltipBehavior? _FacebooktooltipBehavior;
  TooltipBehavior? _FacebooktooltipBehavior1;
  bool isFacebookBannerVisible = false;
  FaceBookBanner() {
    final themeMode = Provider.of<DarkMode>(context);
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: isFacebookBannerVisible
              ? FutureBuilder<dynamic>(
            future: FacebookLineChartfuturecall,
            builder: (
                BuildContext context,
                AsyncSnapshot<dynamic> snapshot,
                ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinKitCubeGrid(
                  color: Colors.blue,
                  size: 50,
                );
              } else if (snapshot.connectionState ==
                  ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 40,
                          left: 105,
                          child: Image.asset(
                            'assets/new Updated images/versus.png',
                            height: 84,
                          ),
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.blueAccent),
                                      borderRadius:
                                      BorderRadius.circular(15)),
                                  height: 120,
                                  width: 120,
                                  child: SfCircularChart(
                                      tooltipBehavior:
                                      _FacebooktooltipBehavior1,
                                      palette: [
                                        Color.fromRGBO(19, 136, 8, 0),
                                        Color.fromRGBO(254, 1, 117, 0),
                                        Color.fromRGBO(249, 125, 9, 0),
                                      ],
                                      series: <PieSeries<ChartSampleData,
                                          String>>[
                                        PieSeries<ChartSampleData,
                                            String>(
                                            explode: true,
                                            explodeIndex: 0,
                                            explodeOffset: '10%',
                                            dataSource: <ChartSampleData>[
                                              ...FaceBookPiegraphChartData
                                            ],
                                            xValueMapper:
                                                (ChartSampleData data,
                                                _) =>
                                            data.x as String,
                                            yValueMapper:
                                                (ChartSampleData data,
                                                _) =>
                                            data.y,
                                            dataLabelMapper:
                                                (ChartSampleData data,
                                                _) =>
                                            data.text,
                                            startAngle: 90,
                                            endAngle: 90,
                                            dataLabelSettings:
                                            const DataLabelSettings(
                                                isVisible: true)),
                                      ]),
                                ),
                                Text(
                                  'Likes',
                                  style: GoogleFonts.bitter(fontSize: 10),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Column(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blueAccent),
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                    height: 120,
                                    width: 120,
                                    child: SfFunnelChart(
                                        palette: [
                                          Color.fromRGBO(254, 1, 117, 0),
                                          Color.fromRGBO(19, 136, 8, 0),
                                          Color.fromRGBO(249, 125, 9, 0),
                                        ],
                                        tooltipBehavior:
                                        TooltipBehavior(enable: true),
                                        series: FunnelSeries<
                                            ChartSampleData, String>(
                                            dataSource: <ChartSampleData>[
                                              ...FaceBookFunnelgraphChartData,
                                            ],
                                            xValueMapper:
                                                (ChartSampleData data, _) =>
                                            data.x as String,
                                            yValueMapper:
                                                (ChartSampleData data, _) =>
                                            data.y,
                                            /*  explode: isCardView ? false : explode,
              gapRatio: isCardView ? 0 : gapRatio,*/
                                            neckHeight: /*isCardView ? */
                                            '20%' /*: neckHeight.toString()*/ +
                                                '%',
                                            neckWidth: /*isCardView ?*/
                                            '25%' /*: neckWidth.toString()*/ +
                                                '%',
                                            dataLabelSettings:
                                            const DataLabelSettings(
                                                textStyle:
                                                TextStyle(fontSize: 8),
                                                isVisible: true)))),
                                Text(
                                  'Comments',
                                  style: GoogleFonts.bitter(fontSize: 10),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 1.0, top: 60),
                              child: Image.asset(
                                'assets/icons/Social-Media-Icons-IS-06.png',
                                height: 18,
                                width: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 140.0, left: 5),
                              child: Container(
                                height: 150,
                                width: 150,
                                child: RichText(
                                  text: new TextSpan(
                                    // Note: Styles for TextSpans must be explicitly defined.
                                    // Child text spans will inherit styles from parent
                                    style: new TextStyle(
                                      fontSize: 12.0,
                                      // color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                          ' From Posts to public response ',
                                          style: GoogleFonts.bitter(
                                            fontWeight: FontWeight.bold,
                                            color: themeMode.darkMode
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 14,
                                          )),
                                      TextSpan(
                                          text:
                                          FaceBookBarGraphdata['lead']
                                          [0],
                                          style:  GoogleFonts.bitter(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 14,
                                          )),
                                      TextSpan(
                                          text:
                                          ' is leading in all aspects',
                                          style: GoogleFonts.bitter(
                                            fontWeight: FontWeight.bold,
                                            color: themeMode.darkMode
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 14,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 100.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blueAccent),
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                    height: 100,
                                    width: 135,
                                    child: SfCartesianChart(
                                      palette: <Color>[
                                        Color(0xffff7f50),
                                        Color(0xfff0ead6),
                                        Color(0xffffd700),
                                        Color(0xff264348),
                                      ],
                                      plotAreaBorderWidth: 0,
                                      primaryXAxis: CategoryAxis(
                                        labelStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 8),
                                        axisLine:
                                        const AxisLine(width: 0),
                                        labelPosition:
                                        ChartDataLabelPosition
                                            .outside,
                                        majorTickLines:
                                        const MajorTickLines(
                                            width: 0),
                                        majorGridLines:
                                        const MajorGridLines(
                                            width: 0),
                                      ),
                                      primaryYAxis: NumericAxis(
                                          labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 8),
                                          labelPosition:
                                          ChartDataLabelPosition
                                              .outside,
                                          isVisible: false,
                                          minimum: 0,
                                          maximum: 2000),
                                      series: <ColumnSeries<
                                          ChartSampleData, String>>[
                                        ColumnSeries<ChartSampleData,
                                            String>(
                                          width: 0.9,
                                          dataLabelSettings:
                                          const DataLabelSettings(
                                              isVisible: false,
                                              labelAlignment:
                                              ChartDataLabelAlignment
                                                  .top),
                                          dataSource: <ChartSampleData>[
                                            ...FaceBookBargraphChartdata
                                          ],
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          xValueMapper:
                                              (ChartSampleData sales,
                                              _) =>
                                          sales.x as String,
                                          yValueMapper:
                                              (ChartSampleData sales,
                                              _) =>
                                          sales.y,
                                        ),
                                      ],
                                      tooltipBehavior:
                                      _FacebooktooltipBehavior,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Views',
                                  style: GoogleFonts.bitter(fontSize: 10),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          )
              : Center(
              child: SpinKitCubeGrid(
                color: Colors.blue,
                size: 50,
              )),
        ),
      ),
    );
  }

  //Bar Graph data
  var FaceBookBarGraphdata;
  List<ChartSampleData> FaceBookBargraphChartdata = [];
  List<ChartSampleData> FaceBookPiegraphChartData = [];
  List<ChartSampleData> FaceBookFunnelgraphChartData = [];
  Future<dynamic> FaceBookBannerGraphApi() async {
    //debugPrint("Facebook top party ${FaceBooklocallist.toList()}");
    var body = json.encode({
      "type": "party_data",
      "STATE": 'TELANGANA',
      "party_list": FaceBooklocallist.join(","),
      //"social_handle": "YOUTUBE"
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_FB/'),
        headers: headers,
        body: body);

    //print(response.statusCode);
    if (response.statusCode == 200) {
      //print('inside Facebook');
      try {

        FaceBookBarGraphdata = json.decode(response.body);
        setState(() {
          FaceBookBarGraphdata['party_data'].forEach((key, value) {
            //print(key);

            FaceBookBargraphChartdata.add(
              ChartSampleData(
                  x: '$key',
                  y: FaceBookBarGraphdata['party_data'][key][0]['LIKES']),
            );
            FaceBookPiegraphChartData.add(
              ChartSampleData(
                  x: '$key',
                  y: FaceBookBarGraphdata['party_data'][key][0]['COMMENTS'],
                  text: '$key'),
            );
            FaceBookFunnelgraphChartData.add(
              ChartSampleData(
                  x: '$key',
                  y: FaceBookBarGraphdata['party_data'][key][0]['SHARES'],
                  text: '$key'),
            );
          });


        });
        //print('data here');
        //print(FaceBookBarGraphdata);
      } catch (e) {
        //print(FaceBookBarGraphdata);
      }
    } else {
      //print(response.reasonPhrase);
    }
    return FaceBookBarGraphdata;
  }

//NewsChannel top party list api
  var NewsChannelTopPartylistdata;
  var NewsChannellocallist = [];

  NewsChannelTopPartylistApi() async {
    //print('YT top');
    var body = json.encode({
      "type": "top_parties",
      "STATE": "ANDHRA PRADESH",
      "social_handle": "NEWS_CHANNEL"
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_YT/'),
        headers: headers,
        body: body);

    //print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        setState(() {
          NewsChannelTopPartylistdata =
              jsonDecode(utf8.decode(response.bodyBytes));
          NewsChannellocallist = NewsChannelTopPartylistdata['top_parties'];
          NewschannelLineChartfuturecall = NewsChannelBannerGraphApi();
          isNewsChannelBannerisible = true;
        });

      } catch (e) {
        //print(NewsChannelTopPartylistdata);
      }
    } else {

    }
    return NewsChannelTopPartylistdata;
  }

  //NewsChannel Banner
  late Future<dynamic> NewschannelLineChartfuturecall;
  TooltipBehavior? _NewsChanneltooltipBehavior;
  TooltipBehavior? _NewsChanneltooltipBehavior1;

  bool isNewsChannelBannerisible = false;
  NewsChannelBanner() {
    final themeMode = Provider.of<DarkMode>(context);
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: isNewsChannelBannerisible
              ? FutureBuilder<dynamic>(
            future: NewschannelLineChartfuturecall,
            builder: (
                BuildContext context,
                AsyncSnapshot<dynamic> snapshot,
                ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinKitCubeGrid(
                  color: Colors.blue,
                  size: 50,
                );
              } else if (snapshot.connectionState ==
                  ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 40,
                          left: 105,
                          child: Image.asset(
                            'assets/new Updated images/versus.png',
                            height: 84,
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 140,
                          child: Text(
                            NewsChannelBarGraphdata['lead'][0],
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Positioned(
                          top: 105,
                          left: 180,
                          child: Text(
                            'INC',
                            style: GoogleFonts.bitter(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.greenAccent),
                                      borderRadius:
                                      BorderRadius.circular(15)),
                                  height: 120,
                                  width: 120,
                                  child: SfCircularChart(
                                      tooltipBehavior:
                                      _NewsChanneltooltipBehavior1,
                                      palette: [
                                        Color.fromRGBO(255, 255, 0, 0),
                                        Color.fromRGBO(254, 1, 117, 0),
                                        Color(0x00008E46),
                                        Color.fromRGBO(236, 13, 195, 0),
                                      ],
                                      series: <PieSeries<ChartSampleData,
                                          String>>[
                                        PieSeries<ChartSampleData,
                                            String>(
                                            explode: true,
                                            explodeIndex: 0,
                                            explodeOffset: '10%',
                                            dataSource: <ChartSampleData>[
                                              ...NewsChannelPiegraphChartData

                                            ],
                                            xValueMapper:
                                                (ChartSampleData data,
                                                _) =>
                                            data.x as String,
                                            yValueMapper:
                                                (ChartSampleData data,
                                                _) =>
                                            data.y,
                                            dataLabelMapper:
                                                (ChartSampleData data,
                                                _) =>
                                            data.text,
                                            startAngle: 90,
                                            endAngle: 90,
                                            dataLabelSettings:
                                            const DataLabelSettings(
                                                isVisible: true)),
                                      ]),
                                ),
                                Text(
                                  'Likes',
                                  style: GoogleFonts.bitter(fontSize: 10),
                                ),
                              ],
                            ),

                            SizedBox(
                              width: 60,
                            ),

                            Column(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.greenAccent),
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                    height: 120,
                                    width: 120,
                                    child: SfFunnelChart(
                                        palette: [
                                          Color.fromRGBO(255, 255, 0, 0),
                                          Color.fromRGBO(0, 142, 70, 0),
                                          Color.fromRGBO(255, 255, 0, 0),
                                          Color.fromRGBO(236, 13, 195, 0),
                                        ],
                                        //title: ChartTitle(text: isCardView ? '' : 'Website conversion rate'),
                                        tooltipBehavior:
                                        TooltipBehavior(enable: true),
                                        series: FunnelSeries<
                                            ChartSampleData, String>(
                                            dataSource: <ChartSampleData>[
                                              ...NewsChannelFunnelgraphChartData,
                                            ],
                                            xValueMapper:
                                                (ChartSampleData data, _) =>
                                            data.x as String,
                                            yValueMapper:
                                                (ChartSampleData data, _) =>
                                            data.y,
                                            /*  explode: isCardView ? false : explode,
              gapRatio: isCardView ? 0 : gapRatio,*/
                                            neckHeight: /*isCardView ? */
                                            '20%' /*: neckHeight.toString()*/ +
                                                '%',
                                            neckWidth: /*isCardView ?*/
                                            '25%' /*: neckWidth.toString()*/ +
                                                '%',
                                            dataLabelSettings:
                                            const DataLabelSettings(
                                                textStyle:
                                                TextStyle(fontSize: 8),
                                                isVisible: true)))),
                                Text(
                                  'Comments',
                                  style: GoogleFonts.bitter(fontSize: 10),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, top: 60),
                              child: Image.asset(
                                'assets/NotificationIcons/News-Paper.png',
                                height: 29,
                                width: 29,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 140.0, left: 5),
                              child: Container(
                                height: 100,
                                width: 150,
                                child: RichText(
                                  text: new TextSpan(
                                    // Note: Styles for TextSpans must be explicitly defined.
                                    // Child text spans will inherit styles from parent
                                    style: new TextStyle(
                                      fontSize: 12.0,
                                      // color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: NewsChannelBarGraphdata[
                                          'lead'][0],
                                          style:  GoogleFonts.bitter(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 20,
                                          )),
                                      TextSpan(
                                          text: ' is overpowering ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: themeMode.darkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Segoe UI')),
                                      TextSpan(
                                          text: "Multiple Parties",
                                          style:  GoogleFonts.bitter(
                                            fontWeight: FontWeight.bold,
                                            color: themeMode.darkMode
                                                ? Colors.white
                                                : Colors.black,
                                            //color: Colors.red,
                                            fontSize: 16,
                                          )),
                                      TextSpan(
                                          text: ' in all aspects.',
                                          style: GoogleFonts.bitter(
                                            fontWeight: FontWeight.bold,
                                            color: themeMode.darkMode
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 100.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.greenAccent),
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                    height: 100,
                                    width: 135,
                                    child: SfCartesianChart(
                                      palette: <Color>[
                                        Color(0xffff7f50),
                                        Color(0xfff0ead6),
                                        Color(0xffffd700),
                                        Color(0xff264348),
                                      ],
                                      plotAreaBorderWidth: 0,
                                      primaryXAxis: CategoryAxis(
                                        labelStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 8),
                                        axisLine:
                                        const AxisLine(width: 0),
                                        labelPosition:
                                        ChartDataLabelPosition
                                            .outside,
                                        majorTickLines:
                                        const MajorTickLines(
                                            width: 0),
                                        majorGridLines:
                                        const MajorGridLines(
                                            width: 0),
                                      ),
                                      primaryYAxis: NumericAxis(
                                          labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 8),
                                          labelPosition:
                                          ChartDataLabelPosition
                                              .outside,
                                          isVisible: false,
                                          minimum: 0,
                                          maximum: 800),
                                      series: <ColumnSeries<
                                          ChartSampleData, String>>[
                                        ColumnSeries<ChartSampleData,
                                            String>(
                                          width: 0.9,
                                          dataLabelSettings:
                                          const DataLabelSettings(
                                              isVisible: false,
                                              labelAlignment:
                                              ChartDataLabelAlignment
                                                  .top),
                                          dataSource: <ChartSampleData>[
                                            ...NewsChannelBargraphChartdata
                                          ],
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          xValueMapper:
                                              (ChartSampleData sales,
                                              _) =>
                                          sales.x as String,
                                          yValueMapper:
                                              (ChartSampleData sales,
                                              _) =>
                                          sales.y,
                                        ),
                                      ],
                                      tooltipBehavior:
                                      _NewsChanneltooltipBehavior,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Views',
                                  style: GoogleFonts.bitter(fontSize: 10),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          )
              : SpinKitCubeGrid(
            color: Colors.blue,
            size: 50,
          ),
        ),
      ),
    );
  }

  //Bar Graph data
  var NewsChannelBarGraphdata;

  Map NewschannelSelectionquery1 = new Map<String, dynamic>();
  List<ChartSampleData> NewsChannelBargraphChartdata = [];
  List<ChartSampleData> NewsChannelPiegraphChartData = [];
  List<ChartSampleData> NewsChannelFunnelgraphChartData = [];
  Future<dynamic> NewsChannelBannerGraphApi() async {
    var body = json.encode({
      "type": "party_data",
      "STATE": 'ANDHRA PRADESH',
      "party_list": NewsChannellocallist.join(""),
      "social_handle": "NEWS_CHANNEL"
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_YT/'),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      try {
        NewsChannelBarGraphdata = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          NewsChannelBarGraphdata['party_data'].forEach((key, value) {
            NewsChannelBargraphChartdata.add(
              ChartSampleData(
                  x: '$key',
                  y: NewsChannelBarGraphdata['party_data'][key][0]['LIKES']),
            );
            NewsChannelPiegraphChartData.add(
              ChartSampleData(
                  x: '$key',
                  y: NewsChannelBarGraphdata['party_data'][key][0]['COMMENTS'],
                  text: '$key'),
            );
            NewsChannelFunnelgraphChartData.add(
              ChartSampleData(
                  x: '$key',
                  y: NewsChannelBarGraphdata['party_data'][key][0]['VIEWS'],
                  text: '$key'),
            );
          });
        });
      } catch (e) {}
    } else {}
    return NewsChannelBarGraphdata;
  }

  Widget loader() {
    return Padding(
      padding: const EdgeInsets.only(top: 70.0),
      child: SizedBox(
        height: 150,
        width: 150,
        child: Center(
            child: SpinKitWave(
              color: Colors.blue,
              size: 18,
            )),
      ),
    );
  }

  Widget NewsPaperWidget() {
    return Opencontainer(
      openBuilder: DiscoverPage(initialPage: 0),
      closedBuilder: Newpaperlist,
      duration: duration,
      swiperLayout: swiperlayout,
      axis: carddirection,
    );
  }

  //NewsChannel widget
  Widget NewsChannelWidget() {
    return Opencontainer(
        openBuilder: DiscoverPage(initialPage: 1),
        closedBuilder: NewschannelList,
        duration: duration,
        swiperLayout: swiperlayout,
        axis: carddirection);
  }

  Widget LiveNewsWidget() {
    return Opencontainer(
        openBuilder: DiscoverPage(initialPage: 2),
        closedBuilder: LiveNewsList,
        duration: duration,
        swiperLayout: swiperlayout,
        axis: carddirection);
  }

  //Google trends
  Widget GoogletrendsWidget() {
    return Opencontainer(
        openBuilder: DiscoverPage(initialPage: 3),
        closedBuilder: GoogleTrendsList,
        duration: duration,
        swiperLayout: swiperlayout,
        axis: carddirection);
  }

//Youtube news
  Widget YoutubeWidget() {
    return Opencontainer(
        openBuilder: YouTubeScreen(),
        closedBuilder:  YoutubeList,
        duration: duration,
        swiperLayout: swiperlayout,
        axis: carddirection);
  }

  //twitter news
  Widget TwitterWidget() {
    return Opencontainer(
        openBuilder: TwitterScreen(),
        closedBuilder: TwitterList,
        duration: duration,
        swiperLayout: swiperlayout,
        axis: carddirection);
  }

//FaceBook news
  Widget FacebookWidget() {
    return Opencontainer(
        openBuilder: FaceBookScreen(),
        closedBuilder: FaceBookList,
        duration: duration,
        swiperLayout: swiperlayout,
        axis: carddirection);
  }

//Instagram News
  Widget InstagramWidget() {
    return Opencontainer(
        openBuilder: InstagramScreen(),
        closedBuilder: InstagramList,
        duration: duration,
        swiperLayout: swiperlayout,
        axis: carddirection);
  }
}
