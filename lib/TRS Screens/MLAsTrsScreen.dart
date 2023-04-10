import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import 'TrsMpDetails.dart';

class MLAsTrsScreen extends StatefulWidget {
  @override
  State<MLAsTrsScreen> createState() => _MLAsTrsScreenState();
}

/*partyList()async{
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = Request('POST', Uri.parse('http://192.169.1.211:8083/api/v1/profile/party/TRS'));
  request.body = json.encode({});
  request.headers.addAll(headers);

  StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(response);
  }
  else {
    print(response.reasonPhrase);
  }

}*/
class _MLAsTrsScreenState extends State<MLAsTrsScreen> {
  //final Debouncer _debouncer = Debouncer();

  List ulist = [];
  List userLists = [];
  var partyListAPIResult = [];
  TextEditingController editingController = TextEditingController();
  //final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  var items = [];
  List<String> SearchList = <String>[];

  @override
  void initState() {
    super.initState();
    partyListAPI();
    super.initState();
    partyListAPI().then((subjectFromServer) {
      setState(() {
        partyListAPIResult = subjectFromServer;
        userLists = partyListAPIResult;
      });
    });

  }



   partyListAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var response = await get(
      Uri.parse('http://192.169.1.211:8081/insights/2.60.0/party/TDP'),
      headers: headers,
    );
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      try {
        setState(() => partyListAPIResult = jsonDecode(response.body));
      } catch (e) {
        print(partyListAPIResult);
        partyListAPIResult = [];
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Candidature Analysis')
        /*TextField(
          onChanged: (value) {
            setState(() {
              filterSearchResults(value);
              //editingController.text == value;
            });
          },
          controller: editingController,
          decoration: InputDecoration(
              isDense: true,
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(25.0)))),
        ),*/
      ),
      body:  ListView.builder(
          itemCount: partyListAPIResult.length,
          itemBuilder: (context, index) {
            return  Column(
            children:[
              SizedBox(height: 10,),
              Padding(padding:EdgeInsets.all(5),child:TextField(
                onChanged: (string) {
                    setState(() {
                      userLists = ulist
                          .where(
                            (u) => (u.text.toLowerCase().contains(
                          string.toLowerCase(),
                        )),
                      )
                          .toList();
                    });

                },
                controller: editingController,
                decoration: InputDecoration(
                    isDense: true,
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(25.0)))),
              ),),
            SizedBox(height: 10,),
            ...partyList(),
            ]
              );
          },
        ),

        //children: partyList(),

    );
  }

  /*partyList() {
    if (partyListAPIResult.length == 0) return [];
    return partyListAPIResult
        .map<Card>((Value) => Card(
              margin: EdgeInsets.all(12),
              elevation: 20,
              child: SingleChildScrollView(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: ClipOval(
                      child: Image(
                        image: Image.memory(
                          base64Decode(Value['content'.substring(5)] ?? ''),
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ).image,
                      ),
                    ),
                  ),
                  title: Text(
                    Value['name'] ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(Value['constitution'] ?? ''),
                  trailing: Text(
                    Value['party'] ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                  *//*onTap: (){
                        print(Value);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TrsMpDetails(Value)));
                      },*//*
                ),*/
  List<Card> partyList() {
    if (partyListAPIResult.length == 0) return [];
    return partyListAPIResult
        .map<Card>((userLists) => Card(
              margin: EdgeInsets.all(6),
              elevation: 20,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 30,
                  child: ClipOval(
                    child: Image.memory(
                      base64Decode(userLists['content'].substring(22) ?? ''),
                      width: 300,
                      height: 300,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                title: Text(
                  userLists['name'] ?? '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(userLists['constitution'] ?? ''),
                trailing: Text(
                  userLists['party'] ?? '',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: (){
          print(userLists);
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrsMpDetails(userLists)));
        },
              ),
            ))
        .toList();
  }
}
