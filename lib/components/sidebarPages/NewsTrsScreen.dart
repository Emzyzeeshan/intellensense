import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsTrsScreen extends StatefulWidget {
  NewsTrsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new NewsTrsScreenState();
  }
}

class NewsTrsScreenState extends State<NewsTrsScreen>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    new Tab(text: "Featured"),
    new Tab(text: "Popular"),
    new Tab(text: "Latest")
  ];

  TabController? _tabController;
  var NewsPaperAllResult = [];
  var YoutubeListResult = [];

  @override
  void initState() {
    super.initState();
    YoutubeListAPI();
    _tabController = new TabController(vsync: this, length: 3);
    //NewsPaperAllAPI();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(58, 129, 233, 1),
        title: Text(''),
        bottom: new TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: new BubbleTabIndicator(
            indicatorHeight: 40.0,
            indicatorColor: Colors.blueAccent,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
            // Other flags
            // indicatorRadius: 1,
            //insets: EdgeInsets.all(1),
            //padding: EdgeInsets.all(10)
          ),
          tabs: <Widget>[
            Tab(
              text: "News Paper",
            ),
            Tab(
              text: "News Channel",
            ),
            Tab(
              text: "Youtube",
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: /*ListView(
        children: NewsPaperData(),
            ...NewsChannel(context)

      ),*/

          new TabBarView(controller: _tabController, children: [
        NewsPaper(),
        NewsChannel(),
        Youtube(),
        /* ListView(
          children: [
            NewsPaperData(),
          ],
        )*/
      ]),
    );
  }

  NewsPaperAllAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({});
    var response = await post(
      Uri.parse('http://192.169.1.211:8081/search/newsPaperAnalysisAll'),
      headers: headers,
      body: body,
    );
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      try {
        setState(() => NewsPaperAllResult = jsonDecode(response.body));
      } catch (e) {
        NewsPaperAllResult = [];
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  YoutubeListAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({});
    var response = await post(
      Uri.parse(
          'http://192.169.1.211:8081/api/v1/profile/youtube'),
      headers: headers,
      body: body,
    );
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      try {
        setState(() =>
            YoutubeListResult = jsonDecode(utf8.decode(response.bodyBytes)));
      } catch (e) {
        print(YoutubeListResult);
        YoutubeListResult = [];
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  final Uri _url = Uri.parse('');
  List<Card> YoutubeList() {
    if (YoutubeListResult.length == 0) return [];
    return YoutubeListResult.map<Card>((Value) => Card(
          margin: EdgeInsets.all(4),
          elevation: 20,
          child: ListTile(

            /*leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          child: ClipOval(
            child: Image.memory(
              base64Decode(Value['content'].substring(22) ?? ''),
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
          ),
        ),*/
            title: Text(
              Value['candidateName'] ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              children: [
                Text(
                  Value['videoTitle'] ?? '',
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/icons/Video ViewsEmoji.png',height: 20,width: 20,),
                        SizedBox(width: 10,),
                        //IconButton(onPressed: () {}, icon: ImageIcon(AssetImage('assets/icons/Video ViewsEmoji.png')),),
                        Text(Value['videoViews'] ?? '',style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    SizedBox(width: 10,),
                    Row(
                      children: [
                        Image.asset('assets/icons/Video LikesEmoji.png',height: 20,width: 20,),
                        SizedBox(width: 10,),
                        //IconButton(onPressed: () {}, icon: ImageIcon(AssetImage('assets/icons/Video LikesEmoji.png')),),
                        Text(Value['videoLikes'] ?? '',style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    SizedBox(width: 10,),
                    Row(
                      children: [
                        Image.asset('assets/icons/Video DislikesEmoji.png',height: 20,width: 20,),
                        SizedBox(width: 10,),
                        //IconButton(onPressed: () {}, icon: ImageIcon(AssetImage('assets/icons/Video DislikesEmoji.png')),),
                        Text(Value['videoDislikes'] ?? '',style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    SizedBox(width: 10,),
                    Row(
                      children: [
                        Image.asset('assets/icons/Video CommentsEmoji.png',height: 20,width: 20,),
                        SizedBox(width: 10,),
                        //IconButton(onPressed: () {}, icon: ImageIcon(AssetImage('assets/icons/Video CommentsEmoji.png')),),
                        Text(Value['videoCommentsCount'] ?? '',style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    SizedBox(width: 10,),
                    //IconButton(onPressed: (){}, icon: Icon(Icons.comment))
                    /*IconButton(onPressed: (){}, icon: Icon(Icons.comment)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.comment)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.comment)),*/
                  ],
                )
              ],
            ),
            trailing: Text(
              Value['publishedDate'] ?? '',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () => launchUrl(Uri.parse(Value['sourceUrl'])),
            /*onTap: (){
          print(Value);
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrsMpDetails(Value)));
        },*/
          ),
        )).toList();
  }
  List<Card> NewsPaperList() {
    if (YoutubeListResult.length == 0) return [];
    return YoutubeListResult.map<Card>((Value) => Card(
      margin: EdgeInsets.all(4),
      elevation: 20,
      child: ListTile(

        /*leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          child: ClipOval(
            child: Image.memory(
              base64Decode(Value['content'].substring(22) ?? ''),
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
          ),
        ),*/
        title: Text(
          Value['candidateName'] ?? '',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          children: [
            Text(
              Value['videoTitle'] ?? '',
              maxLines: 3,
            ),
            /*Row(
              children: [
                Row(
                  children: [
                    Image.asset('assets/icons/Video ViewsEmoji.png',height: 20,width: 20,),
                    SizedBox(width: 10,),
                    //IconButton(onPressed: () {}, icon: ImageIcon(AssetImage('assets/icons/Video ViewsEmoji.png')),),
                    Text(Value['videoViews'] ?? '',style: TextStyle(fontSize: 14),)
                  ],
                ),
                SizedBox(width: 10,),
                Row(
                  children: [
                    Image.asset('assets/icons/Video LikesEmoji.png',height: 20,width: 20,),
                    SizedBox(width: 10,),
                    //IconButton(onPressed: () {}, icon: ImageIcon(AssetImage('assets/icons/Video LikesEmoji.png')),),
                    Text(Value['videoLikes'] ?? '',style: TextStyle(fontSize: 14),)
                  ],
                ),
                SizedBox(width: 10,),
                Row(
                  children: [
                    Image.asset('assets/icons/Video DislikesEmoji.png',height: 20,width: 20,),
                    SizedBox(width: 10,),
                    //IconButton(onPressed: () {}, icon: ImageIcon(AssetImage('assets/icons/Video DislikesEmoji.png')),),
                    Text(Value['videoDislikes'] ?? '',style: TextStyle(fontSize: 14),)
                  ],
                ),
                SizedBox(width: 10,),
                Row(
                  children: [
                    Image.asset('assets/icons/Video CommentsEmoji.png',height: 20,width: 20,),
                    SizedBox(width: 10,),
                    //IconButton(onPressed: () {}, icon: ImageIcon(AssetImage('assets/icons/Video CommentsEmoji.png')),),
                    Text(Value['videoCommentsCount'] ?? '',style: TextStyle(fontSize: 14),)
                  ],
                ),
                SizedBox(width: 10,),
                //IconButton(onPressed: (){}, icon: Icon(Icons.comment))
                */
          ],
        ),
        trailing: Text(
          Value['publishedDate'] ?? '',
          style: TextStyle(fontSize: 16),
        ),
        onTap: () => launchUrl(Uri.parse(Value['sourceUrl'])),
        /*onTap: (){
          print(Value);
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrsMpDetails(Value)));
        },*/
      ),
    )).toList();
  }

  Future<void> _youTubeUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
  List<Card> NewsPaperData() {
    if (NewsPaperAllResult.length == 0) return [];
    return NewsPaperAllResult.map<Card>((Value) => Card(
          margin: EdgeInsets.all(12),
          elevation: 20,
          child: ListTile(
            /*leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          child: ClipOval(
            child: Image.memory(
              base64Decode(Value['content']),
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
        ),*/
            title: Text(
              Value['newsTitle'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(Value['candidateName']),
            trailing: Text(
              Value['publishedDate'],
              style: TextStyle(fontSize: 16),
            ),
            /*onTap: (){
          print(Value);
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrsMpDetails(Value)));
        },*/
          ),
        )).toList();
  }

  NewsPaper() {
    return ListView(children: <Widget>[
      Container(
        height: 50,
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.blue,
            ),
            Icon(
              Icons.newspaper,
              size: 40,
            ),
            Text(
              'News Paper',
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            Tooltip(
                message: 'Pin Card',
                child: CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.pin_invoke,
                      color: Color.fromRGBO(58, 129, 233, 1), size: 30),
                  onPressed: () {},
                )),
            Tooltip(
                message: 'Refresh',
                child: CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.refresh,
                      color: Color.fromRGBO(58, 129, 233, 1), size: 30),
                  onPressed: () {},
                )),
            Tooltip(
                message: 'Card Sort',
                child: CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.sort,
                      color: Color.fromRGBO(58, 129, 233, 1), size: 30),
                  onPressed: () {},
                )),
            Tooltip(
                message: 'Calender',
                child: CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.calendar_today,
                      color: Color.fromRGBO(58, 129, 233, 1), size: 30),
                  onPressed: () {},
                )),
            Tooltip(
                message: 'Multi-Filter',
                child: CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.filter_alt_outlined,
                      color: Color.fromRGBO(58, 129, 233, 1), size: 30),
                  onPressed: () {},
                )),
            Tooltip(
                message: 'More',
                child: CupertinoButton(
                  minSize: double.minPositive,
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.more_vert,
                      color: Color.fromRGBO(58, 129, 233, 1), size: 30),
                  onPressed: () {},
                )),
          ],
        ),
      ),
      ...NewsPaperList()
    ]);
  }

  Youtube() {
    return Container(
      child: ListView(
        children: [
          Container(
            height: 50,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.blue,
                ),
                Image(image: AssetImage('assets/icons/youtubedxps.png',)),
                //ImageIcon(AssetImage('assets/icons/youtubedxps.png')),
                Text(
                  'YouTube',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Tooltip(
                    message: 'Pin Card',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.pin_invoke,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 30),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'Refresh',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.refresh,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 30),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'Card Sort',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.sort,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 30),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'Calender',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.calendar_today,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 30),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'Multi-Filter',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.filter_alt_outlined,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 30),
                      onPressed: () {},
                    )),
                Tooltip(
                    message: 'More',
                    child: CupertinoButton(
                      minSize: double.minPositive,
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.more_vert,
                          color: Color.fromRGBO(58, 129, 233, 1), size: 30),
                      onPressed: () {},
                    )),
              ],
            ),
          ),
          ...YoutubeList()],
      ),
    );
  }
}


NewsListData() {}

NewsChannel() {
  return Container(
    child: Text('hello'),
  );
}

/*NewsPaperAllAPI() async {
  var headers = {'Content-Type': 'application/json'};
  var body = json.encode({});
  var response = await post(
    Uri.parse('http://192.169.1.173:8086/search/newsPaperAnalysisAll'),
    headers: headers,
    body: body,
  );
  print(response.toString());
  if (response.statusCode == 200) {
    print(response.body);
    try {
      setState(() => NewsPaperAllResult = jsonDecode(response.body));
    } catch (e) {
      NewsPaperAllResult = [];
    }
  } else {
    print(response.reasonPhrase);
  }
}*/
