import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intellensense/main.dart';


class Instagram extends StatefulWidget {

  @override
  State<Instagram> createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {
  late Future<dynamic> finaldata = InstagramApi();
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
                  SizedBox(height: 10,),
       searchData.length==0? FutureBuilder<dynamic>(
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
                      itemCount: Instagramdata.length,
                      itemBuilder: (context, index) {
                        return InstagramNotificationtile(
                            '${Instagramdata[index]['hashTag']}');
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
                    return InstagramNotificationtile(
                        '${searchData[index]['hashTag']}');
                  },
                ),
              ),
      ],
    );
    
  }

  var Instagramdata;
  Future<dynamic> InstagramApi() async {
    // await Future.delayed(Duration(seconds: 1));
    var headers = {'Content-Type': 'application/json'};

    var response = await get(

      Uri.parse(
          INSIGHTS+'/trendingHashtags?page=0,14&field=INSTAGRAM'),
    );

    if (response.statusCode == 200) {
      setState(() {
        Instagramdata = jsonDecode(response.body);
      });
fullData=Instagramdata;
      print(Instagramdata);
    } else {
      print(response.reasonPhrase);
    }
    return Instagramdata;
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
      if (data['hashTag']
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

class InstagramNotificationtile extends StatefulWidget {
  String Hashtag;
  InstagramNotificationtile(
    @required this.Hashtag, );

  @override
  State<InstagramNotificationtile> createState() =>
      _InstagramNotificationtileState();
}

class _InstagramNotificationtileState extends State<InstagramNotificationtile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ExpansionTile(
        collapsedBackgroundColor:  Color(0xffc8d1e7),
        backgroundColor: Color(0xffc8d1e7),
        childrenPadding: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        leading: Image.asset(
          'assets/icons/Social-Media-Icons-IS-07.png',
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
      ),
    );
  }
}
