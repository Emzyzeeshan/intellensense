import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:intellensense/Pages/Notificationpages/Facebook.dart';
import 'package:intellensense/Pages/Notificationpages/Instagram.dart';
import 'package:intellensense/Pages/Notificationpages/Twitter.dart';
import 'package:intellensense/Pages/Notificationpages/Youtube.dart';

import 'Notificationpages/Newspaper.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  PageController _pageController = PageController();
  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.blue.shade100,
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
              activeColor: Colors.blue),
          BottomNavyBarItem(
              icon: Image.asset(
                'assets/icons/fb.png',
                height: 25,
              ),
              title: Text('FaceBook'),
              activeColor: Colors.blue),
          BottomNavyBarItem(
              icon: Image.asset(
                'assets/icons/Social-Media-Icons-IS-07.png',
                height: 25,
              ),
              title: Text('Instagram'),
              activeColor: Colors.blue),
          BottomNavyBarItem(
              icon: Image.asset(
                'assets/icons/newspaperdxp.png',
                height: 25,
              ),
              title: Text('Newspaper'),
              activeColor: Colors.blue),
          BottomNavyBarItem(
            icon: Image.asset(
              'assets/icons/Social-Media-Icons-IS-08.png',
              height: 25,
            ),
            title: Text('Twitter'),
            activeColor: Colors.blue,
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
              ]),
        ),
      ]),
    );
  }
}
