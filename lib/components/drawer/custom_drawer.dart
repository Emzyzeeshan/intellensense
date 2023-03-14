
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


import '../sidebarPages/FeedBackFormScreen.dart';
import '../sidebarPages/HistoryTrsScreen.dart';
import '../sidebarPages/SettingScreen.dart';
import 'custom_list_tile.dart';
import 'header.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isCollapsed = false;
  final Uri _url = Uri.parse('https://services.india.gov.in/service/detail/telangana-prajavani-service-centralized-public-grievance-redress-and-monitoring-system');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 500),
        width: _isCollapsed ? 280 : 80,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.blueAccent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDrawerHeader(isColapsed: _isCollapsed),
              const Divider(
                color: Colors.grey,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                //icon: Icons.chat_outlined,
                title: 'Chat',
                infoCount: 0, image: Image.asset('assets/icons/Chat-Icon-3D-01.png'),
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                //icon: Icons.topic_outlined,
                title: 'News',
                image: Image.asset('assets/icons/News-Icon-3D-01.png'),
                infoCount: 0,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                //icon: Icons.all_inbox_outlined,
                title: 'Message & Vision, Tweets',
                image: Image.asset('assets/icons/Message&Vision-Icon-3D-01.png'),
                infoCount: 0,
                //doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                image: Image.asset('assets/icons/Manifesto-Icon-3D-01.png'),
                //icon: Icons.file_copy_outlined,
                title: 'Manifesto',
                infoCount: 0,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                //icon: Icons.history_edu_outlined,
                title: 'History of TRS',
                image: Image.asset('assets/icons/Chat-Icon-3D-01.png'),
                infoCount: 0,
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HistoryTrsScreen()));
                },
                //doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                //icon: Icons.miscellaneous_services_outlined,
                title: 'Service Portal',
                image: Image.asset('assets/icons/Chat-Icon-3D-01.png'),
                infoCount: 0,
                doHaveMoreOptions: Icons.launch,
                onTap: () => launch(_url.toString()),
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                //icon: Icons.event_available_outlined,
                title: 'Events & Gallery',
                image: Image.asset('assets/icons/Chat-Icon-3D-01.png'),
                infoCount: 0,
                //doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              const Divider(color: Colors.grey),
              //const Spacer(),
              CustomListTile(
                isCollapsed: _isCollapsed,
                image: Image.asset('assets/icons/Chat-Icon-3D-01.png'),
                //icon: Icons.card_membership_outlined,
                title: 'Become a Member',
                infoCount: 0,
              ),
              CustomListTile(
                image: Image.asset('assets/icons/Chat-Icon-3D-01.png'),
                isCollapsed: _isCollapsed,
                //icon: Icons.feedback_outlined,
                title: 'Feedback',
                infoCount: 0,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedBackFormScreen()));
                },
              ),
              const SizedBox(height: 10),
              //BottomUserInfo(isCollapsed: _isCollapsed),
              Align(
                alignment: _isCollapsed
                    ? Alignment.bottomRight
                    : Alignment.bottomCenter,
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(
                    _isCollapsed
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      _isCollapsed = !_isCollapsed;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
