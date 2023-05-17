import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intellensense/Pages/Notificationpages/Twitter.dart';
import 'package:intellensense/main.dart';

import '../../main.dart';

class Newspaper extends StatefulWidget {
  const Newspaper({super.key});

  @override
  State<Newspaper> createState() => _NewspaperState();
}

class _NewspaperState extends State<Newspaper> {
  late Future<dynamic> finaldata = NewspaperApi();
  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
            TextField(
              onChanged: onSearchTextChanged,
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
          searchData.length ==
                0 // Check SearchData list is empty or not if empty then show full data else show search data
            ? FutureBuilder<dynamic>(
            future: finaldata,
            builder: (
              BuildContext context,
              AsyncSnapshot<dynamic> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator()),
                      Text('Please Wait')
                    ]);
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Flexible(
                    child: ListView.builder(
                      itemCount: Newspaperdata.length,
                      itemBuilder: (context, index) {
                        return NewspaperNotificationtile(
                            '${Newspaperdata[index]['id']['tagName']}');
                      },
                    ),
                  );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ) : Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: searchData.length,
                  itemBuilder: (context, index) {
                    return NewspaperNotificationtile(
                        '${searchData[index]['id']['tagName']}');
                  },
                ),
              ),
        ],
      );
    
  }

  var Newspaperdata;
  Future<dynamic> NewspaperApi() async {
    // await Future.delayed(Duration(seconds: 1));
    var headers = {'Content-Type': 'application/json'};

    var response = await get(

      Uri.parse(
          INSIGHTS+'/ytnpTrendingHashTags?page=0,13&field=NEWS PAPER'),


    );

    if (response.statusCode == 200) {
      setState(() {
        Newspaperdata = jsonDecode(response.body);
      });
fullData=Newspaperdata;
      print(Newspaperdata);
    } else {
      print(response.reasonPhrase);
    }
    return Newspaperdata;
  }

   List searchData = [];
  List fullData = [];
  onSearchTextChanged(String text) async {
    searchData.clear();
    if (text.isEmpty) {
      // Check textfield is empty or not
      setState(() {});
      return;
    }

    fullData.forEach((data) {
      if (data['id']['tagName']
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase().toString())) {
        searchData.add(
            data); // If not empty then add search data into search data list
      }
    });
    print(searchData.length);
    setState(() {});
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
