import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intellensense/HomeScreen_Pages/Banners.dart/YoutubeExpScreen.dart';
import 'package:intellensense/HomeScreen_Pages/Banners.dart/twitterExpScreen.dart';
import 'package:intellensense/HomeScreen_Pages/NewsWIdget/FaceBookScreen.dart';
import 'package:intellensense/HomeScreen_Pages/NewsWIdget/NewsPaperScreen.dart';
import 'package:intellensense/HomeScreen_Pages/Widgets/Newstemplate.dart';
import 'package:intellensense/HomeScreen_Pages/Drawers/DrawerScreens/ScoreCard/ScoreCardsScreen.dart';
import 'package:intellensense/HomeScreen_Pages/NotificationsPages/Notification.dart';
import 'package:intellensense/Constants/constants.dart';
import 'package:intellensense/HomeScreen_Pages/Drawers/Drawer.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:intellensense/HomeScreen_Pages/Widgets/Socialmediatemplate.dart';
import 'package:intellensense/LoginPages/widgets/ChartSampleData.dart';
import 'package:intellensense/Services/ApiServices.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'Banners.dart/FaceBookExpScreen.dart';
import 'Banners.dart/NewsChannelExpScreen.dart';
import 'Drawers/DrawerScreens/CandidatureAnalysis/AllCandidateList.dart';
import 'Drawers/DrawerScreens/CandidatureAnalysis/CandidatureAnalysis.dart';
import 'Drawers/DrawerScreens/Constituency Analysis/ConstituencyAnalysis.dart';
import 'Drawers/DrawerScreens/ElectoralAnalysis/ElectoralAnalysis.dart';
import 'NewsWIdget/GoogleTrendsScreen.dart';
import 'NewsWIdget/InstagramScreen.dart';
import 'NewsWIdget/LiveUpdatesScreen.dart';
import 'NewsWIdget/NewsChannelScreen.dart';
import 'NewsWIdget/TwitterScreen.dart';
import 'NewsWIdget/YouTubeScreen.dart';
import 'NotificationsPages/BottomNavigation_Notification/Youtube.dart';
import 'StateOverViewScreens/StateOverview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController? _scrollController;
  bool lastStatus = true;
  double height = 200;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  String NewsHeading = '';
  var _currIndex = 0;
  bool isnewshidden = false;
  bool shownews = true;
  bool showSocialnews = true;
  bool newson = false;
  bool newson1 = false;
  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }
  late Future<dynamic> LineChartfuturecall = YoutubeBannerGraphApi();
  TooltipBehavior? _tooltipBehavior;
  TooltipBehavior? _tooltipBehavior1;
  List<ChartSampleData>? chartData;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
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
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

 /* late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-8354581033947644/1220452753',
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print(error);
        },
      ), // BannerAdListener
      request: AdRequest(),
    ); // BannerAd
    _bannerAd.load();
  }*/

  bool tempbool = false;
  List<Widget> DailyNewsPages = [
    NewsPaperScreen(),
    NewsChannelScreen(),
    LiveUpdatesScreen(),
    GoogleTrendsScreen(),
    YouTubeScreen(),
    TwitterScreen(),
    FaceBookScreen(),
    InstagramScreen()
  ];
  SwiperLayout swiperlayout = SwiperLayout.DEFAULT;
  PageController PageCount = PageController();

  bool touchtoflip = false;
  bool carddirection = false;
  List youtubelink = [];
  int duration = Duration.microsecondsPerMillisecond;
  late Future<dynamic> finaldata = NEWSpaperAPI();
  late Future<dynamic> stockdata1 = TeslaStocksDataAPI();
  late Future<dynamic> Newschanneldata = NewsChannelAPI();
  late Future<dynamic> liveNewsdata = LiveUpdatesAPI();
  late Future<dynamic> googletrendsdata = GoogleTrendsAPI();
  late Future<dynamic> youtubedata = YouTubeAPI();
  late Future<dynamic> twitterdata = TwitterAPI();
  late Future<dynamic> facebookdata = FacebookAPI();
  late Future<dynamic> instagramdata = InstagramAPI();
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

  bool selected = false;

  double _height = 450;
  double _width = 370;
  @override
  Widget build(BuildContext context) {
      List<Widget>? swipeimage = [
    YoutubeBanner(),
    NewsChannelBanner(),
    FaceBookBanner(),
    TwitterBanner(),
    // 'assets/Image/Intellisense-banners-01.jpg',
    // 'assets/Image/Intellisense-banners-02.jpg',
    // 'assets/Image/Intellisense-banners-03.jpg'
  ];
    final TextTheme textTheme = Theme.of(context).textTheme;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          // backgroundColor: Color(0xff5555555),
          /*bottomNavigationBar: _isAdLoaded?Container(
        height: _bannerAd.size.height.toDouble(),
        width: _bannerAd.size.width.toDouble(),
        child: AdWidget(ad: _bannerAd),
      ):Text('Loading'),*/
          key: _key,
          drawer: drawer(),
          // backgroundColor: HomeColor,
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Image.asset(
                    'assets/icons/IntelliSense-Logo-Finall_01022023_A.gif',
                    fit: BoxFit.contain,
                    height: 40,
                    width: 180,
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      _key.currentState!.openDrawer();
                    },
                  ),
                  elevation: 0,
                backgroundColor: Colors.white,
                pinned: true,
                expandedHeight: 310,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  // title: _isShrink == true
                  //     ? Image.asset(
                  //
                  //       'assets/icons/IntelliSense-Logo-Finall_01022023_A.gif',
                  //       fit: BoxFit.cover,
                  //       height: 50,
                  //   width: 180,
                  //     )
                  //     : null,
                  background: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Container(
                            height: 260,
                            width: MediaQuery.of(context).size.width,
                            child: Swiper(
                              duration: 20,
                              itemBuilder: (BuildContext context, int index) {
                                return swipeimage![index];
                              },
                              itemCount: 4,
                              autoplay: false,
                             /* pagination: SwiperPagination(
                                  builder: new DotSwiperPaginationBuilder(
                                      color: Colors.grey,
                                      activeColor: Color(0xff38547C))),*/
                              control: new SwiperControl(
                                size: 18,
                                padding: EdgeInsets.all(2),
                                color: Color(0xff38547C),
                              ),
                              // Swiper(controller: SwiperController(),
                              //   duration: 1500,
                              //   itemBuilder: (BuildContext context, int index) {
                              //     return swipeimage![index];
                              //   },
                              //   itemCount: 4,
                              //   autoplay: false,
                              //   pagination: SwiperPagination(
                              //       builder: new DotSwiperPaginationBuilder(
                              //           color: Colors.grey,
                              //           activeColor: Color(0xff38547C))),
                              //   control: new SwiperControl(
                              //     size: 18,
                              //     padding: EdgeInsets.all(2),
                              //     color: Color(0xff38547C),
                              //   ),
                              // ),
                            ),
                          ),
                        )],
                      ),
                    ),
                  ),
                  actions: [
                    /*Padding(
                        padding: EdgeInsets.only(bottom: 12.0, top: 10),
                        child: _isShrink == false
                            ? Container(
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    height: 400.0,
                                    scrollDirection: Axis.vertical,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                  ),
                                  items: [
                                    'YuvaGalamAndrapradesh',
                                    'YuvaGalamPadayatra',
                                    '#PsychoPovaliCycleRavali',
                                    '#LokeshPadayatra',
                                    '#YuvaGalamPadayatra'
                                  ].map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '$i',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.black),
                                                ),
                                                Icon(
                                                  Icons.data_usage,
                                                  size: 18,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ));
                                      },
                                    );
                                  }).toList(),
                                ),
                                width: 240,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.blue),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                //color: Colors.white,
                              )
                            : null,
                      ),*/

                    /*Padding(
                        padding:  EdgeInsets.only(bottom: 12.0, top: 10),
                        child: _isShrink==false? Container(
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 400.0,
                              scrollDirection: Axis.vertical,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                            ),
                            items: ['YuvaGalamAndrapradesh', 'YuvaGalamPadayatra', '#PsychoPovaliCycleRavali', '#LokeshPadayatra', '#YuvaGalamPadayatra'].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '$i',
                                            style: TextStyle(fontSize: 16.0, color: Colors.black),
                                          ),
                                          Icon(Icons.data_usage,size: 18,color: Colors.black,),
                                        ],
                                      ));
                                },
                              );
                            }).toList(),
                          ),
                          width: 240,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.blue),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          //color: Colors.white,
                        ):null,
                      ),*/
                    /*Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WeatherScreen()));
                            },
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    FutureBuilder<Weather>(
                                      future: dataState.getWeather(),
                                      builder: (context, snapshot) {
                                        return snapshot.hasData
                                            ? Container(
                                                height: 45,
                                                width: 150,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 6,
                                                                  left: 10),
                                                          child: Column(
                                                            children: <Widget>[
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Column(
                                                                    children: [
                                                                      Text(
                                                                        '${(snapshot.data!.main.temp - 273.15).toInt()}°',
                                                                        style: GoogleFonts.nunitoSans(
                                                                            fontSize:
                                                                                12.0,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color: Colors.black),
                                                                      ),
                                                                      Text(
                                                                        '${(snapshot.data!.name)}',
                                                                        style: GoogleFonts
                                                                            .nunitoSans(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              12.0,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2,
                                                                  ),
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: <
                                                                        Widget>[
                                                                      Image
                                                                          .network(
                                                                        'http://openweathermap.org/img/wn/${snapshot.data!.weather[0].icon}.png',
                                                                        height:
                                                                            50,
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        backgroundColor:
                                                            Colors.black),
                                              );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),*/
                    IconButton(
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
                    IconButton(
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
                    IconButton(
                        onPressed: () {
                          showMaterialModalBottomSheet(
                              backgroundColor: Color(0xffd2dfff),
                              elevation: 10,
                              bounce: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                      BorderRadius.circular(
                                                          15)),
                                              tileColor: Colors.blue.shade100,
                                              onTap: () {
                                                setState(() {
                                                  carddirection =
                                                      !carddirection;
                                                });
                                                Navigator.pop(context);
                                              },
                                              leading: Text(
                                                'Scroll Direction',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              trailing: carddirection == false
                                                  ? Text('Vertical')
                                                  : Text('Horizontal')),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ExpansionTile(
                                            collapsedShape:
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            title: Text(''),
                                            backgroundColor:
                                                Colors.blue.shade100,
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
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ExpansionTile(
                                            collapsedShape:
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            title: Text(''),
                                            backgroundColor:
                                                Colors.blue.shade100,
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
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                                      fontWeight:
                                                          FontWeight.w600),
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
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          /*ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  15)),
                                          tileColor: Colors
                                              .blue.shade100,
                                          leading:
                                          Text('Darkmode'),
                                          onTap: () {
                                            setState(() {
                                              // themeChange
                                              //         .darkTheme =
                                              //     !themeChange
                                              //         .darkTheme;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),*/
                                          /*ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  15)),
                                          tileColor: Colors
                                              .blue.shade100,
                                          leading: shownews ==
                                              false
                                              ? Text(
                                              'Show News Tab')
                                              : Text(
                                              'Hide News Tab'),
                                          onTap: () {
                                            setState(() {
                                              shownews =
                                              !shownews;
                                            });
                                            Navigator.pop(
                                                context);
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  15)),
                                          tileColor: Colors
                                              .blue.shade100,
                                          leading: showSocialnews ==
                                              false
                                              ? Text(
                                              'Show SocialNews Tab')
                                              : Text(
                                              'Hide SocialNews Tab'),
                                          onTap: () {
                                            setState(() {
                                              showSocialnews =
                                              !showSocialnews;
                                            });
                                            Navigator.pop(
                                                context);
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  15)),
                                          tileColor: Colors
                                              .blue.shade100,
                                          leading: Text(
                                              'Hide News Card'),
                                          onTap: () {
                                            setState(() {
                                              viewnews = false;
                                            });
                                            Navigator.pop(
                                                context);
                                          },
                                        ),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        icon: Icon(
                          Icons.settings,
                          color: Colors.black,
                        )),
                    /*PopupMenuButton(onSelected: (value) {
                        if (value == 'notifications') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Notifications()));
                        } else if (value == 'weather') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WeatherScreen()));
                        }
                      }, itemBuilder: (BuildContext bc) {
                        return [
                          PopupMenuItem(
                            value: 'Reader',
                            onTap: () {
                              setState(() {
                                viewnews = false;
                              });
                            },
                            child: Text("Hide News"),
                          ),
                          PopupMenuItem(
                            value: 'logout',
                            child: Text("Logout"),
                            onTap: () {
                              CoolAlert.show(
                                confirmBtnColor: Color(0xff00186a),
                                backgroundColor: Color(0xff001969),
                                context: context,
                                type: CoolAlertType.confirm,
                                onConfirmBtnTap: () => LogoutAPI(context),
                              );
                            },
                          ),
                          PopupMenuItem(
                            value: 'notifications',
                            child: Text("Notifications"),
                            onTap: () {},
                          ),
                          PopupMenuItem(
                            value: 'weather',
                            child: Text("Weather"),
                            onTap: () {},
                          ),
                        ];
                      }),*/
                  ],
                ),
              ];
            },
            body: CustomScrollView(slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    // color: Color(0xffd2dfff),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/NotificationIcons/News-Paper.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  'NEWS',
                                  style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 16,
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
                                      ? Icon(Icons.arrow_drop_down)
                                      : Icon(Icons.arrow_drop_up_outlined),
                                ),
                              ],
                            ),
                          ),
                          //main card
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: shownews == true
                                  ? SlideInUp(
                                      duration: Duration(seconds: 3),
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                FutureBuilder(
                                                    future: finaldata,
                                                    builder:
                                                        ((context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 70.0),
                                                          child: SizedBox(
                                                            height: 150,
                                                            width: 150,
                                                            child: Center(
                                                                child:
                                                                    SpinKitWave(
                                                              color:
                                                                  Colors.blue,
                                                              size: 18,
                                                            )),
                                                          ),
                                                        );
                                                      } else if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        if (snapshot.hasError) {
                                                          return const Text(
                                                              'Data Error');
                                                        } else if (snapshot
                                                            .hasData) {
                                                          List Newpaperlist = [
                                                            NewsTemplate2(
                                                                "${newsdata[0]['mediaName']}",
                                                                '${newsdata[0]['headLine']}',
                                                                'assets/icons/newspaperdxp.png',
                                                                '- ${newsdata[0]['candidateName']}'),
                                                            NewsTemplate3(
                                                                '${newsdata[1]['mediaName']}',
                                                                '${newsdata[1]['headLine']}',
                                                                'assets/icons/newspaperdxp.png',
                                                                '- ${newsdata[1]['candidateName']}'),
                                                            NewsTemplate1(
                                                                '${newsdata[2]['mediaName']}',
                                                                '${newsdata[2]['headLine']}',
                                                                'assets/icons/newspaperdxp.png',
                                                                '- ${newsdata[2]['candidateName']}'),
                                                            NewsTemplate4(
                                                                '${newsdata[3]['mediaName']}',
                                                                '${newsdata[3]['headLine']}',
                                                                'assets/icons/newspaperdxp.png',
                                                                '- ${newsdata[3]['candidateName']}'),
                                                          ];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              showMaterialModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                  animationCurve:
                                                                      Curves
                                                                          .easeInQuad,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              15),
                                                                          topRight: Radius.circular(
                                                                              15))),
                                                                  builder:
                                                                      (context) {
                                                                    return Container(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.6,
                                                                        child:
                                                                            NewsPaperScreen());
                                                                  });
                                                              // setState(() {
                                                              //   viewnews = true;
                                                              //   newson = true;
                                                              //   NewsHeading =
                                                              //       'NewsPaper';
                                                              //   _currIndex = 0;
                                                              // });
                                                              // PageCount
                                                              //     .jumpToPage(
                                                              //         0);
                                                            },
                                                            child: SizedBox(
                                                              height: 130,
                                                              width: 150,
                                                              child: Swiper(
                                                                  itemWidth:
                                                                      150,
                                                                  itemHeight:
                                                                      130,
                                                                  duration:
                                                                      duration,
                                                                  layout:
                                                                      swiperlayout,
                                                                  scrollDirection: carddirection ==
                                                                          false
                                                                      ? Axis
                                                                          .vertical
                                                                      : Axis
                                                                          .horizontal,
                                                                  autoplay:
                                                                      true,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int
                                                                              index) {
                                                                    return Newpaperlist[
                                                                        index];
                                                                  },
                                                                  itemCount: 4,
                                                                  pagination:
                                                                      SwiperPagination(
                                                                          builder:
                                                                              DotSwiperPaginationBuilder(
                                                                    size: 7,
                                                                    color: Colors
                                                                        .grey,
                                                                    activeColor:
                                                                        Colors
                                                                            .blue
                                                                            .shade200,
                                                                  ))),
                                                            ),
                                                          );
                                                        } else {
                                                          return const Text(
                                                              'Server Error');
                                                        }
                                                      } else {
                                                        return Text(
                                                            'State: ${snapshot.connectionState}');
                                                      }
                                                    })),
                                                //Newschannel
                                                FutureBuilder(
                                                    future: Newschanneldata,
                                                    builder:
                                                        ((context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 70.0),
                                                          child: SizedBox(
                                                            height: 150,
                                                            width: 150,
                                                            child: Center(
                                                                child:
                                                                    SpinKitWave(
                                                              color:
                                                                  Colors.blue,
                                                              size: 18,
                                                            )),
                                                          ),
                                                        );
                                                      } else if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        if (snapshot.hasError) {
                                                          return const Text(
                                                              'Data Error');
                                                        } else if (snapshot
                                                            .hasData) {
                                                          List NewschannelList =
                                                              [
                                                            NewsTemplate2(
                                                                "${newchannelldata[0]['mediaChannelName']}",
                                                                '${newchannelldata[0]['videoTitle']}',
                                                                'assets/icons/newsdxps.png',
                                                                '- ${newchannelldata[0]['candidateName']}'),
                                                            NewsTemplate3(
                                                                '${newchannelldata[1]['mediaChannelName']}',
                                                                '${newchannelldata[1]['videoTitle']}',
                                                                'assets/icons/newsdxps.png',

                                                                '${newchannelldata[1]['candidateName']}'
                                                              .length >
                                                          16
                                                      ? '- ${newchannelldata[1]['candidateName'].substring(0, 10)}...'
                                                      : '- ${newchannelldata[1]['candidateName']}'
                                                                ),
                                                            NewsTemplate1(
                                                                '${newchannelldata[2]['mediaChannelName']}',
                                                                '${newchannelldata[2]['videoTitle']}',
                                                                'assets/icons/newsdxps.png',
                                                                '- ${newsdata[2]['candidateName']}'),
                                                            NewsTemplate4(
                                                                '${newchannelldata[3]['mediaChannelName']}',
                                                                '${newchannelldata[3]['videoTitle']}',
                                                                'assets/icons/newsdxps.png',
                                                                '- ${newchannelldata[3]['candidateName']}'),
                                                          ];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              showMaterialModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                  animationCurve:
                                                                      Curves
                                                                          .easeInQuad,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              15),
                                                                          topRight: Radius.circular(
                                                                              15))),
                                                                  builder:
                                                                      (context) {
                                                                    return Container(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.6,
                                                                      child:
                                                                          NewsChannelScreen(),
                                                                    );
                                                                  });
                                                              // setState(() {
                                                              //   viewnews = true;
                                                              //   newson = true;
                                                              //   NewsHeading =
                                                              //       'NewsChannel';
                                                              //   _currIndex = 0;
                                                              // });
                                                              // PageCount
                                                              //     .jumpToPage(
                                                              //         1);
                                                            },
                                                            child: SizedBox(
                                                              height: 130,
                                                              width: 150,
                                                              child: Swiper(
                                                                  itemWidth:
                                                                      150,
                                                                  itemHeight:
                                                                      130,
                                                                  duration:
                                                                      duration,
                                                                  layout:
                                                                      swiperlayout,
                                                                  scrollDirection: carddirection ==
                                                                          false
                                                                      ? Axis
                                                                          .vertical
                                                                      : Axis
                                                                          .horizontal,
                                                                  autoplay:
                                                                      true,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int
                                                                              index) {
                                                                    return NewschannelList[
                                                                        index];
                                                                  },
                                                                  itemCount: 4,
                                                                  pagination:
                                                                      SwiperPagination(
                                                                          builder:
                                                                              DotSwiperPaginationBuilder(
                                                                    size: 7,
                                                                    color: Colors
                                                                        .grey,
                                                                    activeColor:
                                                                        Colors
                                                                            .blue
                                                                            .shade200,
                                                                  ))),
                                                            ),
                                                          );
                                                        } else {
                                                          return const Text(
                                                              'Server Error');
                                                        }
                                                      } else {
                                                        return Text(
                                                            'State: ${snapshot.connectionState}');
                                                      }
                                                    })),
                                                //Live News
                                                FutureBuilder(
                                                    future: liveNewsdata,
                                                    builder:
                                                        ((context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 70.0),
                                                          child: SizedBox(
                                                            height: 150,
                                                            width: 150,
                                                            child: Center(
                                                                child:
                                                                    SpinKitWave(
                                                              color:
                                                                  Colors.blue,
                                                              size: 18,
                                                            )),
                                                          ),
                                                        );
                                                      } else if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        if (snapshot.hasError) {
                                                          return const Text(
                                                              'Data Error');
                                                        } else if (snapshot
                                                            .hasData) {
                                                          List LiveNewsList = [
                                                            NewsTemplate2(
                                                                "${Livenewsdata[0]['mediaName']}",
                                                                '${Livenewsdata[0]['headLine']}',
                                                                'assets/icons/live.gif',
                                                                '${Livenewsdata[0]['publishedDate']}'),
                                                            NewsTemplate3(
                                                                '${Livenewsdata[1]['mediaName']}',
                                                                '${Livenewsdata[1]['headLine']}',
                                                                'assets/icons/live.gif',
                                                                '${Livenewsdata[1]['publishedDate']}'),
                                                            NewsTemplate1(
                                                                '${Livenewsdata[2]['mediaName']}',
                                                                '${Livenewsdata[2]['headLine']}',
                                                                'assets/icons/live.gif',
                                                                '${Livenewsdata[2]['publishedDate']}'),
                                                            NewsTemplate4(
                                                                '${Livenewsdata[3]['mediaName']}',
                                                                '${Livenewsdata[3]['headLine']}',
                                                                'assets/icons/live.gif',
                                                                '${Livenewsdata[3]['publishedDate']}'),
                                                          ];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              showMaterialModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                  animationCurve:
                                                                      Curves
                                                                          .easeInQuad,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              15),
                                                                          topRight: Radius.circular(
                                                                              15))),
                                                                  builder:
                                                                      (context) {
                                                                    return Container(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.6,
                                                                      child:
                                                                          LiveUpdatesScreen(),
                                                                    );
                                                                  });
                                                              
                                                            },
                                                            child: SizedBox(
                                                              height: 130,
                                                              width: 150,
                                                              child: Swiper(
                                                                  itemWidth:
                                                                      150,
                                                                  itemHeight:
                                                                      130,
                                                                  duration:
                                                                      duration,
                                                                  layout:
                                                                      swiperlayout,
                                                                  scrollDirection: carddirection ==
                                                                          false
                                                                      ? Axis
                                                                          .vertical
                                                                      : Axis
                                                                          .horizontal,
                                                                  autoplay:
                                                                      true,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int
                                                                              index) {
                                                                    return LiveNewsList[
                                                                        index];
                                                                  },
                                                                  itemCount: 4,
                                                                  pagination:
                                                                      SwiperPagination(
                                                                          builder:
                                                                              DotSwiperPaginationBuilder(
                                                                    size: 7,
                                                                    color: Colors
                                                                        .grey,
                                                                    activeColor:
                                                                        Colors
                                                                            .blue
                                                                            .shade200,
                                                                  ))),
                                                            ),
                                                          );
                                                        } else {
                                                          return const Text(
                                                              'Server Error');
                                                        }
                                                      } else {
                                                        return Text(
                                                            'State: ${snapshot.connectionState}');
                                                      }
                                                    })),
                                                //Google Trends
                                                FutureBuilder(
                                                    future: googletrendsdata,
                                                    builder:
                                                        ((context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 70.0),
                                                          child: SizedBox(
                                                            height: 150,
                                                            width: 150,
                                                            child: Center(
                                                                child:
                                                                    SpinKitWave(
                                                              color:
                                                                  Colors.blue,
                                                              size: 18,
                                                            )),
                                                          ),
                                                        );
                                                      } else if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        if (snapshot.hasError) {
                                                          return const Text(
                                                              'Data Error');
                                                        } else if (snapshot
                                                            .hasData) {
                                                          List
                                                              GoogleTrendsList =
                                                              [
                                                            NewsTemplate2(
                                                                "${GoogleTrendsdata[0]['partyName']}",
                                                                '${GoogleTrendsdata[0]['id']['region']}',
                                                                'assets/icons/googleTrends.png',
                                                                '- ${GoogleTrendsdata[0]['id']['candidateName']}'),
                                                            NewsTemplate3(
                                                                '${GoogleTrendsdata[1]['partyName']}',
                                                                '${GoogleTrendsdata[1]['id']['region']}',
                                                                'assets/icons/googleTrends.png',
                                                                '- ${GoogleTrendsdata[1]['id']['candidateName']}'),
                                                            NewsTemplate1(
                                                                '${GoogleTrendsdata[2]['partyName']}',
                                                                '${GoogleTrendsdata[2]['id']['region']}',
                                                                'assets/icons/googleTrends.png',
                                                                '- ${GoogleTrendsdata[2]['id']['candidateName']}'),
                                                            NewsTemplate4(
                                                                '${GoogleTrendsdata[3]['partyName']}',
                                                                '${GoogleTrendsdata[3]['id']['region']}',
                                                                'assets/icons/googleTrends.png',
                                                                '- ${GoogleTrendsdata[3]['id']['candidateName']}'),
                                                          ];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              showMaterialModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                  animationCurve:
                                                                      Curves
                                                                          .easeInQuad,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              15),
                                                                          topRight: Radius.circular(
                                                                              15))),
                                                                  builder:
                                                                      (context) {
                                                                    return Container(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.6,
                                                                        child:
                                                                            GoogleTrendsScreen());
                                                                  });
                                                       
                                                            },
                                                            child: SizedBox(
                                                              height: 130,
                                                              width: 150,
                                                              child: Swiper(
                                                                  itemWidth:
                                                                      150,
                                                                  itemHeight:
                                                                      130,
                                                                  duration:
                                                                      duration,
                                                                  layout:
                                                                      swiperlayout,
                                                                  scrollDirection: carddirection ==
                                                                          false
                                                                      ? Axis
                                                                          .vertical
                                                                      : Axis
                                                                          .horizontal,
                                                                  autoplay:
                                                                      true,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int
                                                                              index) {
                                                                    return GoogleTrendsList[
                                                                        index];
                                                                  },
                                                                  itemCount: 4,
                                                                  pagination:
                                                                      SwiperPagination(
                                                                          builder:
                                                                              DotSwiperPaginationBuilder(
                                                                    size: 7,
                                                                    color: Colors
                                                                        .grey,
                                                                    activeColor:
                                                                        Colors
                                                                            .blue
                                                                            .shade200,
                                                                  ))),
                                                            ),
                                                          );
                                                        } else {
                                                          return const Text(
                                                              'Server Error');
                                                        }
                                                      } else {
                                                        return Text(
                                                            'State: ${snapshot.connectionState}');
                                                      }
                                                    })),

                                              ])),
                                    )
                                  : Container()),
                          Padding(
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
                                        style: TextStyle(
                                          fontFamily: 'Segoe UI',
                                          fontSize: 16,
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showSocialnews =
                                            !showSocialnews;
                                          });
                                        },
                                        icon: showSocialnews == true
                                            ? Icon(Icons.arrow_drop_down)
                                            : Icon(Icons.arrow_drop_up_outlined),
                                      ),
                                    ],

                                  )))],
            ),
          ),
      ),
        showSocialnews == true
            ? SlideInDown(
          duration: Duration(seconds: 3),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8),
            child: SingleChildScrollView(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FutureBuilder(
                      future: youtubedata,
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding:
                            const EdgeInsets.only(
                                top: 70.0),
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
                        } else if (snapshot
                            .connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text(
                                'Data Error');
                          } else if (snapshot.hasData) {
                            List YoutubeList = [
                              SocialMediaTemplate1(
                                  '${Youtubedata[0]['mediaChannelName']}',
                                  '${Youtubedata[0]['videoTitle']}',
                                  'Views - ${Youtubedata[0]['videoViews']}    Likes - ${Youtubedata[0]['videoLikes']}'),
                              SocialMediaTemplate1(
                                  '${Youtubedata[1]['mediaChannelName']}',
                                  '${Youtubedata[1]['videoTitle']}',
                                  'Views - ${Youtubedata[1]['videoViews']}    Likes - ${Youtubedata[1]['videoLikes']}'),
                              SocialMediaTemplate1(
                                  '${Youtubedata[2]['mediaChannelName']}',
                                  '${Youtubedata[2]['videoTitle']}',
                                  'Views - ${Youtubedata[2]['videoViews']}    Likes - ${Youtubedata[2]['videoLikes']}'),
                              SocialMediaTemplate1(
                                  '${Youtubedata[3]['mediaChannelName']}',
                                  '${Youtubedata[3]['videoTitle']}',
                                  'Views - ${Youtubedata[3]['videoViews']}    Likes - ${Youtubedata[3]['videoLikes']}'),
                            ];
                            return SizedBox(
                              height: 130,
                              width: 150,
                              child: GestureDetector(
                                onTap: () {
                                  showMaterialModalBottomSheet(context: context,
                                      duration: Duration(seconds: 1),animationCurve: Curves.easeInQuad,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
                                      builder:(context){
                                        return   Container(
                                          height: MediaQuery.of(context).size.height*0.6,
                                          child:YouTubeScreen(), );
                                      });
                                  // setState(() {
                                  //   viewnews = true;
                                  //   newson = true;
                                  //   NewsHeading =
                                  //       'Youtube';
                                  //   _currIndex = 0;
                                  // });
                                  // PageCount.jumpToPage(
                                  //     4);
                                },
                                child: Swiper(
                                    itemWidth: 150,
                                    itemHeight: 130,
                                    duration: duration,
                                    layout:
                                    swiperlayout,
                                    scrollDirection:
                                    carddirection ==
                                        false
                                        ? Axis
                                        .vertical
                                        : Axis
                                        .horizontal,
                                    autoplay: true,
                                    itemBuilder:
                                        (BuildContext
                                    context,
                                        int index) {
                                      return YoutubeList[
                                      index];
                                    },
                                    itemCount: 4,
                                    pagination:
                                    SwiperPagination(
                                        builder:
                                        DotSwiperPaginationBuilder(
                                          size: 7,
                                          color:
                                          Colors.grey,
                                          activeColor:
                                          Colors.blue
                                              .shade200,
                                        ))),
                              ),
                            );
                          } else {
                            return const Text(
                                'Server Error');
                          }
                        } else {
                          return Text(
                              'State: ${snapshot.connectionState}');
                        }
                      })),

                  //Twitter news
                  FutureBuilder(
                      future: twitterdata,
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding:
                            const EdgeInsets.only(
                                top: 70.0),
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
                        } else if (snapshot
                            .connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text(
                                'Data Error');
                          } else if (snapshot.hasData) {
                            List TwitterList = [
                              SocialMediaTemplate2(
                                  '${TwitterData[0]['candidateName']}',
                                  '${TwitterData[0]['tweetContent']}',
                                  '- ${TwitterData[0]['candidatePartyName']}'),
                              SocialMediaTemplate2(
                                  '${TwitterData[1]['candidateName']}',
                                  '${TwitterData[1]['tweetContent']}','- ${TwitterData[1]['candidatePartyName']}'),
                              SocialMediaTemplate2(
                                  '${TwitterData[2]['candidateName']}',
                                  '${TwitterData[2]['tweetContent']}','- ${TwitterData[2]['candidatePartyName']}'),
                              SocialMediaTemplate2(
                                  '${TwitterData[3]['candidateName']}',
                                  '${TwitterData[3]['tweetContent']}','- ${TwitterData[3]['candidatePartyName']}'),
                            ];
                            return SizedBox(
                              height: 130,
                              width: 150,
                              child: GestureDetector(
                                onTap: () {
                                  showMaterialModalBottomSheet(context: context,
                                      duration: Duration(seconds: 1),animationCurve: Curves.easeInQuad,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
                                      builder:(context){
                                        return   Container(
                                          height: MediaQuery.of(context).size.height*0.6,
                                          child:TwitterScreen(), );
                                      });
                                  // setState(() {
                                  //   viewnews = true;
                                  //   newson = true;
                                  //   NewsHeading =
                                  //       'Twitter';
                                  //   _currIndex = 0;
                                  // });
                                  // PageCount.jumpToPage(
                                  //     5);
                                },
                                child: Swiper(
                                    itemWidth: 150,
                                    itemHeight: 130,
                                    duration: duration,
                                    layout:
                                    swiperlayout,
                                    scrollDirection:
                                    carddirection ==
                                        false
                                        ? Axis
                                        .vertical
                                        : Axis
                                        .horizontal,
                                    autoplay: true,
                                    itemBuilder:
                                        (BuildContext
                                    context,
                                        int index) {
                                      return TwitterList[
                                      index];
                                    },
                                    itemCount: 4,
                                    pagination:
                                    SwiperPagination(
                                        builder:
                                        DotSwiperPaginationBuilder(
                                          size: 7,
                                          color:
                                          Colors.grey,
                                          activeColor:
                                          Colors.blue
                                              .shade200,
                                        ))),
                              ),
                            );
                          } else {
                            return const Text(
                                'Server Error');
                          }
                        } else {
                          return Text(
                              'State: ${snapshot.connectionState}');
                        }
                      })),
                  //FaceBook News
                  FutureBuilder(
                      future: facebookdata,
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding:
                            const EdgeInsets.only(
                                top: 70.0),
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
                        } else if (snapshot
                            .connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text(
                                'Data Error');
                          } else if (snapshot.hasData) {
                            List FaceBookList = [
                              SocialMediaTemplate3(
                                  '${Facebookdata[0]['keyWords']}',
                                  '${Facebookdata[0]['titleContent']}',
                                  '${Facebookdata[0]['candidateName']}'
                                      .length >
                                      16
                                      ? '- ${Facebookdata[0]['candidateName'].substring(0, 10)}...'
                                      : '- ${Facebookdata[0]['candidateName']}'

                                // '${Facebookdata[0]['candidateName']}'
                              ),
                              SocialMediaTemplate3(
                                  '${Facebookdata[1]['keyWords']}',
                                  '${Facebookdata[1]['titleContent']}',
                                  '${Facebookdata[1]['candidateName']}'
                                      .length >
                                      16
                                      ? '- ${Facebookdata[1]['candidateName'].substring(0, 10)}...'
                                      : '- ${Facebookdata[1]['candidateName']}'
                                // ,'${Facebookdata[1]['candidateName']}'
                              ),
                              SocialMediaTemplate3(
                                  '${Facebookdata[2]['keyWords']}',
                                  '${Facebookdata[2]['titleContent']}',
                                  '${Facebookdata[2]['candidateName']}'
                                      .length >
                                      16
                                      ? '- ${Facebookdata[2]['candidateName'].substring(0, 10)}...'
                                      : '- ${Facebookdata[2]['candidateName']}'

                                // '${Facebookdata[2]['candidateName']}'
                              ),
                              SocialMediaTemplate3(
                                  '${Facebookdata[3]['keyWords']}',
                                  '${Facebookdata[3]['titleContent']}',
                                  '${Facebookdata[3]['candidateName']}'
                                      .length >
                                      16
                                      ? '- ${Facebookdata[3]['candidateName'].substring(0, 10)}...'
                                      : '- ${Facebookdata[3]['candidateName']}'
                                // '${Facebookdata[3]['candidateName']}'
                              ),
                            ];
                            return SizedBox(
                              height: 130,
                              width: 150,
                              child: GestureDetector(
                                onTap: () {
                                  showMaterialModalBottomSheet(context: context,
                                      duration: Duration(seconds: 1),animationCurve: Curves.easeInQuad,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
                                      builder:(context){
                                        return   Container(
                                          height: MediaQuery.of(context).size.height*0.6,
                                          child:   FaceBookScreen(), );
                                      });
                                  // setState(() {
                                  //   viewnews = true;
                                  //   newson = true;
                                  //   NewsHeading =
                                  //       'FaceBook';
                                  //   _currIndex = 0;
                                  // });
                                  // PageCount.jumpToPage(
                                  //     6);
                                },
                                child: Swiper(
                                    itemWidth: 150,
                                    itemHeight: 130,
                                    duration: duration,
                                    layout:
                                    swiperlayout,
                                    scrollDirection:
                                    carddirection ==
                                        false
                                        ? Axis
                                        .vertical
                                        : Axis
                                        .horizontal,
                                    autoplay: true,
                                    itemBuilder:
                                        (BuildContext
                                    context,
                                        int index) {
                                      return FaceBookList[
                                      index];
                                    },
                                    itemCount: 4,
                                    pagination:
                                    SwiperPagination(
                                        builder:
                                        DotSwiperPaginationBuilder(
                                          size: 7,
                                          color:
                                          Colors.grey,
                                          activeColor:
                                          Colors.blue
                                              .shade200,
                                        ))),
                              ),
                            );
                          } else {
                            return const Text(
                                'Server Error');
                          }
                        } else {
                          return Text(
                              'State: ${snapshot.connectionState}');
                        }
                      })),
                  //Instagram news
                  FutureBuilder(
                      future: instagramdata,
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding:
                            const EdgeInsets.only(
                                top: 70.0),
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
                        } else if (snapshot
                            .connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text(
                                'Data Error');
                          } else if (snapshot.hasData) {
                            List InstagramList = [
                              SocialMediaTemplate4(
                                  '${Instagramdata[0]['candidateName']}',
                                  '${Instagramdata[0]['titleContent']}',
                                  'Likes- ${Instagramdata[0]['likesCount']}   Comments- ${Instagramdata[0]['commentsCount']}'),
                              SocialMediaTemplate4(
                                  '${Instagramdata[1]['candidateName']}',
                                  '${Instagramdata[1]['titleContent']}',
                                  'Likes- ${Instagramdata[1]['likesCount']}   Comments- ${Instagramdata[1]['commentsCount']}'),
                              SocialMediaTemplate4(
                                  '${Instagramdata[2]['candidateName']}',
                                  '${Instagramdata[2]['titleContent']}',
                                  'Likes- ${Instagramdata[2]['likesCount']}   Comments- ${Instagramdata[2]['commentsCount']}'),
                              SocialMediaTemplate4(
                                  '${Instagramdata[3]['candidateName']}',
                                  '${Instagramdata[3]['titleContent']}',
                                  'Likes- ${Instagramdata[3]['likesCount']}   Comments- ${Instagramdata[3]['commentsCount']}'),
                            ];
                            return SizedBox(
                              height: 130,
                              width: 150,
                              child: GestureDetector(
                                onTap: () {
                                  showMaterialModalBottomSheet(context: context,
                                      duration: Duration(seconds: 1),animationCurve: Curves.easeInQuad,shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
                                      builder:(context){
                                        return   Container(
                                            height: MediaQuery.of(context).size.height*0.6,
                                            child: InstagramScreen());
                                      });
                                  // setState(() {
                                  //   viewnews = true;
                                  //   newson = true;
                                  //   NewsHeading =
                                  //       'Instagram';
                                  //   _currIndex = 0;
                                  // });
                                  // PageCount.jumpToPage(
                                  //     7);
                                },
                                child: Swiper(
                                    itemWidth: 150,
                                    itemHeight: 130,
                                    duration: duration,
                                    layout:
                                    swiperlayout,
                                    scrollDirection:
                                    carddirection ==
                                        false
                                        ? Axis
                                        .vertical
                                        : Axis
                                        .horizontal,
                                    autoplay: true,
                                    itemBuilder:
                                        (BuildContext
                                    context,
                                        int index) {
                                      return InstagramList[
                                      index];
                                    },
                                    itemCount: 4,
                                    pagination:
                                    SwiperPagination(
                                        builder:
                                        DotSwiperPaginationBuilder(
                                          size: 7,
                                          color:
                                          Colors.grey,
                                          activeColor:
                                          Colors.blue
                                              .shade200,
                                        ))),
                              ),
                            );
                          } else {
                            return const Text(
                                'Server Error');
                          }
                        } else {
                          return Text(
                              'State: ${snapshot.connectionState}');
                        }
                      })),
                ],
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              )
                            ]),
                            Column(children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ConstituencyAnalysis()));
                                },
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
                ]),
              ),
                  ]),
          )),
    );
  
  }

 

  bool viewnews = true;


  YoutubeBanner(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            YoutubeExpBanner(
            )
        ));
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                   
                  ),
                  child:   FutureBuilder<dynamic>(
                            future: LineChartfuturecall,
                            builder: (
                                BuildContext context,
                                AsyncSnapshot<dynamic> snapshot,
                                ) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SpinKitWave(
                                  color: Colors.blue,
                                  size: 18,
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return const Text('Error');
                                } else if (snapshot.hasData) {
                                  return    Padding(
                                    padding: const EdgeInsets.only(top:8.0),
                                    child: Stack(
                                                    children: [
                                                     
                                                      
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Container(decoration: BoxDecoration(border: Border.all(color: Colors.redAccent,),borderRadius: BorderRadius.circular(15)),
                                                                height: 120,
                                                                width: 120,
                                                                child: SfCircularChart(
                                      tooltipBehavior: _tooltipBehavior1,
                                      palette: [
                                        Color.fromRGBO(254, 1, 117,0),
                                        Color.fromRGBO(19, 136, 8,0),
                                        Color.fromRGBO(249, 125, 9,0),
                                      ],
                                      series: <PieSeries<ChartSampleData, String>>[
                                        PieSeries<ChartSampleData, String>(
                                            explode: true,
                                            explodeIndex: 0,
                                            explodeOffset: '10%',
                                            dataSource: <ChartSampleData>[
                                              ...PiegraphChartData
                                            
                                            ],
                                            xValueMapper: (ChartSampleData data, _) =>
                                            data.x as String,
                                            yValueMapper: (ChartSampleData data, _) =>
                                            data.y,
                                            dataLabelMapper:
                                                (ChartSampleData data, _) => data.text,
                                            startAngle: 90,
                                            endAngle: 90,
                                            dataLabelSettings: const DataLabelSettings(
                                                isVisible: true)),
                                      ]),
                                                              ),
                                                              Text(
                                                                'Comments',
                                                                style: TextStyle(fontSize: 10),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                      padding: const EdgeInsets.only(top: 35.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(BarGraphdata['lead'][0]),
                                              Image.asset('assets/new Updated images/image_2023_07_12T10_18_35_331Z.png',height: 30,)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset('assets/new Updated images/image_2023_07_12T10_18_25_781Z.png',height: 30,),
                                                  Text('BJP'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                                        
                                                          Column(
                                                            children: [
                                                             Container(decoration: BoxDecoration(border: Border.all(color: Colors.redAccent),borderRadius: BorderRadius.circular(15)),
                                            height: 120,
                                            width: 120,
                                            child: SfFunnelChart(palette: [
                                              Color.fromRGBO(254, 1, 117,0),
                                              Color.fromRGBO(19, 136, 8,0),
                                              Color.fromRGBO(249, 125, 9,0),
                                            ],
                                                //title: ChartTitle(text: isCardView ? '' : 'Website conversion rate'),
                                                tooltipBehavior:
                                                TooltipBehavior(enable: true),
                                                series: FunnelSeries<ChartSampleData,
                                                    String>(
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
                                                    const DataLabelSettings(textStyle: TextStyle(fontSize: 8 ),
                                                        isVisible: true)))),
                                                              Text(
                                                                'Views',
                                                                style: TextStyle(fontSize: 10),
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
                                      padding: const EdgeInsets.only(left: 1.0,top: 60),
                                      child: Image.asset(
                                        'assets/icons/Social-Media-Icons-IS-10.png',
                                        height: 18,
                                        width: 18,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 140.0,left: 5),
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        child: RichText(
                                          text: new TextSpan(
                                            // Note: Styles for TextSpans must be explicitly defined.
                                            // Child text spans will inherit styles from parent
                                            style: new TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: BarGraphdata['lead'][0],
                                                  style: new TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.green,
                                                      fontSize: 20,
                                                      fontFamily: 'Segoe UI')),
                                              TextSpan(
                                                  text:
                                                  ' is overpowering ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily: 'Segoe UI')),
                                              TextSpan(
                                                  text: "BJP",
                                                  style: new TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.red,
                                                      fontSize: 20,
                                                      fontFamily: 'Segoe UI')),
                                              TextSpan(
                                                  text:
                                                  ' in all aspects',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily: 'Segoe UI')),
                                  
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 100.0),
                                          child: Container(
                                                    decoration: BoxDecoration(border: Border.all(color: Colors.redAccent),borderRadius: BorderRadius.circular(15)),
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
                                                            color: Colors.black, fontSize: 8),
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
                                                              color: Colors.black, fontSize: 8),
                                                          labelPosition:
                                                          ChartDataLabelPosition.outside,
                                                          isVisible: false,
                                                          minimum: 0,
                                                          maximum: 2000),
                                                      series: <ColumnSeries<ChartSampleData,
                                                          String>>[
                                                        ColumnSeries<ChartSampleData, String>(
                                                          width: 0.9,
                                                          dataLabelSettings:
                                                          const DataLabelSettings(
                                                              isVisible: true,
                                                              labelAlignment:
                                                              ChartDataLabelAlignment.top),
                                                          dataSource: <ChartSampleData>[
                                                            ...BargraphChartdata
                                                          ],
                                                          borderRadius: BorderRadius.circular(10),
                                                          xValueMapper:
                                                              (ChartSampleData sales, _) =>
                                                          sales.x as String,
                                                          yValueMapper:
                                                              (ChartSampleData sales, _) => sales.y,
                                                        ),
                                                      ],
                                                      tooltipBehavior: _tooltipBehavior,
                                                    ),
                                                  ),
                                        ),
                                        Text(
                                          'Likes',
                                          style: TextStyle(fontSize: 10),
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
                          ),
                  
                
                ),
              ),
            )
          ]),
    );
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
      "party_list": 'INC',
      "social_handle": "YOUTUBE"
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_YT/'),
        headers: headers,
        body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('inside loop');
      try {
        print('inside try');
        BarGraphdata = jsonDecode(utf8.decode(response.bodyBytes));
       
          BarGraphdata['party_data'].forEach((key, value) {
            print(key);

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

          // for(int i=0;i<BarGraphdata['party_data'])
          // BargraphChartdata.add(ChartSampleData(x: 'TDP', y: 8683),);
        
        print('data here');
        print(BarGraphdata);
      } catch (e) {
        print(BarGraphdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return BarGraphdata;
  }


  //Twitter Banner 
    late Future<dynamic> TwitterLineChartfuturecall = TwitterBannerGraphApi();
  TooltipBehavior? _TwittertooltipBehavior;
  TooltipBehavior? _TwittertooltipBehavior1;
  TwitterBanner(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            TwitterExpBanner(
            )
        ));
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),

                  ),
                  child:FutureBuilder<dynamic>(
                            future: TwitterLineChartfuturecall,
                            builder: (
                                BuildContext context,
                                AsyncSnapshot<dynamic> snapshot,
                                ) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SpinKitWave(
                                  color: Colors.blue,
                                  size: 18,
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return const Text('Error');
                                } else if (snapshot.hasData) {
                                  return     Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Stack(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .blue.shade600),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15)),
                                  height: 120,
                                  width: 120,
                                  child: SfCircularChart(
                                      tooltipBehavior: _TwittertooltipBehavior1,
                                      palette: [
                                        Color.fromRGBO(19, 136, 8, 0),
                                        Color.fromRGBO(254, 1, 117, 0),
                                        Color.fromRGBO(249, 125, 9, 0),
                                      ],
                                      series: <PieSeries<ChartSampleData, String>>[
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
                                                (ChartSampleData data, _) => data.y,
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
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                             Padding(
                                      padding: const EdgeInsets.only(top: 35.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(TwiterBarGraphdata['lead'][0]),
                                              Image.asset('assets/new Updated images/image_2023_07_12T10_18_35_331Z.png',height: 30,)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset('assets/new Updated images/image_2023_07_12T10_18_25_781Z.png',height: 30,),
                                                  Text('TRS'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                            Column(
                              children: [
                                Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Container(decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .blue.shade600),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15)),
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
                                                        ...TwitterFunnelgraphChartData,
                                                      ],
                                                      xValueMapper:
                                                          (ChartSampleData data,
                                                                  _) =>
                                                              data.x as String,
                                                      yValueMapper:
                                                          (ChartSampleData data,
                                                                  _) =>
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
                                                              textStyle: TextStyle(
                                                                  fontSize: 8),
                                                              isVisible: true)))),
                                        ),
                                Text(
                                  'Re-Tweet',
                                  style: TextStyle(fontSize: 10),
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
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      'With Huge Difference In counts for Tweets and Re-Tweets reports says that ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Segoe UI')),
                                              TextSpan(
                                                  text: TwiterBarGraphdata['lead'][0],
                                                  style: new TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.green,
                                                      fontSize: 20,
                                                      fontFamily: 'Segoe UI')),
                                              TextSpan(
                                                  text:
                                                      ' is relatively Dominant in Twitter Data.',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Segoe UI')),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 100.0),
                                          child: Container(decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .blue.shade600),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15)),
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
                                                        axisLine: const AxisLine(
                                                            width: 0),
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
                                                          labelStyle:
                                                              const TextStyle(
                                                                  color:
                                                                      Colors.black,
                                                                  fontSize: 5),
                                                          labelPosition:
                                                              ChartDataLabelPosition
                                                                  .outside,
                                                          isVisible: false,
                                                          minimum: 0,
                                                          maximum: 3000),
                                                      series: <ColumnSeries<
                                                          ChartSampleData, String>>[
                                                        ColumnSeries<
                                                            ChartSampleData,
                                                            String>(
                                                          width: 0.9,
                                                          dataLabelSettings:
                                                              const DataLabelSettings(textStyle: TextStyle(fontSize: 8),
                                                                  isVisible: true,
                                                                  labelAlignment:
                                                                      ChartDataLabelAlignment
                                                                          .top),
                                                          dataSource: <ChartSampleData>[
                                                            ...TwitterBargraphChartdata
                                                          ],
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10),
                                                          xValueMapper:
                                                              (ChartSampleData
                                                                          sales,
                                                                      _) =>
                                                                  sales.x as String,
                                                          yValueMapper:
                                                              (ChartSampleData
                                                                          sales,
                                                                      _) =>
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
                                          style: TextStyle(fontSize: 10),
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
                          ),



                ),
              ),
            )
          ]),
    );
  }
  //Bar Graph data
  var TwiterBarGraphdata;

  Map TwitterSelectionquery1 = new Map<String, dynamic>();
  List<ChartSampleData> TwitterBargraphChartdata = [];
  List<ChartSampleData> TwitterPiegraphChartData = [];
  List<ChartSampleData> TwitterFunnelgraphChartData = [];
  Future<dynamic> TwitterBannerGraphApi() async {
   
      TwitterSelectionquery1['type'] = 'party_data';
      TwitterSelectionquery1['STATE'] = 'TELANGANA';
      TwitterSelectionquery1['party_list'] = 'INC,TRS,BJP';
      //Selectionquery['channel'] = 'YOUTUBE';
  
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media/'),
        body: TwitterSelectionquery1);

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('inside loop');
      try {
        print('inside try');
        TwiterBarGraphdata = jsonDecode(utf8.decode(response.bodyBytes));
       
          TwiterBarGraphdata['party_data'].forEach((key, value) {
            print(key);

            TwitterBargraphChartdata.add(
              ChartSampleData(
                  x: '$key', y: TwiterBarGraphdata['party_data'][key][0]['LIKES']),
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

          // for(int i=0;i<TwiterBarGraphdata['party_data'])
          // TwitterBargraphChartdata.add(ChartSampleData(x: 'TDP', y: 8683),);
       
        print('data here');
        print(TwiterBarGraphdata);
      } catch (e) {
        print(TwiterBarGraphdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return TwiterBarGraphdata;
  }


//FaceBookBanners
  late Future<dynamic> FacebookLineChartfuturecall = FaceBookBannerGraphApi();
  TooltipBehavior? _FacebooktooltipBehavior;
  TooltipBehavior? _FacebooktooltipBehavior1;
  FaceBookBanner(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            FacebookExpBanner(
            )
        ));
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),

                  ),
                  child:FutureBuilder<dynamic>(
                            future: FacebookLineChartfuturecall,
                            builder: (
                                BuildContext context,
                                AsyncSnapshot<dynamic> snapshot,
                                ) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SpinKitWave(
                                  color: Colors.blue,
                                  size: 18,
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return const Text('Error');
                                } else if (snapshot.hasData) {
                                  return    Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Stack(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 120,
                                  width: 120,
                                  child: SfCircularChart(
                                      tooltipBehavior: _FacebooktooltipBehavior1,
                                      palette: [
                                        Colors.yellow,
                                        Colors.yellowAccent,
                                        Color.fromRGBO(249, 125, 9, 0),
                                      ],
                                      series: <PieSeries<ChartSampleData,
                                          String>>[
                                        PieSeries<ChartSampleData, String>(
                                            explode: true,
                                            explodeIndex: 0,
                                            explodeOffset: '10%',
                                            dataSource: <ChartSampleData>[
                                              ...FaceBookPiegraphChartData
                                              // ChartSampleData(
                                              //     x: 'David', y: 13, text: 'Dav \n 13%'),
                                              // ChartSampleData(
                                              //     x: 'Steve', y: 24, text: 'Ste\n 24%'),
                                              // ChartSampleData(
                                              //     x: 'Jack', y: 25, text: 'Jack \n 25%'),
                                              // ChartSampleData(
                                              //     x: 'Others', y: 38, text: 'Other \n 38%'),
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
                                  'Likes',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            Padding(
                                      padding: const EdgeInsets.only(top: 35.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(FaceBookBarGraphdata['lead'][0]),
                                              Image.asset(
                                                'assets/new Updated images/image_2023_07_12T10_18_35_331Z.png',
                                                height: 30,
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/new Updated images/image_2023_07_12T10_18_25_781Z.png',
                                                    height: 30,
                                                  ),
                                                  Text('YSRCP'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
                                                  Colors.yellow,
                                                  Colors.yellowAccent,
                                                  Color.fromRGBO(249, 125, 9, 0),
                                                ],
                                                //title: ChartTitle(text: isCardView ? '' : 'Website conversion rate'),
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
                                  style: TextStyle(fontSize: 10),
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
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      ' From Posts to public response ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily: 'Segoe UI')),
                                              TextSpan(
                                                  text: FaceBookBarGraphdata['lead'][0],
                                                  style: new TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.green,
                                                      fontSize: 20,
                                                      fontFamily: 'Segoe UI')),
                                              TextSpan(
                                                  text:
                                                      ' is leading in all aspects',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily: 'Segoe UI')),
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
                                                            color: Colors
                                                                .blueAccent),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15)),
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
                                                        labelStyle:
                                                            const TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontSize: 8),
                                                        axisLine: const AxisLine(
                                                            width: 0),
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
                                                          labelStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 8),
                                                          labelPosition:
                                                              ChartDataLabelPosition
                                                                  .outside,
                                                          isVisible: false,
                                                          minimum: 0,
                                                          maximum: 2000),
                                                      series: <ColumnSeries<
                                                          ChartSampleData,
                                                          String>>[
                                                        ColumnSeries<
                                                            ChartSampleData,
                                                            String>(
                                                          width: 0.9,
                                                          dataLabelSettings:
                                                              const DataLabelSettings(
                                                                  isVisible:
                                                                      true,
                                                                  labelAlignment:
                                                                      ChartDataLabelAlignment
                                                                          .top),
                                                          dataSource: <ChartSampleData>[
                                                            ...FaceBookBargraphChartdata
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          xValueMapper:
                                                              (ChartSampleData
                                                                          sales,
                                                                      _) =>
                                                                  sales.x
                                                                      as String,
                                                          yValueMapper:
                                                              (ChartSampleData
                                                                          sales,
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
                                          style: TextStyle(fontSize: 10),
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
                          ),


                ),
              ),
            )
          ]),
    );
  }
  //Bar Graph data
  var FaceBookBarGraphdata;

  Map FaceBookSelectionquery1 = new Map<String, dynamic>();
  List<ChartSampleData> FaceBookBargraphChartdata = [];
  List<ChartSampleData> FaceBookPiegraphChartData = [];
  List<ChartSampleData> FaceBookFunnelgraphChartData = [];
  Future<dynamic> FaceBookBannerGraphApi() async {
    var body = json.encode({
      "type": "party_data",
      "STATE": 'ANDHRA PRADESH',
      "party_list": 'TDP, YSRCP',
      //"social_handle": "YOUTUBE"
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_FB/'),
        headers: headers,
        body: body);

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('inside loop');
      try {
        print('inside try');
        FaceBookBarGraphdata = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          FaceBookBarGraphdata['party_data'].forEach((key, value) {
            print(key);

            FaceBookBargraphChartdata.add(
              ChartSampleData(
                  x: '$key', y: FaceBookBarGraphdata['party_data'][key][0]['LIKES']),
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

          // for(int i=0;i<FaceBookBarGraphdata['party_data'])
          // FaceBookBargraphChartdata.add(ChartSampleData(x: 'TDP', y: 8683),);
        });
        print('data here');
        print(FaceBookBarGraphdata);
      } catch (e) {
        print(FaceBookBarGraphdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return FaceBookBarGraphdata;
  }



  //NewsChannel Banner
    late Future<dynamic> NewschannelLineChartfuturecall = NewsChannelBannerGraphApi();
  TooltipBehavior? _NewsChanneltooltipBehavior;
  TooltipBehavior? _NewsChanneltooltipBehavior1;
  NewsChannelBanner(){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            NewsChannelExpBanner(
            )
        ));
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),

                  ),
                  child: FutureBuilder<dynamic>(
                                            future: NewschannelLineChartfuturecall,
                                            builder: (
                                                BuildContext context,
                                                AsyncSnapshot<dynamic> snapshot,
                                                ) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return SpinKitWave(
                                                  color: Colors.blue,
                                                  size: 18,
                                                );
                                              } else if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                if (snapshot.hasError) {
                                                  return const Text('Error');
                                                } else if (snapshot.hasData) {
                                                  return    Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Stack(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Container( decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .greenAccent),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15)),
                                  height: 120,
                                  width: 120,
                                  child: SfCircularChart(
                                      tooltipBehavior: _NewsChanneltooltipBehavior1,
                                      palette: [
                                        Color.fromRGBO(0, 142, 70,0),
                                        Color.fromRGBO(255, 255, 0,0),
                                        Color.fromRGBO(236, 13, 195,0),
                                      ],
                                      series: <PieSeries<ChartSampleData, String>>[
                                        PieSeries<ChartSampleData, String>(
                                            explode: true,
                                            explodeIndex: 0,
                                            explodeOffset: '10%',
                                            dataSource: <ChartSampleData>[
                                              ...NewsChannelPiegraphChartData
                                              // ChartSampleData(
                                              //     x: 'David', y: 13, text: 'Dav \n 13%'),
                                              // ChartSampleData(
                                              //     x: 'Steve', y: 24, text: 'Ste\n 24%'),
                                              // ChartSampleData(
                                              //     x: 'Jack', y: 25, text: 'Jack \n 25%'),
                                              // ChartSampleData(
                                              //     x: 'Others', y: 38, text: 'Other \n 38%'),
                                            ],
                                            xValueMapper: (ChartSampleData data, _) =>
                                            data.x as String,
                                            yValueMapper: (ChartSampleData data, _) =>
                                            data.y,
                                            dataLabelMapper:
                                                (ChartSampleData data, _) => data.text,
                                            startAngle: 90,
                                            endAngle: 90,
                                            dataLabelSettings: const DataLabelSettings(
                                                isVisible: true)),
                                      ]),
                                ),
                                Text(
                                  'Likes',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                           Padding(
                                      padding: const EdgeInsets.only(top: 35.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(NewsChannelBarGraphdata['lead'][0]),
                                              Image.asset('assets/new Updated images/image_2023_07_12T10_18_35_331Z.png',height: 30,)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset('assets/new Updated images/image_2023_07_12T10_18_25_781Z.png',height: 30,),
                                                  Text('TDP'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                            Column(
                              children: [
                               Container(decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .greenAccent),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15)),
                                            height: 120,
                                            width: 120,
                                            child: SfFunnelChart(palette: [
                                              Color.fromRGBO(0, 142, 70,0),
                                              Color.fromRGBO(255, 255, 0,0),
                                              Color.fromRGBO(236, 13, 195,0),
                                            ],
                                                //title: ChartTitle(text: isCardView ? '' : 'Website conversion rate'),
                                                tooltipBehavior:
                                                TooltipBehavior(enable: true),
                                                series: FunnelSeries<ChartSampleData,
                                                    String>(
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
                                                    const DataLabelSettings(textStyle: TextStyle(fontSize: 8 ),
                                                        isVisible: true)))),
                                Text(
                                  'Comments',
                                  style: TextStyle(fontSize: 10),
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
                                      padding: const EdgeInsets.only(left: 5.0,top: 60),
                                      child: Image.asset(
                                        'assets/NotificationIcons/News-Paper.png',
                                        height: 29,
                                        width: 29,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 140.0,left: 5),
                                      child: Container(
                                        height: 100,
                                        width: 150,
                                        child: RichText(
                                          text: new TextSpan(
                                            // Note: Styles for TextSpans must be explicitly defined.
                                            // Child text spans will inherit styles from parent
                                            style: new TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: NewsChannelBarGraphdata['lead'][0],
                                                  style: new TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.green,
                                                      fontSize: 20,
                                                      fontFamily: 'Segoe UI')),
                                              TextSpan(
                                                  text:
                                                  ' is overpowering ',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily: 'Segoe UI')),
                                              TextSpan(
                                                  text: "Multiple Parties",
                                                  style: new TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      //color: Colors.red,
                                                      fontSize: 18,
                                                      fontFamily: 'Segoe UI')),
                                              TextSpan(
                                                  text:
                                                  ' in all aspects.',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily: 'Segoe UI')),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 100.0),
                                          child:Container(decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .greenAccent),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15)),
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
                                                            color: Colors.black, fontSize: 8),
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
                                                              color: Colors.black, fontSize: 8),
                                                          labelPosition:
                                                          ChartDataLabelPosition.outside,
                                                          isVisible: false,
                                                          minimum: 0,
                                                          maximum: 800),
                                                      series: <ColumnSeries<ChartSampleData,
                                                          String>>[
                                                        ColumnSeries<ChartSampleData, String>(
                                                          width: 0.9,
                                                          dataLabelSettings:
                                                          const DataLabelSettings(textStyle: TextStyle(fontSize: 8),
                                                              isVisible: true,
                                                              labelAlignment:
                                                              ChartDataLabelAlignment.top),
                                                          dataSource: <ChartSampleData>[
                                                            ...NewsChannelBargraphChartdata
                                                          ],
                                                          borderRadius: BorderRadius.circular(10),
                                                          xValueMapper:
                                                              (ChartSampleData sales, _) =>
                                                          sales.x as String,
                                                          yValueMapper:
                                                              (ChartSampleData sales, _) => sales.y,
                                                        ),
                                                      ],
                                                      tooltipBehavior: _NewsChanneltooltipBehavior,
                                                    ),
                                                  ),
                                        ),
                                        Text(
                                          'Views',
                                          style: TextStyle(fontSize: 10),
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
                                          ),



                ),
              ),
            )
          ]),
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
    "party_list": 'TDP',
    "social_handle": "NEWS_CHANNEL"
    });
    var headers = {'Content-Type': 'application/json'};
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6659/social_media_YT/'),
        headers: headers,
        body: body);

    print(response.statusCode);
    if (response.statusCode == 200) {
      print('inside loop');
      try {
        print('inside try');
        NewsChannelBarGraphdata = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          NewsChannelBarGraphdata['party_data'].forEach((key, value) {
            print(key);

            NewsChannelBargraphChartdata.add(
              ChartSampleData(
                  x: '$key', y: NewsChannelBarGraphdata['party_data'][key][0]['LIKES']),
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

          // for(int i=0;i<NewsChannelBarGraphdata['party_data'])
          // NewsChannelBargraphChartdata.add(ChartSampleData(x: 'TDP', y: 8683),);
        });
        print('data here');
        print(NewsChannelBarGraphdata);
      } catch (e) {
        print(NewsChannelBarGraphdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return NewsChannelBarGraphdata;
  }
}











