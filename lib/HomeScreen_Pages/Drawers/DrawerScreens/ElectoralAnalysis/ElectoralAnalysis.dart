import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intellensense/Constants/constants.dart';

import 'Census.dart';
import 'Political.dart';

class ElectoralAnalysis extends StatefulWidget {

  @override
  State<ElectoralAnalysis> createState() => _ElectoralAnalysisState();
}

class _ElectoralAnalysisState extends State<ElectoralAnalysis> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: HomeColor,
      key: _key,
      appBar: AppBar(elevation: 0,
        leading: Row(
          children: [
            IconButton(
              color: Colors.grey.shade700,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            color: Colors.grey.shade700,
            icon: Icon(Icons.bar_chart),
            onPressed: () {
              _key.currentState!.openDrawer();
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: HomeColor,
        title: Image.asset(
          'assets/icons/IntelliSense-Logo-Finall.gif',
          fit: BoxFit.cover,
          height: 40,
        ),
      ),
      drawer: Drawer(
          backgroundColor: Color(0xffd2dfff),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Image.asset(
                'assets/icons/IntelliSense-Logo-Finall.gif',
                fit: BoxFit.cover,
                height: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 7,
                right: 7,
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {
                        _pageController.jumpToPage(0);
                      });
                    },
                    leading: Image.asset(
                      'assets/icons/Political.png',
                      height: 30,
                      width: 30,
                    ),
                    title: Text(
                      'Political',
                      style: GoogleFonts.nunitoSans(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    tileColor: Colors.white,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        _pageController.jumpToPage(1);
                      });
                    },
                    leading: Image.asset(
                      'assets/icons/census.png',
                      height: 30,
                      width: 30,
                    ),
                    title: Text(
                      'Census',
                      style: GoogleFonts.nunitoSans(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    
                    tileColor: Colors.white,
                  ),
                ],
              ),
            ),
          ])),
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          allowImplicitScrolling: false,
          controller: _pageController,
          children: [
            Political(),
            Census(),
          ]),
    );
  }
}
