import 'dart:convert';
import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intellensense/main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../components/ResponsiveSize.dart';

class PartyFilterScreen extends StatefulWidget {
  const PartyFilterScreen({super.key});

  @override
  State<PartyFilterScreen> createState() => _PartyFilterScreenState();
}

class _PartyFilterScreenState extends State<PartyFilterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var input = 'TDP';
  List PartyName = ['TDP', 'JSP', 'YSRCP'];
  late Future<dynamic> finaldata = PartyDataApi('TDP');
  ScrollController? scrollController = ScrollController();
  Uint8List? myImage;
  @override
  Widget build(BuildContext context) {
    DeviceSizeConfig().init(context);
    return Scaffold(
        backgroundColor: Color(0xffd2dfff),
        appBar: AppBar(
          actions: [
            // IconButton(onPressed: (){}, icon: icon)
          ],
          toolbarHeight: 70,
          elevation: 0,
          flexibleSpace: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Image.asset(
                'assets/icons/IntelliSense-Logo-Finall_01022023_A.gif',
                height: 70,
                width: 100,
              ),
            ),
          ),
          backgroundColor: Color(0xffd2dfff),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  key: DashboardDropdownkey,
                  hint: Text(
                    '${input}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: PartyName.map<DropdownMenuItem<String>>(
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
                      input = value as String;
                      print(input);
                      finaldata = PartyDataApi(input);
                      // pageController.jumpToPage(
                      //     data['dashBordlist']
                      //         .indexOf(selectedValue));
                      // print(data['dashBordlist']
                      //     .indexOf(selectedValue));
                    });
                  },
                  buttonHeight: 50,
                  buttonWidth: MediaQuery.of(context).size.width,
                  itemHeight: 40,
                  iconSize: 14,
                  buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey[200],
                  ),
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownPadding: null,
                  dropdownElevation: 8,
                  dropdownOverButton: true,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  dropdownFullScreen: false,
                  dropdownDecoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  dropdownMaxHeight: MediaQuery.of(context).size.height * 0.5,
                  scrollbarAlwaysShow: true,
                  offset: const Offset(-20, 0),
                  isDense: true,
                ),
              ),
            ),
            FutureBuilder(
              future: finaldata,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.35),
                    child: SpinKitWave(
                      size: 30,
                      color: Colors.blueAccent,
                    ),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: const Text('Data Error'));
                  } else if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: partydata.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5),
                              child: ListTile(
                                dense: true,
                                tileColor: Colors.grey.shade100,

                                subtitle:
                                    Text("Party: ${partydata[index]['party']}"),
                                // collapsedBackgroundColor: Colors.grey.shade100,
                                // tilePadding: EdgeInsets.all(5),

                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 30,
                                  child: ClipOval(
                                    child: Image.memory(
                                      base64Decode(partydata[index]['content']
                                              .substring(22) ??
                                          ''),
                                      width: 300,
                                      height: 300,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                title: Text('${partydata[index]['name']}'),
                                trailing: Icon(Icons.arrow_drop_up_outlined),
                                onTap: () {
                                  showMaterialModalBottomSheet(
                                    enableDrag: false,
                                    elevation: 5,
                                    context: context,
                                    builder: (context) => Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.88,
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              ClipOval(
                                                child: Image.memory(
                                                  base64.decode(
                                                      '${partydata[index]['content'].substring(22) ?? ''}'),
                                                  height: 100,
                                                  width: 100,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${partydata[index]['name']}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Table(
                                                  defaultColumnWidth:
                                                      FixedColumnWidth(150.0),
                                                  border: TableBorder.all(
                                                      color: Colors.grey,
                                                      style: BorderStyle.solid,
                                                      width: 2),
                                                  children: [
                                                    TableRow(
                                                      children: [
                                                        TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Text(
                                                              'Contact No',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                        TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Text(
                                                                '${partydata[index]['contactNumber'] ?? 'N/A'}'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: [
                                                        TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Text(
                                                              'Religion',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                        TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Text(
                                                                '${partydata[index]['religion'] ?? 'N/A'}'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: [
                                                        TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Text(
                                                              'Caste',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                        TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Text(
                                                                '${partydata[index]['caste'] ?? 'N/A'}'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: [
                                                        TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Text(
                                                              'Age',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                        TableCell(
                                                          verticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Text(
                                                                '${partydata[index]['age'] ?? 'N/A'}'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ]),
                                              // ClipOval(
                                              //   child: Image.memory(
                                              //     base64.decode(
                                              //         '${partydata[index]['content'].substring(22) ?? ''}'),
                                              //     height: 100,
                                              //     width: 100,
                                              //   ),
                                              // ),
                                              // SizedBox(
                                              //   height: 5,
                                              // ),
                                              // Text(
                                              //   '${partydata[index]['name']}',
                                              //   style: TextStyle(
                                              //       fontWeight:
                                              //           FontWeight.bold),
                                              // ),
                                              // SizedBox(
                                              //   height: 10,
                                              // ),
                                              // ListTile(
                                              //   leading:
                                              //       Text('PoliticalType:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['politicalType'] ?? 'N/A'}'),
                                              // ),
                                              // ListTile(
                                              //   leading:
                                              //       Text('Constitution:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['constitution'] ?? 'N/A'}'),
                                              // ),
                                              // ListTile(
                                              //   leading:
                                              //       Text('ContactNumber:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['contactNumber'] ?? 'N/A'}'),
                                              // ),
                                              // ListTile(
                                              //   leading: Text('Religion:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['religion'] ?? 'N/A'}'),
                                              // ),
                                              // ListTile(
                                              //   leading: Text('Caste:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['caste'] ?? 'N/A'}'),
                                              // ),
                                              // ListTile(
                                              //   leading: Text('Age:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['age'] ?? 'N/A'}'),
                                              // ),
                                              // ListTile(
                                              //   leading: Text('Education:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['education'] ?? 'N/A'}'),
                                              // ),
                                              // ListTile(
                                              //   leading:
                                              //       Text('PoliticalCareeer:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['politicalCareeer'] ?? 'N/A'}'),
                                              // ),
                                              // ListTile(
                                              //   leading: Text(
                                              //       'ActiveInSocialMedia:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['activeInSocialMedia'] ?? 'N/A'}'),
                                              // ),
                                              // ListTile(
                                              //   leading: Text(
                                              //       'LastFourYearsCampains:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['lastFourYearsCampains'] ?? 'N/A'}'),
                                              // ),
                                              // ListTile(
                                              //   leading: Text('Initiatives:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['initiatives'] ?? 'N/A'}'),
                                              // ),
                                              // ListTile(
                                              //   leading: Text(
                                              //       'NotableEndorsement:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['notableEndorsement'] ?? 'N/A'}'),
                                              // ),
                                              // ListTile(
                                              //   leading: Text('Spouse:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['spouse'] ?? 'N/A'}'),
                                              // ),
                                              // ListTile(
                                              //   leading: Text('Strenths:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['strenths'] ?? 'N/A'}'),
                                              // ),
                                              // ListTile(
                                              //   leading: Text('Weekness:  '),
                                              //   trailing: Text(
                                              //       '${partydata[index]['weekness'] ?? 'N/A'}'),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                    );
                  } else {
                    return Center(child: const Text('Server Error'));
                  }
                } else {
                  return Center(
                      child: Text('State: ${snapshot.connectionState}'));
                }
              }),
            ),
            // Flexible(
            //   child: HR_Dashboard(),
            // ),
          ]),
        ));
  }

  var partydata;
  Future<dynamic> PartyDataApi(input) async {
    // await Future.delayed(Duration(seconds: 1));
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({});
    var response = await get(
      Uri.parse('http://192.169.1.211:8081/insights/2.60.0/party/$input'),
    );

    if (response.statusCode == 200) {
      setState(() {
        partydata = jsonDecode(response.body);
      });

      // print(data);
      print(partydata[0]);
    } else {
      print(response.reasonPhrase);
    }
    return partydata;
  }
}
