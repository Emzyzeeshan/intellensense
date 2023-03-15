import 'package:flutter/material.dart';

class Twitter extends StatefulWidget {
  const Twitter({super.key});

  @override
  State<Twitter> createState() => _TwitterState();
}

class _TwitterState extends State<Twitter> {
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
          TwittterNotificationtile('#YuvaGalamPadayatra'),
          SizedBox(
            height: 5,
          ),
          TwittterNotificationtile('#YuvaGalam'),
          SizedBox(
            height: 5,
          ),
          TwittterNotificationtile('#LokeshPadayatra'),
          SizedBox(
            height: 5,
          ),
          TwittterNotificationtile('#PsychoPovaliCycleRavali'),
          SizedBox(
            height: 5,
          ),
          //==================================
          TwittterNotificationtile('#JaganPovaliBabuRavali'),
          SizedBox(
            height: 5,
          ),
          TwittterNotificationtile('#PawanKalyan'),
          SizedBox(
            height: 5,
          ),
          TwittterNotificationtile('@ncbn'),
          SizedBox(
            height: 5,
          ),
          TwittterNotificationtile('#JaganFailedCM'),
          SizedBox(
            height: 5,
          ),
        ]),
      ),
    );
  }
}

class TwittterNotificationtile extends StatefulWidget {
  String Hashtag;
  TwittterNotificationtile(
    @required this.Hashtag, {
    super.key,
  });

  @override
  State<TwittterNotificationtile> createState() =>
      _TwittterNotificationtileState();
}

class _TwittterNotificationtileState extends State<TwittterNotificationtile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.grey.shade200,
      backgroundColor: Colors.grey.shade100,
      childrenPadding: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      leading: Image.asset(
        'assets/icons/Social-Media-Icons-IS-08.png',
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
