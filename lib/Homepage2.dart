import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:cool_alert/cool_alert.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intellensense/PageNews/FaceBookScreen.dart';
import 'package:intellensense/PageNews/GoogleTrendsScreen.dart';
import 'package:intellensense/PageNews/InstagramScreen.dart';
import 'package:intellensense/PageNews/LiveUpdatesScreen.dart';
import 'package:intellensense/PageNews/NewsChannelScreen.dart';
import 'package:intellensense/PageNews/NewsPaperScreen.dart';
import 'package:intellensense/PageNews/Newstemplate.dart';
import 'package:intellensense/PageNews/Socialmediatemplate.dart';
import 'package:intellensense/PageNews/TwitterScreen.dart';
import 'package:intellensense/PageNews/YouTubeScreen.dart';
import 'package:intellensense/Pages/Notification.dart';
import 'package:intellensense/Services/ApiServices.dart';
import 'package:intellensense/Services/themesetup/DarkThemeProvider.dart';
import 'package:intellensense/SpalashScreen/screens/login/login.dart';
import 'package:intellensense/SpalashScreen/widgets/Drawer.dart';
import 'package:intellensense/Widgets/SilverAppBars.dart';
import 'package:intellensense/main.dart';

import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'PageNews/ScoreCardsScreen.dart';
import 'Weather screens/ControlScreen.dart';
import 'credentials.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
  @override
  void initState() {
    _getCurrentPosition();
    super.initState();
  }

  // List<Widget> TechNewslist = [
  //   TechNews(),
  //   ForexNews(),
  // ];

  bool touchtoflip = false;
  bool carddirection = false;
  List youtubelink = [];
  int duration = Duration.microsecondsPerMillisecond;
  late Future<dynamic> finaldata = NEWSpaperAPI();
  late Future<dynamic> weatherdata = WeatherAPI();
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
  Position? _currentPosition;
  var WeatherDataResult;
  @override
  Widget build(BuildContext context) {
    Position currentPosition;
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      drawer: drawer(),
      backgroundColor: Color(0xffd2dfff),
      body: NestedScrollView(
          floatHeaderSlivers: true,
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              createSilverAppBar1(),
              createSilverAppBar2(),
            ];
          },
          body: CustomScrollView(
            slivers: [
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
                            padding: const EdgeInsets.only(left: 28, right: 28),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/newspaperhead.gif',
                                  height: 25,
                                  width: 25,
                                ),
                                Text(
                                  'NEWS',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                                Spacer(),
                                IconButton(
                                    onPressed: () {
                                      showMaterialModalBottomSheet(
                                          backgroundColor: Color(0xffd2dfff),
                                          elevation: 10,
                                          bounce: true,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight:
                                                      Radius.circular(15))),
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.5,
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text('PREFERENCES',
                                                          style: GoogleFonts
                                                              .bebasNeue(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      15)),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      ListTile(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          tileColor: Colors
                                                              .blue.shade100,
                                                          onTap: () {
                                                            setState(() {
                                                              carddirection =
                                                                  !carddirection;
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          leading: Text(
                                                            'Scroll Direction',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          trailing: carddirection ==
                                                                  false
                                                              ? Text('Vertical')
                                                              : Text(
                                                                  'Horizontal')),
                                                      SizedBox(
                                                        height: 10,
                                                      ),

                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      ExpansionTile(
                                                        collapsedShape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        title: Text(''),
                                                        backgroundColor: Colors
                                                            .blue.shade100,
                                                        leading:
                                                            Text('Swipe Speed'),
                                                        collapsedBackgroundColor:
                                                            Colors
                                                                .blue.shade100,
                                                        children: [
                                                          ListTile(
                                                            onTap: () {
                                                              setState(() {
                                                                duration = 2200;
                                                              });

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            leading: Text(
                                                              'SLOW',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          ListTile(
                                                            onTap: () {
                                                              setState(() {
                                                                duration = Duration
                                                                    .microsecondsPerMillisecond;
                                                              });

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            leading: Text(
                                                              'MEDIUM',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          ListTile(
                                                            onTap: () {
                                                              setState(() {
                                                                duration = 10;
                                                              });

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            leading: Text(
                                                              'FAST',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      ListTile(
                                                        leading:
                                                            Text('Darkmode'),
                                                        onTap: () {
                                                          setState(() {
                                                            themeChange
                                                                    .darkTheme =
                                                                !themeChange
                                                                    .darkTheme;
                                                          });
                                                        },
                                                      ),
                                                      // SettingsSection(
                                                      //   tiles: [
                                                      //     SettingsTile
                                                      //         .switchTile(
                                                      //       title: Text(
                                                      //           'Use Dark Mode'),
                                                      //       leading: Icon(Icons
                                                      //           .phone_android),
                                                      //       initialValue:
                                                      //           themeChange
                                                      //               .darkTheme,
                                                      //       onToggle: (value) {
                                                      //         setState(() {
                                                      //           themeChange
                                                      //                   .darkTheme =
                                                      //               value;
                                                      //         });
                                                      //       },
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    icon: Icon(Icons.settings))
                              ],
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
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
                                                  List Newpaperlist = [
                                                    NewsTemplate2(
                                                        "${newsdata[0]['id']['mediaName']}",
                                                        '${newsdata[0]['id']['headLine']}',
                                                        'assets/icons/newspaperdxp.png'),
                                                    NewsTemplate3(
                                                        '${newsdata[1]['id']['mediaName']}',
                                                        '${newsdata[1]['id']['headLine']}',
                                                        'assets/icons/newspaperdxp.png'),
                                                    NewsTemplate1(
                                                        '${newsdata[2]['id']['mediaName']}',
                                                        '${newsdata[2]['id']['headLine']}',
                                                        'assets/icons/newspaperdxp.png'),
                                                    NewsTemplate4(
                                                        '${newsdata[3]['id']['mediaName']}',
                                                        '${newsdata[3]['id']['headLine']}',
                                                        'assets/icons/newspaperdxp.png'),
                                                  ];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        viewnews = true;
                                                      });
                                                      PageCount.jumpToPage(0);
                                                    },
                                                    child: SizedBox(
                                                      height: 130,
                                                      width: 150,
                                                      child: Swiper(
                                                          itemWidth: 150,
                                                          itemHeight: 130,
                                                          duration: duration,
                                                          layout: swiperlayout,
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
                                                            return Newpaperlist[
                                                                index];
                                                          },
                                                          itemCount: 4,
                                                          pagination:
                                                              SwiperPagination(
                                                                  builder:
                                                                      DotSwiperPaginationBuilder(
                                                            size: 7,
                                                            color: Colors.grey,
                                                            activeColor: Colors
                                                                .blue.shade200,
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
                                                  List NewschannelList = [
                                                    NewsTemplate2(
                                                        "${newchannelldata[0]['mediaChannelName']}",
                                                        '${newchannelldata[0]['videoTitle']}',
                                                        'assets/icons/newsdxps.png'),
                                                    NewsTemplate3(
                                                        '${newchannelldata[1]['mediaChannelName']}',
                                                        '${newchannelldata[1]['videoTitle']}',
                                                        'assets/icons/newsdxps.png'),
                                                    NewsTemplate1(
                                                        '${newchannelldata[2]['mediaChannelName']}',
                                                        '${newchannelldata[2]['videoTitle']}',
                                                        'assets/icons/newsdxps.png'),
                                                    NewsTemplate4(
                                                        '${newchannelldata[3]['mediaChannelName']}',
                                                        '${newchannelldata[3]['videoTitle']}',
                                                        'assets/icons/newsdxps.png'),
                                                  ];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        viewnews = true;
                                                      });
                                                      PageCount.jumpToPage(1);
                                                    },
                                                    child: SizedBox(
                                                      height: 130,
                                                      width: 150,
                                                      child: Swiper(
                                                          itemWidth: 150,
                                                          itemHeight: 130,
                                                          duration: duration,
                                                          layout: swiperlayout,
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
                                                            return NewschannelList[
                                                                index];
                                                          },
                                                          itemCount: 4,
                                                          pagination:
                                                              SwiperPagination(
                                                                  builder:
                                                                      DotSwiperPaginationBuilder(
                                                            size: 7,
                                                            color: Colors.grey,
                                                            activeColor: Colors
                                                                .blue.shade200,
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
                                                  List LiveNewsList = [
                                                    NewsTemplate2(
                                                        "${Livenewsdata[0]['id']['mediaName']}",
                                                        '${Livenewsdata[0]['id']['headLine']}',
                                                        'assets/icons/live.gif'),
                                                    NewsTemplate3(
                                                        '${Livenewsdata[1]['id']['mediaName']}',
                                                        '${Livenewsdata[1]['id']['headLine']}',
                                                        'assets/icons/live.gif'),
                                                    NewsTemplate1(
                                                        '${Livenewsdata[2]['id']['mediaName']}',
                                                        '${Livenewsdata[2]['id']['headLine']}',
                                                        'assets/icons/live.gif'),
                                                    NewsTemplate4(
                                                        '${Livenewsdata[3]['id']['mediaName']}',
                                                        '${Livenewsdata[3]['id']['headLine']}',
                                                        'assets/icons/live.gif'),
                                                  ];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        viewnews = true;
                                                      });
                                                      PageCount.jumpToPage(2);
                                                    },
                                                    child: SizedBox(
                                                      height: 130,
                                                      width: 150,
                                                      child: Swiper(
                                                          itemWidth: 150,
                                                          itemHeight: 130,
                                                          duration: duration,
                                                          layout: swiperlayout,
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
                                                            return LiveNewsList[
                                                                index];
                                                          },
                                                          itemCount: 4,
                                                          pagination:
                                                              SwiperPagination(
                                                                  builder:
                                                                      DotSwiperPaginationBuilder(
                                                            size: 7,
                                                            color: Colors.grey,
                                                            activeColor: Colors
                                                                .blue.shade200,
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
                                                  List GoogleTrendsList = [
                                                    NewsTemplate2(
                                                        "${GoogleTrendsdata[0]['partyName']}",
                                                        '${GoogleTrendsdata[0]['id']['region']}',
                                                        'assets/icons/googleTrends.png'),
                                                    NewsTemplate3(
                                                        '${GoogleTrendsdata[1]['partyName']}',
                                                        '${GoogleTrendsdata[1]['id']['region']}',
                                                        'assets/icons/googleTrends.png'),
                                                    NewsTemplate1(
                                                        '${GoogleTrendsdata[2]['partyName']}',
                                                        '${GoogleTrendsdata[2]['id']['region']}',
                                                        'assets/icons/googleTrends.png'),
                                                    NewsTemplate4(
                                                        '${GoogleTrendsdata[3]['partyName']}',
                                                        '${GoogleTrendsdata[3]['id']['region']}',
                                                        'assets/icons/googleTrends.png'),
                                                  ];
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        viewnews = true;
                                                      });
                                                      PageCount.jumpToPage(3);
                                                    },
                                                    child: SizedBox(
                                                      height: 130,
                                                      width: 150,
                                                      child: Swiper(
                                                          itemWidth: 150,
                                                          itemHeight: 130,
                                                          duration: duration,
                                                          layout: swiperlayout,
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
                                                            return GoogleTrendsList[
                                                                index];
                                                          },
                                                          itemCount: 4,
                                                          pagination:
                                                              SwiperPagination(
                                                                  builder:
                                                                      DotSwiperPaginationBuilder(
                                                            size: 7,
                                                            color: Colors.grey,
                                                            activeColor: Colors
                                                                .blue.shade200,
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
                                      ]))),

                          //todo:social media

                          Padding(
                            padding: const EdgeInsets.only(left: 28),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/socialmedia.gif',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  'SOCIAL MEDIA',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
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
                                            padding: const EdgeInsets.only(
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
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.hasError) {
                                            return const Text('Data Error');
                                          } else if (snapshot.hasData) {
                                            List YoutubeList = [
                                              SocialMediaTemplate1(
                                                  '${Youtubedata[0]['mediaChannelName']}',
                                                  '${Youtubedata[0]['videoTitle']}'),
                                              SocialMediaTemplate1(
                                                  '${Youtubedata[1]['mediaChannelName']}',
                                                  '${Youtubedata[1]['videoTitle']}'),
                                              SocialMediaTemplate1(
                                                  '${Youtubedata[2]['mediaChannelName']}',
                                                  '${Youtubedata[2]['videoTitle']}'),
                                              SocialMediaTemplate1(
                                                  '${Youtubedata[3]['mediaChannelName']}',
                                                  '${Youtubedata[3]['videoTitle']}'),
                                            ];
                                            return SizedBox(
                                              height: 130,
                                              width: 150,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    viewnews = true;
                                                  });
                                                  PageCount.jumpToPage(4);
                                                },
                                                child: Swiper(
                                                    itemWidth: 150,
                                                    itemHeight: 130,
                                                    duration: duration,
                                                    layout: swiperlayout,
                                                    scrollDirection:
                                                        carddirection == false
                                                            ? Axis.vertical
                                                            : Axis.horizontal,
                                                    autoplay: true,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return YoutubeList[index];
                                                    },
                                                    itemCount: 4,
                                                    pagination:
                                                        SwiperPagination(
                                                            builder:
                                                                DotSwiperPaginationBuilder(
                                                      size: 7,
                                                      color: Colors.grey,
                                                      activeColor:
                                                          Colors.blue.shade200,
                                                    ))),
                                              ),
                                            );
                                          } else {
                                            return const Text('Server Error');
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
                                            padding: const EdgeInsets.only(
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
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.hasError) {
                                            return const Text('Data Error');
                                          } else if (snapshot.hasData) {
                                            List TwitterList = [
                                              SocialMediaTemplate2(
                                                  '${TwitterData[0]['candidateName']}',
                                                  '${TwitterData[0]['tweetContent']}'),
                                              SocialMediaTemplate2(
                                                  '${TwitterData[1]['candidateName']}',
                                                  '${TwitterData[1]['tweetContent']}'),
                                              SocialMediaTemplate2(
                                                  '${TwitterData[2]['candidateName']}',
                                                  '${TwitterData[2]['tweetContent']}'),
                                              SocialMediaTemplate2(
                                                  '${TwitterData[3]['candidateName']}',
                                                  '${TwitterData[3]['tweetContent']}'),
                                            ];
                                            return SizedBox(
                                              height: 130,
                                              width: 150,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    viewnews = true;
                                                  });
                                                  PageCount.jumpToPage(5);
                                                },
                                                child: Swiper(
                                                    itemWidth: 150,
                                                    itemHeight: 130,
                                                    duration: duration,
                                                    layout: swiperlayout,
                                                    scrollDirection:
                                                        carddirection == false
                                                            ? Axis.vertical
                                                            : Axis.horizontal,
                                                    autoplay: true,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return TwitterList[index];
                                                    },
                                                    itemCount: 4,
                                                    pagination:
                                                        SwiperPagination(
                                                            builder:
                                                                DotSwiperPaginationBuilder(
                                                      size: 7,
                                                      color: Colors.grey,
                                                      activeColor:
                                                          Colors.blue.shade200,
                                                    ))),
                                              ),
                                            );
                                          } else {
                                            return const Text('Server Error');
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
                                            padding: const EdgeInsets.only(
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
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.hasError) {
                                            return const Text('Data Error');
                                          } else if (snapshot.hasData) {
                                            List FaceBookList = [
                                              SocialMediaTemplate3(
                                                  '${Facebookdata[0]['candidateName']}',
                                                  '${Facebookdata[0]['titleContent']}'),
                                              SocialMediaTemplate3(
                                                  '${Facebookdata[1]['candidateName']}',
                                                  '${Facebookdata[1]['titleContent']}'),
                                              SocialMediaTemplate3(
                                                  '${Facebookdata[2]['candidateName']}',
                                                  '${Facebookdata[2]['titleContent']}'),
                                              SocialMediaTemplate3(
                                                  '${Facebookdata[3]['candidateName']}',
                                                  '${Facebookdata[3]['titleContent']}'),
                                            ];
                                            return SizedBox(
                                              height: 130,
                                              width: 150,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    viewnews = true;
                                                  });
                                                  PageCount.jumpToPage(6);
                                                },
                                                child: Swiper(
                                                    itemWidth: 150,
                                                    itemHeight: 130,
                                                    duration: duration,
                                                    layout: swiperlayout,
                                                    scrollDirection:
                                                        carddirection == false
                                                            ? Axis.vertical
                                                            : Axis.horizontal,
                                                    autoplay: true,
                                                    itemBuilder:
                                                        (BuildContext context,
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
                                                      color: Colors.grey,
                                                      activeColor:
                                                          Colors.blue.shade200,
                                                    ))),
                                              ),
                                            );
                                          } else {
                                            return const Text('Server Error');
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
                                            padding: const EdgeInsets.only(
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
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.hasError) {
                                            return const Text('Data Error');
                                          } else if (snapshot.hasData) {
                                            List InstagramList = [
                                              SocialMediaTemplate4(
                                                  '${Instagramdata[0]['candidateName']}',
                                                  '${Instagramdata[0]['titleContent']}'),
                                              SocialMediaTemplate4(
                                                  '${Instagramdata[1]['candidateName']}',
                                                  '${Instagramdata[1]['titleContent']}'),
                                              SocialMediaTemplate4(
                                                  '${Instagramdata[2]['candidateName']}',
                                                  '${Instagramdata[2]['titleContent']}'),
                                              SocialMediaTemplate4(
                                                  '${Instagramdata[3]['candidateName']}',
                                                  '${Instagramdata[3]['titleContent']}'),
                                            ];
                                            return SizedBox(
                                              height: 130,
                                              width: 150,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    viewnews = true;
                                                  });
                                                  PageCount.jumpToPage(7);
                                                },
                                                child: Swiper(
                                                    itemWidth: 150,
                                                    itemHeight: 130,
                                                    duration: duration,
                                                    layout: swiperlayout,
                                                    scrollDirection:
                                                        carddirection == false
                                                            ? Axis.vertical
                                                            : Axis.horizontal,
                                                    autoplay: true,
                                                    itemBuilder:
                                                        (BuildContext context,
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
                                                      color: Colors.grey,
                                                      activeColor:
                                                          Colors.blue.shade200,
                                                    ))),
                                              ),
                                            );
                                          } else {
                                            return const Text('Server Error');
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
                          GridView.count(
                            crossAxisCount: 5,
                            crossAxisSpacing: 2,
                            childAspectRatio: 1.2 / 1.18,
                            shrinkWrap: true,
                            children: [
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
                                        "assets/new Updated images/Candidature Analysis.png",
                                        height: 30,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                        color: Colors.grey[100]),
                                    padding: EdgeInsets.all(8),
                                    /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    'Candidature Analysis',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
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
                                        "assets/new Updated images/Constituency Analysis.png",
                                        height: 30,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                        color: Colors.grey[100]),
                                    padding: EdgeInsets.all(8),
                                    /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Constituency Analysis',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
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
                                        "assets/icons/locations_icon.png",
                                        height: 30,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                        color: Colors.grey[100]),
                                    padding: EdgeInsets.all(8),
                                    /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'District Analysis',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
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
                                        "assets/new Updated images/Communication Channel.png",
                                        height: 30,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                        color: Colors.grey[100]),
                                    padding: EdgeInsets.all(8),
                                    /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Communication Channel',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
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
                                        "assets/new Updated images/Survey.png",
                                        height: 30,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                        color: Colors.grey[100]),
                                    padding: EdgeInsets.all(8),
                                    /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Survey',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
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
                                        "assets/new Updated images/Electrol Analysis.png",
                                        height: 30,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                        color: Colors.grey[100]),
                                    padding: EdgeInsets.all(8),
                                    /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Electoral Analysis',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
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
                                        "assets/new Updated images/News Feed.png",
                                        height: 30,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                        color: Colors.grey[100]),
                                    padding: EdgeInsets.all(8),
                                    /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'News Feed',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
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
                                        "assets/icons/faceEmotiondxp.png",
                                        height: 30,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                        color: Colors.grey[100]),
                                    padding: EdgeInsets.all(8),
                                    /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Face Emotion Analysis',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
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
                                        "assets/icons/ScoreCard.png",
                                        height: 30,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                        color: Colors.grey[100]),
                                    padding: EdgeInsets.all(8),
                                    /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Score Card',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
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
                                        "assets/icons/chat_icon.png",
                                        height: 30,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                        color: Colors.grey[100]),
                                    padding: EdgeInsets.all(8),
                                    /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Chat Analysis',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
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
                                        "assets/icons/sentiAnalysis.png",
                                        height: 30,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                        color: Colors.grey[100]),
                                    padding: EdgeInsets.all(8),
                                    /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Sentiment Analysis',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                )
                              ]),
                            ],
                          ),
                          //todo: Stock market
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 28),
                          //   child: Row(
                          //     children: [
                          //       Image.asset(
                          //         'assets/images/stocks.gif',
                          //         height: 30,
                          //         width: 30,
                          //       ),
                          //       Text(
                          //         'MARKET HUNT',
                          //         style: TextStyle(
                          //             fontSize: 18,
                          //             fontWeight: FontWeight.w800),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // FlipCard(
                          //   onFlip: () {
                          //     setState(() {
                          //       touchtoflip = !touchtoflip;
                          //     });
                          //   },
                          //   flipOnTouch: touchtoflip,
                          //   controller: flipCardController,
                          //   fill: Fill
                          //       .fillBack, // Fill the back side of the card to make in the same size as the front.
                          //   direction: FlipDirection.VERTICAL, // default
                          //   side: CardSide
                          //       .FRONT, // The side to initially display.
                          //   front: Padding(
                          //     padding:
                          //         const EdgeInsets.only(left: 8.0, right: 8),
                          //     child: Card(
                          //         elevation: 10,
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(8.0),
                          //           child: Container(
                          //             color: Colors.blueAccent.shade100,
                          //             height: 160,
                          //             width: MediaQuery.of(context).size.width,
                          //             child: Row(
                          //               children: [
                          //                 SingleChildScrollView(
                          //                   child: Column(children: [
                          //                     FutureBuilder(
                          //                         future: stockdata1,
                          //                         builder:
                          //                             ((context, snapshot) {
                          //                           if (snapshot
                          //                                   .connectionState ==
                          //                               ConnectionState
                          //                                   .waiting) {
                          //                             return Padding(
                          //                               padding:
                          //                                   const EdgeInsets
                          //                                           .only(
                          //                                       top: 70.0),
                          //                               child: SizedBox(
                          //                                   height: 150,
                          //                                   width: 150,
                          //                                   child: Center(
                          //                                       child:
                          //                                           SpinKitWave(
                          //                                     size: 18,
                          //                                     color:
                          //                                         Colors.blue,
                          //                                   ))),
                          //                             );
                          //                           } else if (snapshot
                          //                                   .connectionState ==
                          //                               ConnectionState.done) {
                          //                             if (snapshot.hasError) {
                          //                               return const Text(
                          //                                   'Data Error');
                          //                             } else if (snapshot
                          //                                 .hasData) {
                          //                               return StockCardModel(
                          //                                   Stockname: 'TESLA',
                          //                                   CurrentPrice:
                          //                                       '${TeslaStocksData['c']}',
                          //                                   High: '245',
                          //                                   Low: '220',
                          //                                   Change: '23',
                          //                                   StockIcon:
                          //                                       'assets/images/tesla.png');
                          //                             } else {
                          //                               return const Text(
                          //                                   'Server Error');
                          //                             }
                          //                           } else {
                          //                             return Text(
                          //                                 'State: ${snapshot.connectionState}');
                          //                           }
                          //                         })),
                          //                     StockCardModel(
                          //                       Stockname: 'APPLE',
                          //                       CurrentPrice: '554',
                          //                       High: '578',
                          //                       Low: '543',
                          //                       Change: '23',
                          //                       StockIcon:
                          //                           'assets/images/apple.png',
                          //                     ),
                          //                     StockCardModel(
                          //                         Stockname: 'ALPHABET',
                          //                         CurrentPrice: '554',
                          //                         High: '578',
                          //                         Low: '543',
                          //                         Change: '23',
                          //                         StockIcon:
                          //                             'assets/images/alphabet.png'),
                          //                   ]),
                          //                 ),
                          //                 SizedBox(
                          //                   width: 25,
                          //                 ),
                          //                 Column(
                          //                   children: [
                          //                     GestureDetector(
                          //                       onTap: () {
                          //                         flipCardController!
                          //                             .toggleCard();
                          //                       },
                          //                       child: Image.asset(
                          //                         'assets/images/tap.gif',
                          //                         height: 150,
                          //                         width: 120,
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 )
                          //               ],
                          //             ),
                          //           ),
                          //         )),
                          //   ),
                          //   back: Padding(
                          //       padding:
                          //           const EdgeInsets.only(left: 8.0, right: 8),
                          //       child: Card(
                          //           elevation: 10,
                          //           child: Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: SizedBox(
                          //                 // color: Colors.blueAccent.shade100,
                          //                 height: 160,
                          //                 width:
                          //                     MediaQuery.of(context).size.width,
                          //                 child: Swiper(
                          //                   itemHeight: 160,
                          //                   itemWidth: MediaQuery.of(context)
                          //                       .size
                          //                       .width,
                          //                   pagination: SwiperPagination(
                          //                       builder:
                          //                           DotSwiperPaginationBuilder(
                          //                     size: 7,
                          //                     color: Colors.grey,
                          //                     activeColor: Colors.blue.shade200,
                          //                   )),
                          //                   scrollDirection: Axis.horizontal,
                          //                   autoplay: false,
                          //                   itemCount: 2,
                          //                   itemBuilder: (BuildContext context,
                          //                       int index) {
                          //                     return TechNewslist[index];
                          //                   },
                          //                 ),
                          //               )))),
                          // ),

                          viewnews == true
                              ? SizedBox(
                                  height: 450,
                                  child: PageView.builder(
                                      // physics: NeverScrollableScrollPhysics(),
                                      controller: PageCount,
                                      itemCount: DailyNewsPages.length,
                                      itemBuilder: (BuildContext, index) {
                                        return DailyNewsPages[index];
                                      }))
                              : Container(),

                          // Padding(
                          //   padding: const EdgeInsets.only(left: 28),
                          //   child: Row(
                          //     children: [
                          //       Image.asset(
                          //         'assets/trending.gif',
                          //         height: 30,
                          //         width: 30,
                          //       ),
                          //       Text(
                          //         'TRENDING',
                          //         style: TextStyle(
                          //             fontSize: 18, fontWeight: FontWeight.w800),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   height: 250,
                          //   child: ListView.builder(
                          //       scrollDirection: Axis.horizontal,
                          //       itemCount: 5,
                          //       itemBuilder: (context, index) {
                          //         for (int i = 0; i < newchannelldata.length; i++) {
                          //           youtubelink.add(convertUrlToId(
                          //               newchannelldata[i]['sourceUrl']));
                          //         }
                          //         YoutubePlayerController _controller =
                          //             YoutubePlayerController(
                          //           initialVideoId: youtubelink[index],
                          //           flags: YoutubePlayerFlags(
                          //             autoPlay: false,
                          //             mute: true,
                          //           ),
                          //         );
                          //         return FutureBuilder(
                          //           future: Newschanneldata,
                          //           builder: ((context, snapshot) {
                          //             if (snapshot.connectionState ==
                          //                 ConnectionState.waiting) {
                          //               return Padding(
                          //                 padding: const EdgeInsets.only(top: 70.0),
                          //                 child: Center(
                          //                     child: CircularProgressIndicator()),
                          //               );
                          //             } else if (snapshot.connectionState ==
                          //                 ConnectionState.done) {
                          //               if (snapshot.hasError) {
                          //                 return const Text('Data Error');
                          //               } else if (snapshot.hasData) {
                          //                 return Padding(
                          //                   padding: const EdgeInsets.only(left: 10.0),
                          //                   child: Container(
                          //                     decoration: BoxDecoration(
                          //                         borderRadius:
                          //                             BorderRadius.circular(15)),
                          //                     height: 250,
                          //                     width: 250,
                          //                     child: Card(
                          //                       shape: RoundedRectangleBorder(
                          //                           borderRadius:
                          //                               BorderRadius.circular(15)),
                          //                       elevation: 5,
                          //                       child: Column(children: [
                          //                         Padding(
                          //                           padding: const EdgeInsets.all(5.0),
                          //                           child: ClipRRect(
                          //                             borderRadius:
                          //                                 BorderRadius.circular(15),
                          //                             child: YoutubePlayer(
                          //                               controller: _controller,
                          //                               showVideoProgressIndicator:
                          //                                   true,
                          //                               progressIndicatorColor:
                          //                                   Colors.amber,
                          //                               progressColors:
                          //                                   ProgressBarColors(
                          //                                 playedColor: Colors.amber,
                          //                                 handleColor:
                          //                                     Colors.amberAccent,
                          //                               ),
                          //                               onReady: () {
                          //                                 _controller.notifyListeners();
                          //                               },
                          //                             ),
                          //                           ),
                          //                         ),
                          //                         SizedBox(height: 10),
                          //                         Padding(
                          //                           padding: const EdgeInsets.all(6.0),
                          //                           child: Flexible(
                          //                               child: Text(
                          //                             newchannelldata[index]
                          //                                 ['videoTitle'],
                          //                             style: TextStyle(fontSize: 12),
                          //                           )),
                          //                         ),
                          //                       ]),
                          //                     ),
                          //                   ),
                          //                 );
                          //               } else {
                          //                 return const Text('Server Error');
                          //               }
                          //             } else {
                          //               return Text(
                          //                   'State: ${snapshot.connectionState}');
                          //             }
                          //           }),
                          //         );
                          //       }),
                          // )
                        ]),
                  ),
                ),
              ]))
            ],
          )),
    );
  }

  List<Widget> NewsPaperList() {
    if (newsdata.length == 0) return [];
    return newsdata
        .map<Card>((Value) => Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.all(4),
              elevation: 20,
              child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Value['id']['mediaName'] ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      Text(
                        Value['id']['publishedDate'] ?? '',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        Value['id']['headLine'] ?? '',
                        maxLines: 3,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  onTap: () {}
                  // launchUrl(Uri.parse(Value['sourceUrl'])
                  ),
            ))
        .toList();
  }

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

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {}

  SliverAppBar createSilverAppBar1() {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      floating: true,
      snap: true,
      actions: [
        PopupMenuButton(onSelected: (value) {
          if (value == 'notifications') {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Notifications()));
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
          ];
        }),
      ],
      backgroundColor: Color(0xffd2dfff),
      expandedHeight: 130,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 5),
                  child: Lottie.asset('assets/Image/bg.json',
                      height: 140, width: 120),
                ),
                Image.asset(
                  'assets/icons/IntelliSense-Logo-Finall_01022023_A.gif',
                  // fit: BoxFit.contain,
                  height: 120, width: 130,
                ),
              ],
            ),
            Positioned(
                top: 110,
                left: 230,
                child: Container(
                  width: 100,
                  height: 35,
                  decoration: BoxDecoration(color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> ControllScreen()));
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            FutureBuilder(
                                future: weatherdata,
                                builder: ((context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                        child: Center(
                                            child: SpinKitWave(
                                      size: 12,
                                      color: Colors.blue,
                                    )));
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return const Text('Data Error');
                                    } else if (snapshot.hasData) {
                                      return Column(
                                        children: [
                                          Text(
                                              '${WeatherDataResult['main']['temp']}'),
                                          Text('${WeatherDataResult['name']}',style: TextStyle(overflow: TextOverflow.fade)),
                                        ],
                                      );
                                    } else {
                                      return const Text('Server Error');
                                    }
                                  } else {
                                    return Text(
                                        'State: ${snapshot.connectionState}');
                                  }
                                }))
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.cloud),
                      ],
                    ),
                  ),
                ))
            // Positioned(
            //     child: _currentPosition!.latitude == null
            //         ? Text('${_currentPosition!.latitude}')
            //         : Text('No data')
            //     // IconButton(
            //     //     onPressed: () {
            //     //       Navigator.push(
            //     //           context,
            //     //           MaterialPageRoute(
            //     //               builder: (context) => LocationPage()));
            //     //     },
            //     //     icon: Icon(Icons.sunny))
            //     ),
          ],
        );
      }),
    );
  }

  Future<dynamic> WeatherAPI() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(_currentPosition!.latitude);
    print(_currentPosition!.longitude);
    print('hi1');
    var headers = {'Content-Type': 'application/json'};
    print('hi2');
    var response = await get(
      Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?lat=${_currentPosition!.latitude}&lon=${_currentPosition!.longitude}&appid=${apiKey}&units=metric'),
      headers: headers,
    );
    print('hi3');
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.statusCode);
      try {
        setState(() =>
            WeatherDataResult = jsonDecode(utf8.decode(response.bodyBytes)));
      } catch (e) {}
    } else {
      print(response.reasonPhrase);
    }
    return WeatherDataResult;
  }

  LogoutAPI(BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    var body =
        json.encode({"rsUsername": "${logindata.getString('username')}"});
    var response = await post(
      Uri.parse('https://ifar.pilogcloud.com/appUserlogout'),
      headers: headers,
      body: body,
    );
    if (response.body == 'Success') {
      print(response.body);
      logindata.setBool('login', true);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Login(
                    screenHeight: MediaQuery.of(context).size.height,
                  )));

      await Fluttertoast.showToast(
          msg: "ThankYou",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(11, 74, 153, 1),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print(response.reasonPhrase);
    }
    Navigator.of(context, rootNavigator: true).pop();
    return response;
  }
}

bool viewnews = false;
