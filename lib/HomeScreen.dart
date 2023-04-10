import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intellensense/Pages/Notification.dart';
import 'package:intellensense/SpalashScreen/widgets/Drawer.dart';
import 'package:intellensense/TRS%20Screens/MPsTrsScreen.dart';
import 'package:marquee/marquee.dart';
import 'package:marquee_text/marquee_direction.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:url_launcher/url_launcher.dart';
import 'InfoGraphicsScreen.dart';
import 'PageNews/FaceBookScreen.dart';
import 'PageNews/GoogleTrendsScreen.dart';
import 'PageNews/InstagramScreen.dart';
import 'PageNews/LiveUpdatesScreen.dart';
import 'PageNews/NewsChannelScreen.dart';
import 'PageNews/NewsPaperScreen.dart';
import 'PageNews/ScoreCardsScreen.dart';
import 'PageNews/SurveyScreen.dart';
import 'PageNews/TwitterScreen.dart';
import 'PageNews/YouTubeScreen.dart';
import 'Pages/AccountSettingsPage.dart';
import 'SettingsScreen.dart';
import 'SpalashScreen/constants.dart';
import 'SpalashScreen/screens/login/login.dart';
import 'SpalashScreen/screens/login/widgets/login_form.dart';
import 'TRS Screens/ChatDetailPage.dart';
import 'TRS Screens/MLAsTrsScreen.dart';
import 'TestScreen.dart';
import 'main.dart';
import 'main.dart';

class HomeScreen extends StatefulWidget {
  // var logindata;
  // HomeScreen(
  //   this.logindata,
  // );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  PageController PageCount = PageController();
  PageController pagecont = PageController();
  late final AnimationController _animationController;
  late final Animation<double> _formElementAnimation;
  late final Animation<double> _whiteTopClipperAnimation;
  late final Animation<double> _blueTopClipperAnimation;
  late final Animation<double> _greyTopClipperAnimation;
  String username = '';
  String password = '';
  var NewsPaperAllResult = [];
  var NewsChannelAllResult = [];
  var LiveUpdateAllResult = [];
  var NotificationsAllResult = [];
  int _selectedIndex = 0;
  late TabController _tabController;
  /*List<Widget> SocialMediaTrendsPages = [
    GoogleTrendsScreen(),
    ScoreCardsScreen(),
    TwitterScreen(),
    YouTubeScreen(),
  ];*/
  List<Widget> DailyNewsPages = [
    NewsPaperScreen(),
    NewsChannelScreen(),
    LiveUpdatesScreen(),
    GoogleTrendsScreen(),
    YouTubeScreen(),
    FaceBookScreen(),
    TwitterScreen(),
    InstagramScreen()
  ];
  static List<Widget> _widgetOptions = [];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Color> co = [
    Colors.red,
    Colors.black,
    Colors.green,
    Colors.purple,
    Colors.pink
  ];
  @override
  void initState() {
    NotificationsAPI();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: kLoginAnimationDuration,
    );
    final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));
    /*NewsPaperAllAPI();
    NewsChannelAllAPI();
    LiveUpdateAllAPI();
    NewsPaperList();
    NewsChannelList();
    LiveUpdateList();*/
  }

  bool SecondrowVisible = false;
  String? selectedValue;
  String dropdownvalue = 'Item 1';
  var items = [
    'Social Media & News Analysis',
    'Infographics',
  ];
  @override
  Widget build(BuildContext context) {
    /*_widgetOptions = <Widget>[
      //insideOptions(context),
      //ChatScreen(context),
      SearchScreen(context),
      ChatDetailPage(),
      //UserScreen(),
    ];*/
    return WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                extendBodyBehindAppBar: false,
                appBar: AppBar(
                  centerTitle: true,
                  title: Image.asset(
                    'assets/icons/IntelliSense-Logo-Finall_01022023_A.gif',
                    height: 70,
                  ),
                  actions: [
                    PopupMenuButton(onSelected: (value) {
                      if (value == 'notifications') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Notifications()));
                      }
                    }, itemBuilder: (BuildContext bc) {
                      return [
                        PopupMenuItem(
                          child: Text("Reader Mode"),
                          value: 'Reader',
                          onTap: () {
                            setState(() {
                              SecondrowVisible = !SecondrowVisible;
                            });
                          },
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
                    // IconButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         SecondrowVisible = !SecondrowVisible;
                    //       });
                    //     },
                    //     icon: Icon(Icons.chrome_reader_mode_sharp)),
                    // IconButton(
                    //     onPressed: () async {
                    //       CoolAlert.show(
                    //         confirmBtnColor: Color(0xff00186a),
                    //         backgroundColor: Color(0xff001969),
                    //         context: context,
                    //         type: CoolAlertType.confirm,
                    //         onConfirmBtnTap: () => LogoutAPI(context),
                    //       );
                    //     },
                    //     icon: Icon(Icons.logout_rounded))
                  ],
                  iconTheme: IconThemeData(color: Colors.black),
                  elevation: 0,
                  backgroundColor: Colors.white,

                  //backgroundColor: Color.fromRGBO(58, 129, 233, 1),
                  /* bottom: TabBar(
                    labelColor: Colors.black,
                    controller: _tabController,
                    tabs: const <Widget>[
                      Tab(
                        text: "News",
                      ),
                      Tab(
                        text: "Score Cards",
                      ),
                      */ /*Tab(
              text: "YouTube",
            ),*/ /*
                    ],
                  ),*/
                ),
                drawer: drawer(),
                body: Container(
                  child: NewsPaperData(),
                )
                /*TabBarView(controller: _tabController, children: [
                  NewsPaperData(),
                  //DailyNews(),
                  ScoreCardsData(),

                  //GoogleTrendsScreen(),

                  //TwitterScreen(),
                  */ /* ListView(
          children: [
            NewsPaperData(),
          ],
        )*/ /*
                ])*/
                /*Padding(padding:EdgeInsets.only(top: 20),child:_widgetOptions[_selectedIndex]),*/
                /*bottomNavigationBar: BottomNavigationBar(elevation: 0,
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            */ /*BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/Chat-Icon-3D.png',
                height: 20,
              ),
              label: 'Chat',
              backgroundColor: Colors.blueAccent,
            ),*/ /*
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/Home.gif',
                height: 30,
              ),
              label: 'Home',
              backgroundColor: Colors.blueGrey,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/Chat.gif',
                height: 30,
              ),
              label: 'Chat',
              backgroundColor: Colors.blueAccent,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/User.gif',
                height: 30,
              ),
              label: 'User',
              backgroundColor: Colors.indigoAccent,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromRGBO(11, 74, 153, 1),
          onTap: _onItemTapped,
        )*/
                )));
  }

  ScoreCardsData() {
    final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: ExpansionTileCard(
            baseColor: Colors.cyan[50],
            expandedColor: Colors.white,
            key: cardA,
            leading: CircleAvatar(backgroundColor: Colors.grey),
            title: Text("A V S S AMARNATH GUDIVADA"),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text('Follow')),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('Message'))
                  ],
                )
              ],
            ),
            children: <Widget>[
              Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(130.0),
                      border: TableBorder.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 2),
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  'Social Media',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(''),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(''),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(''),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(''),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(''),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(''),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  'Rank',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text('55'),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text('64'),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text('87'),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text('109'),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text('28'),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text('17'),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  'Based on rank',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(''),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(''),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(''),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(''),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(''),
                              ),
                            ),
                            TableCell(
                              verticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(''),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[
                  Row(
                    children: [
                      Text('Analytics'),
                      SizedBox(
                        width: 50,
                      ),
                      Image.asset(
                        'assets/icons/Social-Media-Icons-IS-01.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/icons/Social-Media-Icons-IS-02.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/icons/Social-Media-Icons-IS-03.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/icons/Social-Media-Icons-IS-04.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/icons/Social-Media-Icons-IS-05.png',
                        height: 20,
                        width: 20,
                      ),
                    ],
                  )
                  /*MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    onPressed: () {
                      cardA.currentState?.expand();
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.arrow_downward),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text('Open'),
                      ],
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    onPressed: () {
                      cardA.currentState?.collapse();
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.arrow_upward),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text('Close'),
                      ],
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    onPressed: () {
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.swap_vert),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text('Toggle'),
                      ],
                    ),
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  NewsPaperData() {
    bool _useRtlText = false;
    final List<String> _textList = [
      'Twitter',
      'YuvaGalamPadayatra JanaSenaFormationDay,JanaSenaParty,PawanKalyan JaganPaniAyipoyindhi,PsychoPovaliCycleRavali WalkWithLokesh,YuvaGalam,YuvaGalamPadayatra'
    ];
    var firstTextIndex = 0;

    /*ScrollController _scrollController = ScrollController();

    _scrollToBottom(){  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
    List<String>_listViewData = [
      "jsdfxnnfjasks","jsfjjksjoasfjanfafj","njsfojbzfjkabsfj","jsajfjszfjabfjafjb"
    ];*/
    return Column(children: [
      Row(
        children: <Widget>[
          Container(
            color: Colors.blueAccent,
            width: 60,
            height: 20,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: MarqueeText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: _textList[firstTextIndex],
                ),
                speed: 90,
                textDirection: TextDirection.rtl,
                marqueeDirection: MarqueeDirection.ltr,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey,
              child: MarqueeText(
                text: TextSpan(
                  text:addedhastags
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                marqueeDirection: MarqueeDirection.rtl,
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        child: GridView.count(
          crossAxisCount: 5,
          crossAxisSpacing: 2,
          childAspectRatio: 1.2 / 1.18,
          shrinkWrap: true,
          children: [
            Column(children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15)),
                          insetPadding: EdgeInsets.all(90),
                          content: Container(
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 2,
                              shrinkWrap: true,
                              children: [
                                Column(children: [
                                  GestureDetector(
                                    onTap: () {
                                      PageCount.jumpToPage(0);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      child: Center(
                                        child: Image.asset(
                                          "assets/icons/newspaperdxp.png",
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
                                    'News paper',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ]),
                                Column(children: [
                                  GestureDetector(
                                    onTap: () {
                                      PageCount.jumpToPage(1);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      child: Center(
                                        child: Image.asset(
                                          "assets/icons/newsdxps.png",
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
                                    'News Channel',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ]),
                                Column(children: [
                                  GestureDetector(
                                    onTap: () {
                                      PageCount.jumpToPage(2);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      child: Center(
                                          child: Image.asset(
                                        "assets/icons/liveUpdares.png",
                                        height: 30,
                                      )),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                        color: Colors.grey[100],
                                      ),
                                      /*child: Center(
                            child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */
                                    ),
                                  ),
                                  Text(
                                    'Live Updates',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ]),
                                Column(children: [
                                  GestureDetector(
                                    onTap: () {
                                      PageCount.jumpToPage(3);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      child: Center(
                                          child: Image.asset(
                                        "assets/icons/googleTrends.png",
                                        height: 30,
                                      )),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.3,
                                          ),
                                          color: Colors.grey[100]),
                                      /*child: Center(
                            child: Image.asset("assets/Image/TRS-Party-Symbol-CAR1.jpg")
                          ) */
                                    ),
                                  ),
                                  Text(
                                    'Google Trends',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ]),
                              ],
                            ),
                          ));
                    },
                  );
                  /*PageCount.jumpToPage(0);*/
                },
                child: Container(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    "assets/icons/129862-news-unscreen.gif",
                    width: 50,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.3,
                      ),
                      color: Colors.grey[100]),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  /* child: Center(
                          child: Image.asset("assets/Image/TRS-Party-Symbol-CAR1.jpg")
                        ), */
                ),
              ),
              Text(
                'News',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              )
            ]),
            /*Column(children: [
            GestureDetector(
              onTap: () {
                PageCount.jumpToPage(1);
              },
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Image.asset(
                    "assets/icons/newsdxps.png",
                    height: 30,
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.3,
                    ),
                    color: Colors.grey[100]),
                padding: EdgeInsets.all(8),
                */ /*child: Center(
                            child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */ /*
              ),
            ),
            Text(
              'News Channel',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            )
          ]),
          Column(children: [
            GestureDetector(
              onTap: () {
                PageCount.jumpToPage(3);
              },
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                    child: Image.asset(
                  "assets/icons/liveUpdares.png",
                  height: 30,
                )),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 0.3,
                  ),
                  color: Colors.grey[100],
                ),
                */ /*child: Center(
                            child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */ /*
              ),
            ),
            Text(
              'Live Updates',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            )
          ]),*/
            /*Column(children: [
            GestureDetector(
              onTap: () {
                PageCount.jumpToPage(2);
              },
              child: Container(
                height: 60,
                width: 60,
                child: Center(
                    child: Image.asset(
                  "assets/icons/surveydxp.png",
                  height: 30,
                )),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.3,
                    ),
                    color: Colors.grey[100]),
                */ /*child: Center(
                            child: Image.asset("assets/Image/TRS-Party-Symbol-CAR1.jpg")
                          ) */ /*
              ),
            ),
            Text(
              'Survey',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ]),*/
            /*Column(children: [
            GestureDetector(
              onTap: () {
                PageCount.jumpToPage(4);
              },
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                    child: Image.asset(
                  "assets/icons/googleTrends.png",
                  height: 30,
                )),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.3,
                    ),
                    color: Colors.grey[100]),
                */ /*child: Center(
                            child: Image.asset("assets/Image/TRS-Party-Symbol-CAR1.jpg")
                          ) */ /*
              ),
            ),
            Text(
              'Google Trends',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            )
          ]),*/
            /*Column(children: [
            GestureDetector(
              onTap: () {
                PageCount.jumpToPage(5);
              },
              child: Container(
                height: 60,
                width: 60,
                child: Center(
                    child: Image.asset(
                  "assets/icons/statistics.png",
                  height: 30,
                )),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 0.3,
                  ),
                  color: Colors.grey[100],
                ),
                */ /*child: Center(
                            child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */ /*
              ),
            ),
            Text(
              'Score Cards',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ]),*/
            Column(children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15)),
                          insetPadding: EdgeInsets.all(90),
                          content: Container(
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 2,
                              shrinkWrap: true,
                              children: [
                                Column(children: [
                                  GestureDetector(
                                    onTap: () {
                                      PageCount.jumpToPage(4);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      child: Center(
                                        child: Image.asset(
                                          "assets/icons/Social-Media-Icons-IS-10.png",
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
                                    'YouTube',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ]),
                                Column(children: [
                                  GestureDetector(
                                    onTap: () {
                                      PageCount.jumpToPage(5);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      child: Center(
                                        child: Image.asset(
                                          "assets/icons/Social-Media-Icons-IS-06.png",
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
                                    'Facebook',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ]),
                                Column(children: [
                                  GestureDetector(
                                    onTap: () {
                                      PageCount.jumpToPage(6);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      child: Center(
                                          child: Image.asset(
                                        "assets/icons/Social-Media-Icons-IS-08.png",
                                        height: 30,
                                      )),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.3,
                                        ),
                                        color: Colors.grey[100],
                                      ),
                                      /*child: Center(
                            child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                          ) */
                                    ),
                                  ),
                                  Text(
                                    'Twitter',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ]),
                                Column(children: [
                                  GestureDetector(
                                    onTap: () {
                                      PageCount.jumpToPage(7);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      child: Center(
                                          child: Image.asset(
                                        "assets/icons/Social-Media-Icons-IS-07.png",
                                        height: 30,
                                      )),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.3,
                                          ),
                                          color: Colors.grey[100]),
                                      /*child: Center(
                            child: Image.asset("assets/Image/TRS-Party-Symbol-CAR1.jpg")
                          ) */
                                    ),
                                  ),
                                  Text(
                                    'Instagram',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ]),
                              ],
                            ),
                          ));
                    },
                  );
                  /*PageCount.jumpToPage(0);*/
                },
                child: Container(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    "assets/icons/78563-social-media-icons-unscreen.gif",
                    height: 50,
                    width: 50,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.3,
                      ),
                      color: Colors.grey[100]),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  /* child: Center(
                          child: Image.asset("assets/Image/TRS-Party-Symbol-CAR1.jpg")
                        ), */
                ),
              ),
              Text(
                'Social Media',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
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
                      "assets/icons/Candidature Analysis.png",
                      height: 30,
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
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
                      "assets/icons/location.png",
                      height: 30,
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
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
                      borderRadius: BorderRadius.circular(20),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              )
            ]),
          ],
        ),
      ),
      SecondrowVisible == true ? SecondRow() : Container(),
      Flexible(
          child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: PageCount,
              itemCount: DailyNewsPages.length,
              itemBuilder: (BuildContext, index) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    //height: MediaQuery.of(context).size.height,
                    child: DailyNewsPages[index]);
              }))
    ]);
    /* Flexible(
            child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: PageCount,
                itemCount: DailyNewsPages.length,
                itemBuilder: (BuildContext, index) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: DailyNewsPages[index]);
                })),
      ],
    );*/
  }

  NewsPaperAllAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({});
    var response = await post(
      Uri.parse('http://192.169.1.211:8081/api/v1/profile/newspaper'),
      headers: headers,
      body: body,
    );
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      try {
        setState(() =>
            NewsPaperAllResult = jsonDecode(utf8.decode(response.bodyBytes)));
      } catch (e) {
        NewsPaperAllResult = [];
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  NewsChannelAllAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({});
    var response = await post(
      Uri.parse('http://192.169.1.211:8081/api/v1/profile/news'),
      headers: headers,
      body: body,
    );
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      try {
        setState(() =>
            NewsChannelAllResult = jsonDecode(utf8.decode(response.bodyBytes)));
      } catch (e) {
        NewsChannelAllResult = [];
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  LiveUpdateAllAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({});
    var response = await post(
      Uri.parse('http://192.169.1.211:8081/api/v1/profile/livenews'),
      headers: headers,
      body: body,
    );
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      try {
        setState(() =>
            LiveUpdateAllResult = jsonDecode(utf8.decode(response.bodyBytes)));
      } catch (e) {
        LiveUpdateAllResult = [];
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  String addedhastags = '';
  List tags=[];
  NotificationsAPI() async {
    var response = await get(
      Uri.parse(
          'http://192.169.1.211:8081/insights/2.60.0/trendingHashtags?page=0,14&field=TWITTER'),
    );
    //print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      try {
        setState(() => NotificationsAllResult =
            jsonDecode(utf8.decode(response.bodyBytes)));
        for(int i=0;i<NotificationsAllResult.length;i++){
          tags.add(NotificationsAllResult[i]['hashTag']);
        }
        addedhastags=tags.join('    ');
        print(NotificationsAllResult);
      } catch (e) {
        NotificationsAllResult = [];
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  /*
          ),
          Container(
            height: 100,
            child: PageView(
              controller: pagecont,
              children: [
                page1(),
                page2(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('<-------- Swipe for more -------->')],
          ),

          ///gridView
          // Container(
          //         height: 110,
          //         padding: EdgeInsets.all(5),
          //         child: GridView.count(controller: gridcont,
          //
          //             padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          //             crossAxisCount: 8,
          //             childAspectRatio: 1.0,
          //             // mainAxisSpacing: 26.0,
          //             crossAxisSpacing: 20.0,
          //             shrinkWrap: true,
          //             scrollDirection: Axis.horizontal,
          //             // physics: NeverScrollableScrollPhysics(),
          //             children: <Widget>[
          //
          //               // Text(
          //               //   "Google Trends",
          //               //   textAlign: TextAlign.center,
          //               //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          //               // ),
          //               // Text(
          //               //   "Score Cards",
          //               //   textAlign: TextAlign.center,
          //               //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          //               // ),
          //               // Text(
          //               //   "Twitter",
          //               //   textAlign: TextAlign.center,
          //               //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          //               // ),
          //               // Text(
          //               //   "YouTube",
          //               //   textAlign: TextAlign.center,
          //               //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          //               // ),
          //               // Text(
          //               //   "News Paper",
          //               //   textAlign: TextAlign.center,
          //               //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          //               // ),
          //               // Text(
          //               //   "News Channel",
          //               //   textAlign: TextAlign.center,
          //               //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          //               // ),
          //               // Text(
          //               //   "Survey",
          //               //   textAlign: TextAlign.center,
          //               //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          //               // ),
          //               // Text(
          //               //   "Live Updates",
          //               //   textAlign: TextAlign.center,
          //               //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          //               // ),
          //             ]),
          //       ),

          Flexible(
              child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: PageCount,
                  itemCount: NewsPages.length,
                  itemBuilder: (BuildContext, index) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        child: NewsPages[index]);
                  })),

          ///Function call for all newspaper, news channel, live updates, youtube, instagram, twitter.

          */ /*Container(
          //width: 320,
          height: 270,
          //alignment: Alignment.center,
          padding: EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.all(2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.grey[100],
              elevation: 10,
              child: Column(
                //mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.all(5)),
                      Image(
                          height: 30,
                          image: AssetImage(
                            'assets/icons/newspaperdxp.png',
                          )),
                      //ImageIcon(AssetImage('assets/icons/youtubedxps.png')),
                      Text(
                        'News Papers',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Tooltip(
                          message: 'Pin Card',
                          child: CupertinoButton(
                            minSize: double.minPositive,
                            padding: EdgeInsets.zero,
                            child: Icon(Icons.pin_invoke,
                                color: Color.fromRGBO(58, 129, 233, 1),
                                size: 25),
                            onPressed: () {},
                          )),
                      Tooltip(
                          message: 'Refresh',
                          child: CupertinoButton(
                            minSize: double.minPositive,
                            padding: EdgeInsets.zero,
                            child: Icon(Icons.refresh,
                                color: Color.fromRGBO(58, 129, 233, 1),
                                size: 25),
                            onPressed: () {},
                          )),
                      Tooltip(
                          message: 'Card Sort',
                          child: CupertinoButton(
                            minSize: double.minPositive,
                            padding: EdgeInsets.zero,
                            child: Icon(Icons.sort,
                                color: Color.fromRGBO(58, 129, 233, 1),
                                size: 25),
                            onPressed: () {},
                          )),
                      Tooltip(
                          message: 'Calender',
                          child: CupertinoButton(
                            minSize: double.minPositive,
                            padding: EdgeInsets.zero,
                            child: Icon(Icons.calendar_today,
                                color: Color.fromRGBO(58, 129, 233, 1),
                                size: 25),
                            onPressed: () {},
                          )),
                      Tooltip(
                          message: 'Multi-Filter',
                          child: CupertinoButton(
                            minSize: double.minPositive,
                            padding: EdgeInsets.zero,
                            child: Icon(Icons.filter_alt_outlined,
                                color: Color.fromRGBO(58, 129, 233, 1),
                                size: 25),
                            onPressed: () {},
                          )),
                      Tooltip(
                          message: 'More',
                          child: CupertinoButton(
                            minSize: double.minPositive,
                            padding: EdgeInsets.zero,
                            child: Icon(Icons.more_vert,
                                color: Color.fromRGBO(58, 129, 233, 1),
                                size: 25),
                            onPressed: () {},
                          )),
                    ],
                  ),
                  Divider(
                    color: Colors.lightBlueAccent,
                    height: 6,
                    thickness: 1,
                    indent: 2,
                    endIndent: 2,
                  ),
                  ...NewsList(),
                ],
              ),
            ),
          ),
        ),*/ /*
          */ /*...NewsPaperList(),
        ...NewsChannelList(),
        ...LiveUpdateList(),*/ /*
        ]);
  }*/

  List<Card> NewsPaperList() {
    var Top3 = [];
    print(Top3);
    print(NewsPaperAllResult.length);
    if (NewsPaperAllResult.length > 0)
      Top3 = [
        NewsPaperAllResult[0],
        NewsPaperAllResult[1],
        NewsPaperAllResult[2]
      ];
    return [
      Card(
        //width: 320,
        //alignment: Alignment.center,
        //margin: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.grey[100],
        elevation: 10,
        child: Expanded(
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(0)),
                  Image(
                      height: 30,
                      image: AssetImage(
                        'assets/icons/newspaperdxp.png',
                      )),
                  //ImageIcon(AssetImage('assets/icons/youtubedxps.png')),
                  Text(
                    'News Papers',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  // Tooltip(
                  //     message: 'Pin Card',
                  //     child: CupertinoButton(
                  //       minSize: double.minPositive,
                  //       padding: EdgeInsets.zero,
                  //       child: Icon(Icons.pin_invoke,
                  //           color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                  //       onPressed: () {},
                  //     )),
                  // Tooltip(
                  //     message: 'Refresh',
                  //     child: CupertinoButton(
                  //       minSize: double.minPositive,
                  //       padding: EdgeInsets.zero,
                  //       child: Icon(Icons.refresh,
                  //           color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                  //       onPressed: () {},
                  //     )),
                  // Tooltip(
                  //     message: 'Card Sort',
                  //     child: CupertinoButton(
                  //       minSize: double.minPositive,
                  //       padding: EdgeInsets.zero,
                  //       child: Icon(Icons.sort,
                  //           color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                  //       onPressed: () {},
                  //     )),
                  // Tooltip(
                  //     message: 'Calender',
                  //     child: CupertinoButton(
                  //       minSize: double.minPositive,
                  //       padding: EdgeInsets.zero,
                  //       child: Icon(Icons.calendar_today,
                  //           color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                  //       onPressed: () {},
                  //     )),
                  // Tooltip(
                  //     message: 'Multi-Filter',
                  //     child: CupertinoButton(
                  //       minSize: double.minPositive,
                  //       padding: EdgeInsets.zero,
                  //       child: Icon(Icons.filter_alt_outlined,
                  //           color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                  //       onPressed: () {},
                  //     )),
                  // Tooltip(
                  //     message: 'More',
                  //     child: CupertinoButton(
                  //       minSize: double.minPositive,
                  //       padding: EdgeInsets.zero,
                  //       child: Icon(Icons.more_vert,
                  //           color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                  //       onPressed: () {},
                  //     )),
                ],
              ),
              Divider(
                color: Colors.lightBlueAccent,
                height: 6,
                thickness: 1,
                indent: 2,
                endIndent: 2,
              ),
              ...Top3.map<Card>((Value) => Card(
                    margin: EdgeInsets.all(4),
                    //elevation: 20,
                    child: ListTile(
                      minVerticalPadding: 1,
                      subtitle: Text(
                        Value['id']['mediaName'] ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black45),
                      ),
                      leading: Text(
                        Value['id']['headLine'] ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        maxLines: 1,
                      ),
                      trailing: Text(
                        Value['id']['publishedDate'] ?? '',
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () => launchUrl(Uri.parse(Value['sourceUrl'])),
                      /*onTap: (){
          print(Value);
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrsMpDetails(Value)));
        },*/
                    ),
                  ))
            ],
          ),
        ),
      ),
    ];
  }

  List<Card> NewsChannelList() {
    var Top3 = [];
    print(Top3);
    print(NewsChannelAllResult.length);
    if (NewsChannelAllResult.length > 0)
      Top3 = [
        NewsChannelAllResult[0],
        NewsChannelAllResult[1],
        NewsChannelAllResult[2]
      ];
    return [
      Card(
        //width: 320,
        //alignment: Alignment.center,

        margin: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.grey[100],
        elevation: 10,
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Image(
                    height: 30,
                    image: AssetImage(
                      'assets/icons/newsdxps.png',
                    )),
                //ImageIcon(AssetImage('assets/icons/youtubedxps.png')),
                Text(
                  'News Channel',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Tooltip(
                    message: 'Pin Card',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.pin_invoke,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'Refresh',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.refresh,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'Card Sort',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.sort,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'Calender',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.calendar_today,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'Multi-Filter',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.filter_alt_outlined,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'More',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.more_vert,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                      onPressed: () {},
                    )),
              ],
            ),
            Divider(
              color: Colors.lightBlueAccent,
              height: 6,
              thickness: 1,
              indent: 2,
              endIndent: 2,
            ),
            ...Top3.map<Card>((Value) => Card(
                  margin: EdgeInsets.all(4),
                  //elevation: 20,
                  child: ListTile(
                    horizontalTitleGap: 0,
                    //isThreeLine: false,
                    title: Text(
                      Value['mediaChannelName'] ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black45),
                    ),
                    subtitle: Text(
                      Value['videoTitle'] ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      maxLines: 1,
                    ),
                    trailing: Text(
                      Value['publishedDate'] ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () => launchUrl(Uri.parse(Value['sourceUrl'])),
                    /*onTap: (){
          print(Value);
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrsMpDetails(Value)));
        },*/
                  ),
                ))
          ],
        ),
      ),
    ];
  }

  List<Card> LiveUpdateList() {
    var Top3 = [];
    print(Top3);
    print(LiveUpdateAllResult.length);
    if (LiveUpdateAllResult.length > 0)
      Top3 = [
        LiveUpdateAllResult[0],
        LiveUpdateAllResult[1],
        LiveUpdateAllResult[2]
      ];
    return [
      Card(
        //width: 320,
        //alignment: Alignment.center,

        margin: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.grey[100],
        elevation: 10,
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              children: [
                Padding(padding: EdgeInsets.all(5)),
                Icon(Icons.browser_updated_outlined),
                /*Image(
                  height: 30,
                  image: AssetImage(
                    'assets/icons/newsdxps.png',
                  )),*/
                //ImageIcon(AssetImage('assets/icons/youtubedxps.png')),
                Text(
                  'Live Updates',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Tooltip(
                    message: 'Pin Card',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.pin_invoke,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'Refresh',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.refresh,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'Card Sort',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.sort,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'Calender',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.calendar_today,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'Multi-Filter',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.filter_alt_outlined,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'More',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.more_vert,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 25),
                      onPressed: () {},
                    )),
              ],
            ),
            Divider(
              color: Colors.lightBlueAccent,
              height: 6,
              thickness: 1,
              indent: 2,
              endIndent: 2,
            ),
            ...Top3.map<Card>((Value) => Card(
                  margin: EdgeInsets.all(4),
                  //elevation: 20,
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Text(
                          Value['id']['mediaName'] ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                        ),
                        Image.network(
                          (Value['sourceImg']),
                          height: 10,
                        )
                      ],
                    ),

                    /*Text(
                Value['id']['mediaName']?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),*/
                    subtitle: Text(
                      Value['id']['headLine'] ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      maxLines: 1,
                    ),
                    trailing: Text(
                      Value['id']['publishedDate'] ?? '',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () => launchUrl(Uri.parse(Value['sourceUrl'])),
                    /*onTap: (){
          print(Value);
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrsMpDetails(Value)));
        },*/
                  ),
                ))
          ],
        ),
      ),
    ];
  }

  page1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(children: [
          GestureDetector(
            onTap: () {
              PageCount.jumpToPage(4);
            },
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                  child: Image.asset(
                "assets/icons/googleTrends.png",
                height: 30,
              )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100]),
              /*child: Center(
                          child: Image.asset("assets/Image/TRS-Party-Symbol-CAR1.jpg")
                        ) */
            ),
          ),
          Text(
            'Google Trends',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
        Column(children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScoreCardsScreen()));
            },
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                  child: Image.asset(
                "assets/icons/statistics.png",
                height: 30,
              )),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[100],
              ),
              /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                        ) */
            ),
          ),
          Text(
            'Score Cards',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
        Column(children: [
          GestureDetector(
            onTap: () {
              PageCount.jumpToPage(6);
            },
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                child: Image.asset(
                  "assets/icons/Social-Media-Icons-IS-08.png",
                  height: 30,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100]),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),

              /*child: Center(
                        child: Image.asset("assets/Image/TRS-Party-Symbol-CAR1.jpg")
                      ), */
            ),
          ),
          Text(
            'Twitter',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
        Column(children: [
          GestureDetector(
            onTap: () {
              PageCount.jumpToPage(7);
            },
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                child: Image.asset(
                  "assets/icons/Social-Media-Icons-IS-10.png",
                  height: 30,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100]),
              padding: EdgeInsets.all(8),
              /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                        ) */
            ),
          ),
          Text(
            'YouTube',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]),

        /*GestureDetector(onTap:(){
    pagecont.jumpToPage(2);
    print('working');
  },child:Icon(Icons.arrow_forward_ios_rounded))*/
      ],
    );
  }

  page2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(children: [
          GestureDetector(
            onTap: () {
              PageCount.jumpToPage(0);
            },
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                child: Image.asset(
                  "assets/icons/newspaperdxp.png",
                  height: 30,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100]),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              /* child: Center(
                        child: Image.asset("assets/Image/TRS-Party-Symbol-CAR1.jpg")
                      ), */
            ),
          ),
          Text(
            'News Paper',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
        Column(children: [
          GestureDetector(
            onTap: () {
              PageCount.jumpToPage(1);
            },
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                child: Image.asset(
                  "assets/icons/newsdxps.png",
                  height: 30,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100]),
              padding: EdgeInsets.all(8),
              /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                        ) */
            ),
          ),
          Text(
            'News Channel',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
        Column(children: [
          GestureDetector(
            onTap: () {
              PageCount.jumpToPage(2);
            },
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                  child: Image.asset(
                "assets/icons/surveydxp.png",
                height: 30,
              )),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100]),
              /*child: Center(
                          child: Image.asset("assets/Image/TRS-Party-Symbol-CAR1.jpg")
                        ) */
            ),
          ),
          Text(
            'Survey',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
        Column(children: [
          GestureDetector(
            onTap: () {
              PageCount.jumpToPage(3);
            },
            child: Container(
              height: 60,
              width: 60,
              child: Center(
                  child: Image.asset(
                "assets/icons/liveUpdares.png",
                height: 30,
              )),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[100],
              ),
              /*child: Center(
                          child: Image.asset("assets/Image/Government_of_Telangana_Logo.png")
                        ) */
            ),
          ),
          Text(
            'Live Updates',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ]),
      ],
    );
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

  SecondRow() {
    return GridView.count(
      crossAxisCount: 5,
      crossAxisSpacing: 2,
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
                  "assets/icons/communicationChannel.png",
                  height: 30,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
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
                  "assets/icons/surveydxp.png",
                  height: 30,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
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
                  "assets/icons/Form.png",
                  height: 30,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
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
                  "assets/icons/newspaperdxp.png",
                  height: 30,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
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
                  borderRadius: BorderRadius.circular(20),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
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
                  "assets/icons/ScoreCard.png",
                  height: 30,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          )
        ]),
        Column(children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScoreCardsScreen()));
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
                  borderRadius: BorderRadius.circular(20),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
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
                  borderRadius: BorderRadius.circular(20),
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          )
        ]),
      ],
    );
  }
}

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.time});
}

/*UserScreen(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(left: 20),
    height: 300,
    width: double.maxFinite,
    child: TabBarView(
      children: [
        ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (_, i) {
              return GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 200,
                    height: 300,
                    margin: const EdgeInsets.only(
                        right: 10, top: 10, bottom: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage("img/mountain1.jpeg"),
                          fit: BoxFit.fitHeight),
                    ),
                  ));
            }),
        */ /*ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (_, i) {
              return GestureDetector(
                  onTap: () {},
                  child: AnimatedOpacity(
                      opacity: <Widget>[],
                      duration: Duration(milliseconds: 2000),
                      child: Container(
                        width: 200,
                        height: 300,
                        margin: const EdgeInsets.only(
                            right: 10, top: 10, bottom: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage("img/mountain1.jpeg"),
                              fit: BoxFit.fitHeight),
                        ),
                      )));
            }),*/ /*
        Material(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
            ),
            title: Text("Content"),
          ),
        ),
      ],
    ),
  );
}*/
