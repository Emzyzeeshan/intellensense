import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Material Master Governance Suite'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_sharp),
          ),
          backgroundColor: Color.fromRGBO(11, 74, 153, 1),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Column(
              children: <Widget>[
                Card(
                  semanticContainer: true,
                  elevation: 10,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            AssetImage('assets/images/MDRM-02.png'),
                        radius: 25),
                    title: Text('Smart Search'),
                    subtitle: Text('Search and find Master Data Record'),
                    trailing: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.search),
                          Icon(Icons.info_outline_rounded),
                          Icon(Icons.play_circle_outline),
                        ],
                      ),
                    ),
                    onTap: () {
                      print('Smart Search');
                    },
                  ),
                ),
                Card(
                  semanticContainer: true,
                  elevation: 10,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            AssetImage('assets/images/MDRM-02.png'),
                        radius: 25),
                    title: Text('ADD Image'),
                    subtitle: Text('Add Image in Records'),
                    trailing: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.search),
                          Icon(Icons.info_outline_rounded),
                          Icon(Icons.play_circle_outline),
                        ],
                      ),
                    ),
                    onTap: () {
                      print('ADD Image');
                    },
                  ),
                ),
                Card(
                  semanticContainer: true,
                  elevation: 10,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            AssetImage('assets/images/MDRM-02.png'),
                        radius: 25),
                    title: Text('Change Request'),
                    subtitle:
                        Text('Request a change to existing Master Data Record'),
                    trailing: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.search),
                          Icon(Icons.info_outline_rounded),
                          Icon(Icons.play_circle_outline),
                        ],
                      ),
                    ),
                    onTap: () {
                      print('Change Request');
                    },
                  ),
                ),
              ],
            );
          },
        ));
  }
}
