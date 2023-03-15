import 'package:flutter/material.dart';
import 'package:intellensense/Pages/Notificationpages/Twitter.dart';

class Youtube extends StatefulWidget {
  const Youtube({super.key});

  @override
  State<Youtube> createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(shrinkWrap: true, children: [
          TextField(
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                isDense: true,
                fillColor: Colors.blue.shade100,
                filled: true,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                prefixIcon: Container(
                  padding: EdgeInsets.all(15),
                  child: Icon(Icons.search_rounded),
                  width: 18,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          YoutubeNotificationtile('YuvaGalam'),
          SizedBox(
            height: 5,
          ),
          YoutubeNotificationtile('YuvaGalamPadayatra'),
          SizedBox(
            height: 5,
          ),
          YoutubeNotificationtile('LokeshPadayatra'),
          SizedBox(
            height: 5,
          ),
          YoutubeNotificationtile('YuvaGalamPadayatra Day-1'),
          SizedBox(
            height: 5,
          ),
          //==================================
          YoutubeNotificationtile('YuvaGalamPadayatra Day-2'),
          SizedBox(
            height: 5,
          ),
          YoutubeNotificationtile('YuvaGalamPadayatra Day-3'),
          SizedBox(
            height: 5,
          ),
          YoutubeNotificationtile('YuvaGalamPadayatra Day-4'),
          SizedBox(
            height: 5,
          ),
          YoutubeNotificationtile('YuvaGalamPadayatra Day-5'),
          SizedBox(
            height: 5,
          ),
        ]),
      ),
    );
  }
}

class YoutubeNotificationtile extends StatefulWidget {
  String Hashtag;
  YoutubeNotificationtile(
    @required this.Hashtag, {
    super.key,
  });

  @override
  State<YoutubeNotificationtile> createState() =>
      _YoutubeNotificationtileState();
}

class _YoutubeNotificationtileState extends State<YoutubeNotificationtile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.grey.shade200,
      backgroundColor: Colors.grey.shade100,
      childrenPadding: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      leading: Image.asset(
        'assets/icons/Social-Media-Icons-IS-10.png',
        height: 25,
        width: 25,
      ),
      title: Text(widget.Hashtag),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/NotificationIcons/analyticsShowCard.png',
              height: 25,
              width: 25,
            ),
            Image.asset(
              'assets/NotificationIcons/GridDB.png',
              height: 25,
              width: 25,
            ),
            Image.asset(
              'assets/NotificationIcons/Open_Docs_Icon.png',
              height: 25,
              width: 25,
            ),
            Image.asset(
              'assets/NotificationIcons/Pivot-Unpivot_Icon.png',
              height: 25,
              width: 25,
            ),
            Image.asset(
              'assets/NotificationIcons/Tree.png',
              height: 25,
              width: 25,
            ),
          ],
        )
      ],
    );
  }
}
