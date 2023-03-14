import 'package:flutter/material.dart';

import 'TRS Screens/KCRTrsScreen.dart';
import 'components/sidebarPages/HistoryTrsScreen.dart';


class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: _tabController,
        children: [
          HistoryList(),
          TimeLineList(),
          LeaderShipList(context),
        ],
      ),
    );
  }
}