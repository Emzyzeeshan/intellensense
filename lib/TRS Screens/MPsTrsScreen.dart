import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart';

import 'TrsMpDetails.dart';

class MPsTrsScreen extends StatefulWidget {
  const MPsTrsScreen({Key? key}) : super(key: key);

  @override
  State<MPsTrsScreen> createState() => _MPsTrsScreenState();
}

class _MPsTrsScreenState extends State<MPsTrsScreen> {
  var MPdataResult = [];
  @override
  void initState() {
    super.initState();
    TrsMpAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(58, 129, 233, 1),
          title: Text(''),
        ),
        body: ListView(
          children: TRSMPData(),
        ));
  }

  List<Card> TRSMPData() {
    if (MPdataResult.length == 0) return [];
    return MPdataResult.map<Card>((Value) => Card(
        margin: EdgeInsets.all(12),
        elevation: 20,
        child:   ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              child: ClipOval(
                child: Image.memory(
                  base64Decode(Value['content'].substring(22) ?? ''),
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(Value['name'],style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text(Value['constitution']),
            trailing: Text(Value['party'],style: TextStyle(fontSize: 16),),
            onTap: (){
              print(Value);
              Navigator.push(context, MaterialPageRoute(builder: (context) => TrsMpDetails(Value)));
            },
          ),
        )).toList();
  }

  TrsMpAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({});
    var response = await post(
      Uri.parse('http://192.169.1.211:8081/insights/1.0.0/politicalType/MP'),
      headers: headers,
      body: body,
    );
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      try {
        setState(() => MPdataResult = jsonDecode(response.body));
      } catch (e) {
        MPdataResult = [];
      }
    } else {
      response.reasonPhrase;
    }
  }
}
