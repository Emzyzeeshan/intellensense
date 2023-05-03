import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ConstituencyAnalysis extends StatefulWidget {
  const ConstituencyAnalysis({super.key});

  @override
  State<ConstituencyAnalysis> createState() => _ConstituencyAnalysisState();
}

class _ConstituencyAnalysisState extends State<ConstituencyAnalysis> {
  TextEditingController editingController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); //
  final duplicateItems = List<String>.generate(1000, (i) => "Candidate $i");
  var items = <String>[];
  var ConstituencyAnalysisData;

  @override
  void initState() {
    items = duplicateItems;
    super.initState();
    ConstituencyAnalysiAPI();
  }

  void filterSearchResults(String query) {
    setState(() {
      items = duplicateItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.grey.shade700,
          icon: Icon(Icons.people_outline_outlined),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        centerTitle: true,
        backgroundColor: Color(0xffd2dfff),
        title: Image.asset(
          'assets/icons/IntelliSense-Logo-Finall.gif',
          fit: BoxFit.cover,
          height: 40,
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xffd2dfff),
        child: Column(
          children: [
            Image.asset(
              'assets/icons/IntelliSense-Logo-Finall.gif',
              fit: BoxFit.cover,
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: 7,
                right: 7,
              ),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search_rounded),
                    hintText: 'Search....',
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    focusColor: Colors.grey),
              ),
            ),
            Expanded(
              child:  ListView(
                children: ConstituencyData(),
              ),
            ),
          ],
        ),
      ),
    );
  }
   List<Card> ConstituencyData() {
    if (ConstituencyAnalysisData['ASSEMBLY_CONSTITUENCY'] == null ?ConstituencyAnalysisData['ASSEMBLY_CONSTITUENCY']:ConstituencyAnalysisData['ASSEMBLY_CONSTITUENCY'].length == 0) return [];
    return ConstituencyAnalysisData['ASSEMBLY_CONSTITUENCY'].map<Card>((Value) => Card(
      margin: EdgeInsets.all(12),
      elevation: 20,
      child:   ListTile(
        title: Text(Value,style: TextStyle(fontWeight: FontWeight.bold),),
        onTap: (){
         /* print(Value);
          Navigator.push(context, MaterialPageRoute(builder: (context) => TrsMpDetails(Value)));*/
        },
      ),
    )).toList();
  }
  ConstituencyAnalysiAPI() async {
    var headers = {'Content-Type': 'application/json'};
    var response = await get(
      Uri.parse(
          'http://idxp.pilogcloud.com:6652/constituency_names/'),
      headers: headers,
    );
    print(response.toString());
    if (response.statusCode == 200) {
      print(response.body);
      try {
        ConstituencyAnalysisData = jsonDecode(utf8.decode(response.bodyBytes));
      } catch (e) {}
    } else {
      print(response.reasonPhrase);
    }
    return ConstituencyAnalysisData;
  }
}