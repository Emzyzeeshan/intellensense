import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class FaceEmotion extends StatefulWidget {
  const FaceEmotion({Key? key}) : super(key: key);

  @override
  State<FaceEmotion> createState() => _FaceEmotionState();
}

class _FaceEmotionState extends State<FaceEmotion> {
  TextEditingController _editingController = TextEditingController();
  late Future<dynamic> _value1=FaceEmotionAPI();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left:8.0,right: 8,top: 40,bottom: 10),
          child: Column(children: [
            Image.asset('assets/new Updated images/faceEmotion.gif'),
            SizedBox(height: 10,),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Pls enter link';
                }
                ;
                return null;
              },
              controller: _editingController,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.blue.shade100,
                  filled: true,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Enter Link',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  prefixIcon: Container(
                    padding: EdgeInsets.all(15),
                    child: Icon(Icons.link),
                    width: 18,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () {
                // if (_formKey.currentState!.validate()) {
                  setState(() {
                    _value1=FaceEmotionAPI();
                  });
                // }
              },
              child: Text(
                'Analyse',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blueAccent,
            ),
            SizedBox(
              height: 10,
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
                    return Flexible(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:FaceEmotiontdata['res'].length ,
                        itemBuilder: (context, index) {
                        return FrameCard(
                            'data:image/png;base64,'+FaceEmotiontdata['res'][index]['EMOTION_IMAGE']);
                      }),
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
        ),
      ),
    );
  }

  var FaceEmotiontdata;
  Map Selectionquery = new Map<String, dynamic>();
  Future<dynamic> FaceEmotionAPI() async {
    setState(() {
      Selectionquery['URL'] =
          '${_editingController.text}';
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6650/facial_emotion_analysis_mobile/'),
        body: Selectionquery);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        FaceEmotiontdata = json.decode(utf8.decode(response.bodyBytes));

        print(FaceEmotiontdata);
      } catch (e) {
        print(FaceEmotiontdata);
      }
    } else {
      print(response.reasonPhrase);
    }
    return FaceEmotiontdata;
  }

  FrameCard(String base64String) {
    return 
    Container(
      height: 140,
      width: 140,
      child: Card(shadowColor: Colors.blueAccent,
          elevation: 7,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.blue.shade300,width: 1)),
                child: Card(
                  child: Image.memory(
                    base64Decode(base64String.substring(22) ??
                                                  ''),
                    width: 110,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
