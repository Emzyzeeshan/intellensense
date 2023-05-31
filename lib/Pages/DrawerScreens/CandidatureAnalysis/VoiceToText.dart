import 'dart:convert';


import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intellensense/SpalashScreen/widgets/ChartSampleData.dart';
import 'package:intellensense/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VoiceToText extends StatefulWidget {

  @override
  State<VoiceToText> createState() => _VoiceToTextState();
}

class _VoiceToTextState extends State<VoiceToText> {
late Future<dynamic>  _value1= VoiceToTextAPI();

  @override
  void initState() {
 
    super.initState();
  }
   
TextEditingController _editingController=TextEditingController();
TextEditingController ResponseID =TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var input = 'ENGLISH';
  List Language = ['ENGLISH', 'TELUGU', 'HINDI'];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/new Updated images/videoscan.gif',
                        height: 200, width: 200),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Voice To Text',
                        style: TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                           if (value!.isEmpty
                           ) {
                      return 'Pls enter link';
                  };
return null;
                        },
                        controller: _editingController,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            isDense: true,
                            fillColor: Colors.blue.shade100,
                            filled: true,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: 'Link',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                            prefixIcon: Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.link),
                              width: 18,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            '${input}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: Language.map<DropdownMenuItem<String>>(
                              (item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  )).toList(),
                          value: input,
                          onChanged: (value) {
                            setState(() {
                              input=value!.toString();
                            });
                          },
                          buttonStyleData: const ButtonStyleData(
                            height: 40,
                            width: 200,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        enabled: false,
                  //       validator:  (val) {
                  //   if (isNotNull) 
                  //     return 'Response ID is required';
                  // },
                        controller: ResponseID,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                            isDense: true,
                            fillColor: Colors.blue.shade100,
                            filled: true,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: '${logindata.getString('username')}',
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                            prefixIcon: Container(
                              padding: EdgeInsets.all(15),
                              child: Icon(Icons.person),
                              width: 18,
                            )),
                      ),
                    ),
                     SizedBox(
                      height: 10,
                    ),
            
                    MaterialButton(
                      onPressed: () {
                         if (_formKey.currentState!.validate()) {
                          setState(() {
                              _value1=VoiceToTextAPI();
                          });
                         
                         }
                      },
                      child: Text(
                        'Analyse',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blueAccent,
                    ),
                   
            
                    
                    
             FutureBuilder<dynamic>(
              future: _value1,
              builder: (
                BuildContext context,
                AsyncSnapshot<dynamic> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SpinKitWave(
                        color: Colors.blue,
                        size: 18,
                      ),
                    ],
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return 
                     Column(
                       children: [
                         Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              elevation: 7,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Converted Text', style: TextStyle(
                                                            fontFamily: 'Segoe UI',
                                                            fontSize: 19,
                                                          ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text('${VoiceToTextdata['CONVERTED_TEXT']['0']}',
                                            style: GoogleFonts.bebasNeue(
                                                fontWeight: FontWeight.w500, fontSize: 15)),
                                      ),
                                    ),
                                   
                                  ],
                                ),
                              ),
                            )),
                             Card(elevation:7,
                               child: SfCircularChart(
                                   title: ChartTitle(text:  'Sales by sales person'),
                                   legend: Legend(isVisible: true),
                                   series:<PieSeries<ChartSampleData, String>>[
                                   PieSeries<ChartSampleData, String>(
                                       explode: true,
                                       explodeIndex: 0,
                                       explodeOffset: '10%',
                                       dataSource: <ChartSampleData>[
                                         ChartSampleData(x: 'POSITIVE', y:num.parse(VoiceToTextdata['POSITIVE_WORDS_COUNT']['0']) , text: 'POSITIVE'),
                                         ChartSampleData(x: 'NEGATIVE', y:num.parse( VoiceToTextdata['NEGATIVE_WORDS_COUNT']['0']) , text: 'NEGATIVE'),
                                         ChartSampleData(x: 'NEUTRAL', y: num.parse(VoiceToTextdata['NEUTRAL_WORDS_COUNT']['0']) , text: 'NEUTRAL'),
                                        
                                       ],
                                       xValueMapper: (ChartSampleData data, _) => data.x as String,
                                       yValueMapper: (ChartSampleData data, _) => data.y,
                                       dataLabelMapper: (ChartSampleData data, _) => data.text,
                                       startAngle: 90,
                                       endAngle: 90,
                                       dataLabelSettings: const DataLabelSettings(isVisible: true)),
                                 ],
                                 ),
                             ),
                       ],
                     );
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
                      ),
                   
                  ]),
            )));
  }

  var VoiceToTextdata;
  Map Selectionquery = new Map<String, dynamic>();
  Future<dynamic> VoiceToTextAPI() async {
    setState(() {
      Selectionquery['accessName'] = 'INSIGHTS';
      Selectionquery['audioLink'] =
          '${_editingController.text}';
      Selectionquery['audioLanguage'] = '$input';
      Selectionquery['responseId'] = '${logindata.getString('username')}';
    });
    var response = await post(
        Uri.parse('http://apihub.pilogcloud.com:6663/VoiceTranslator_mobile/'),
        body: Selectionquery);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        VoiceToTextdata = jsonDecode(utf8.decode(response.bodyBytes));

        print(VoiceToTextdata);
      } catch (e) {
        print(VoiceToTextdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return VoiceToTextdata;
  }
}
