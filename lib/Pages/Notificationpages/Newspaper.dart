import 'package:flutter/material.dart';
import 'package:intellensense/Pages/Notificationpages/Twitter.dart';

class Newspaper extends StatefulWidget {
  const Newspaper({super.key});

  @override
  State<Newspaper> createState() => _NewspaperState();
}

class _NewspaperState extends State<Newspaper> {
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
          NewspaperNotificationtile('YuvaGalam'),
          SizedBox(
            height: 5,
          ),
          NewspaperNotificationtile('YuvaGalamPadayatra'),
          SizedBox(
            height: 5,
          ),
          NewspaperNotificationtile('LokeshPadayatra'),
          SizedBox(
            height: 5,
          ),
          NewspaperNotificationtile('YuvaGalamPadayatra Day-1'),
          SizedBox(
            height: 5,
          ),
          //==================================
          NewspaperNotificationtile('YuvaGalamPadayatra Day-2'),
          SizedBox(
            height: 5,
          ),
          NewspaperNotificationtile('YuvaGalamPadayatra Day-3'),
          SizedBox(
            height: 5,
          ),
          NewspaperNotificationtile('YuvaGalamPadayatra Day-4'),
          SizedBox(
            height: 5,
          ),
          NewspaperNotificationtile('YuvaGalamPadayatra Day-5'),
          SizedBox(
            height: 5,
          ),
        ]),
      ),
    );
  }
}

class NewspaperNotificationtile extends StatefulWidget {
  String Hashtag;
  NewspaperNotificationtile(
    @required this.Hashtag, {
    super.key,
  });

  @override
  State<NewspaperNotificationtile> createState() =>
      _NewspaperNotificationtileState();
}

class _NewspaperNotificationtileState extends State<NewspaperNotificationtile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.grey.shade200,
      backgroundColor: Colors.grey.shade100,
      childrenPadding: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      leading: Image.asset(
        'assets/icons/newspaperdxp.png',
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
