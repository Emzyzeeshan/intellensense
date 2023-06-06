import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:intellensense/Pages/Notificationpages/Facebook.dart';
import 'package:intellensense/Pages/Notificationpages/Instagram.dart';
import 'package:intellensense/Pages/Notificationpages/Twitter.dart';
import 'package:intellensense/Pages/Notificationpages/Youtube.dart';

import '../components/sidebarPages/NewsTrsScreen.dart';
import 'DrawerScreens/CandidatureAnalysis/newschannel emotion/NewsChannelSentiment.dart';
import 'Notificationpages/NewsChannel.dart';
import 'Notificationpages/Newspaper.dart';

class Notifications extends StatefulWidget {

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  PageController _pageController = PageController();
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return
    
     Scaffold(
      backgroundColor: Color(0xffd2dfff),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 40,
        centerTitle: true,
        backgroundColor: Color(0xffd2dfff),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Image.asset(
          'assets/icons/IntelliSense-Logo-Finall_01022023_A.gif',
          height: 50,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(selectedItemColor: Colors.black,
       // backgroundColor: Color(0xffd2dfff),
        currentIndex: _selectedIndex,
        //showElevation: true, // use this to remove appBar's elevation
        onTap: (index) => setState(() {
          _selectedIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/Social-Media-Icons-IS-10.png',
                height: 25,
              ),
              label: 'YouTube',
              backgroundColor: Color(0xffd2dfff)
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/fb.png',
                height: 25,
              ),
              label: 'FaceBook',
              backgroundColor: Color(0xffd2dfff)
              //backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/Social-Media-Icons-IS-07.png',
                height: 25,
              ),
              label: 'Instagram',
              backgroundColor: Color(0xffd2dfff)
              //backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/new Updated images/intellisensesolutions-Icons-83.png',
                height: 25,
              ),
              label: 'Newspaper',
              backgroundColor: Color(0xffd2dfff)
              //backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/Social-Media-Icons-IS-08.png',
              height: 25,
            ),
            label: 'Twitter',
              backgroundColor: Color(0xffd2dfff)
            //backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/new Updated images/news-71.png',
              height: 25,
            ),
            label: 'NewsChannel',
              backgroundColor: Color(0xffd2dfff)
            //backgroundColor: Colors.blue,
          ),
        ],
      ),
      body: Column(children: [
        Flexible(
          child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Youtube(),
                Facebook(),
                Instagram(),
                Newspaper(),
                Twitter(),
                NewsChannelPage(),
              ]),
        ),
      ]),
    );
  }
}
