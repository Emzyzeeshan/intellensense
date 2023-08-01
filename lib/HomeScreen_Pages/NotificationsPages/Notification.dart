import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:intellensense/HomeScreen_Pages/NotificationsPages/BottomNavigation_Notification/Facebook.dart';
import 'package:intellensense/HomeScreen_Pages/NotificationsPages/BottomNavigation_Notification/Instagram.dart';

import 'BottomNavigation_Notification/NewsChannel.dart';
import 'BottomNavigation_Notification/Newspaper.dart';
import 'BottomNavigation_Notification/Twitter.dart';
import 'BottomNavigation_Notification/Youtube.dart';

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  PageController _pageController = PageController();
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 40,
        centerTitle: true,

        backgroundColor: Color(0xff86a8e7),
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
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color(0xff86a8e7),
        selectedIndex: _selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),
        items: [
          BottomNavyBarItem(
              icon: Image.asset(
                'assets/icons/Social-Media-Icons-IS-10.png',
                height: 25,
              ),
              title: Text('YouTube'),
              activeColor: Colors.blueAccent.shade700),
          BottomNavyBarItem(
              icon: Image.asset(
                'assets/icons/Social-Media-Icons-IS-06.png',
                height: 25,
              ),
              title: Text('FaceBook'),
              activeColor: Colors.blue
              //backgroundColor: Colors.blue
              ),
          BottomNavyBarItem(
              icon: Image.asset(
                'assets/new Updated images/intellisensesolutions-Icons-83.png',
                height: 25,
              ),
              title: Text('Newspaper'),
              activeColor: Colors.blue
              //backgroundColor: Colors.blue
              ),
          BottomNavyBarItem(
            icon: Image.asset(
              'assets/icons/Social-Media-Icons-IS-08.png',
              height: 25,
            ),
            title: Text('Twitter'),
            activeColor: Colors.blue,
            //backgroundColor: Colors.blue,
          ),
          BottomNavyBarItem(
            icon: Image.asset(
              'assets/new Updated images/news-71.png',
              height: 25,
            ),
            title: Text('NewsChannel'),
            activeColor: Colors.blue,
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
                //Instagram(),
                Newspaper(),
                Twitter(),
                NewsChannelPage(),
              ]),
        ),
      ]),
    );
  }
}
