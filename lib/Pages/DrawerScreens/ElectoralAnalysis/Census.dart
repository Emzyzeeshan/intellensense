import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:skeletons/skeletons.dart';

class Census extends StatefulWidget {
  @override
  State<Census> createState() => _CensusState();
}

class _CensusState extends State<Census> {
  late Future<dynamic> statenamedata=CensusStateNamesAPI();
 late Future<dynamic> Districtnamedata=CensusDistrictNamesAPI();
late Future<dynamic> SubDistrictnamedata=CensusSubDistrictNamesAPI();
late Future<dynamic> villagenamedata=CensusVillageNamesAPI();
  String? input1='TELANGANA' ;
   String? input2 ='Select District';
   String ? SUB_DISTRICT;
   String? Village;
    List Statelist = [];
    List Districtlist=[];
    List Subdistrictlist=[];
List Villagelist=[];
  @override
  Widget build(BuildContext context) {
  
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<dynamic>(
                future: statenamedata,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<dynamic> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SingleChildScrollView(
                      child:  SkeletonParagraph(
                        style: SkeletonParagraphStyle(
                            lines: 1,
                           
                            lineStyle: SkeletonLineStyle(
                            
                              height: 30,
                                 width:  MediaQuery.of(context).size.width*0.4,
                              borderRadius: BorderRadius.circular(8),
                              // minLength: MediaQuery.of(context).size.width / 6,
                              // maxLength: MediaQuery.of(context).size.width / 3,
                            )),
                      )
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                     
                      return  Container(
                        width: MediaQuery.of(context).size.width*0.47,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Text(
                      '${input1}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: Statelist.map<DropdownMenuItem<String>>(
                        (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            )).toList(),
                    value: input1,
                    onChanged: (value) {
                             
                      setState(() {
                        input1 = value as String;
                      Districtlist.clear();
                        print(input1);
                  districtvisible==true? Districtnamedata=CensusDistrictNamesAPI():null;
                  SUB_DISTRICT='Select Sub District';
Subdistrictlist.clear();
                
                      });

                    },
                    buttonStyleData: const ButtonStyleData(
                       padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 245, 239, 239),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topLeft: Radius.circular(15))),
                      height: 40,
                      
                    ),
                    dropdownStyleData: const DropdownStyleData(
                      maxHeight: 200,
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                    isDense: true,
                  ),
                ),
              );
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
              Spacer(),
             //District
               Container(
                    width: MediaQuery.of(context).size.width*0.47,
                    child:FutureBuilder<dynamic>(
                future: Districtnamedata,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<dynamic> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return  SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 1,
                          
                          lineStyle: SkeletonLineStyle(
                           
                            height: 30,
                            width:  MediaQuery.of(context).size.width*0.42,
                            borderRadius: BorderRadius.circular(8),
                            // minLength: MediaQuery.of(context).size.width / 6,
                            // maxLength: MediaQuery.of(context).size.width / 3,
                          )),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {

                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                        
                      return   DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Text(
                          '${input2}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: Districtlist.map<DropdownMenuItem<String>>(
                            (itemm) => DropdownMenuItem<String>(
                                  value: itemm.toString(),
                                  child: Text(
                                    itemm,
                                    style: const TextStyle(
                                     
                                    ),
                                  ),
                                )).toList(),
                        value: input2,
                        onChanged: (value) {
                          setState(() {
                            input2 = value as String;
                            print(input2);
                          districtloaded==true?  SubDistrictnamedata=CensusSubDistrictNamesAPI():null;
                         
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 245, 239, 239),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  topLeft: Radius.circular(15))),
                          height: 40,
                          
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        isDense: true,
                      ),
                    );
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
                    
                    
                  ),
            ],
          ),
          SizedBox(height: 5,),

             
          SizedBox(height: 10,),
          //sub district
           Row(
            children: [
                Container(
                    width: MediaQuery.of(context).size.width*0.47,
                    child:FutureBuilder<dynamic>(
                future: SubDistrictnamedata,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<dynamic> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return  SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 1,
                          
                          lineStyle: SkeletonLineStyle(
                           
                            height: 30,
                            width:  MediaQuery.of(context).size.width*0.42,
                            borderRadius: BorderRadius.circular(8),
                            // minLength: MediaQuery.of(context).size.width / 6,
                            // maxLength: MediaQuery.of(context).size.width / 3,
                          )),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {

                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                        
                      return   DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Text(
                          '${SUB_DISTRICT}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: Subdistrictlist.map<DropdownMenuItem<String>>(
                            (itemm) => DropdownMenuItem<String>(
                                  value: itemm.toString(),
                                  child: Text(
                                    itemm,
                                    style: const TextStyle(
                                     
                                    ),
                                  ),
                                )).toList(),
                        value: SUB_DISTRICT,
                        onChanged: (value) {
                          setState(() {
                            SUB_DISTRICT = value as String;
                            print(SUB_DISTRICT);
                            Subdistrictloaded==true?villagenamedata=CensusVillageNamesAPI():null;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 245, 239, 239),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  topLeft: Radius.circular(15))),
                          height: 40,
                          
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        isDense: true,
                      ),
                    );
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
                    
                    
                  ),
             Spacer(),
             //village
              Container(
                    width: MediaQuery.of(context).size.width*0.47,
                    child:FutureBuilder<dynamic>(
                future: villagenamedata,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<dynamic> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return  SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 1,
                          
                          lineStyle: SkeletonLineStyle(
                           
                            height: 30,
                            width:  MediaQuery.of(context).size.width*0.42,
                            borderRadius: BorderRadius.circular(8),
                            // minLength: MediaQuery.of(context).size.width / 6,
                            // maxLength: MediaQuery.of(context).size.width / 3,
                          )),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {

                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                        
                      return   DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Text(
                          '${Village}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: Villagelist.map<DropdownMenuItem<String>>(
                            (itemm) => DropdownMenuItem<String>(
                                  value: itemm.toString(),
                                  child: Text(
                                    itemm,
                                    style: const TextStyle(
                                     
                                    ),
                                  ),
                                )).toList(),
                        value: Village,
                        onChanged: (value) {
                          setState(() {
                            Village = value as String;
                            print(Village);
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 245, 239, 239),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                  topLeft: Radius.circular(15))),
                          height: 40,
                          
                        ),
                        dropdownStyleData: const DropdownStyleData(
                          maxHeight: 200,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        ),
                        isDense: true,
                      ),
                    );
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                },
              ),
                    
                    
                  ),
            ],
          )
        ],
      ),
    );
  }

   var  CensusStateNamesdata;
  Map Selectionquery = new Map<String, dynamic>();
  Future<dynamic> CensusStateNamesAPI() async {
    setState(() {
      Selectionquery['type'] = 'STATE_NAMES';
      Selectionquery['STATE'] = '';
      Selectionquery['DISTRICT'] = '';
       Selectionquery['SUB_DISTRICT'] = '';
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6652/electoral_analysis_census/'),
        body: Selectionquery);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        CensusStateNamesdata = json.decode(response.body);
        // for(int i=0;i<CensusStateNamesdata['STATE_NAMES'].length;i++){
        //   PartyName.add(CensusStateNamesdata['STATE_NAMES'][i]);
        // }
        setState(() {
           SUB_DISTRICT='Select Sub-district';
          
          districtvisible=true;
        });
        Statelist=CensusStateNamesdata['STATE_NAMES'];
      
        print(Statelist[1]);
      } catch (e) {
        print(e);
      }
    } else {
      print(response.reasonPhrase);
    }
    return CensusStateNamesdata;
  }


  //District
  var  CensusDistrictNamesdata;
bool districtvisible=false;
  Map Selectionquery2 = new Map<String, dynamic>();
   CensusDistrictNamesAPI() async {
    setState(() {
      Selectionquery2['type'] = 'DISTRICT_NAMES';
      Selectionquery2['STATE'] = input1.toString();
      Selectionquery2['DISTRICT'] = '';
       Selectionquery2['SUB_DISTRICT'] = '';
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6652/electoral_analysis_census/'),
        body: Selectionquery2);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
       
     setState(() {
       CensusDistrictNamesdata = json.decode(response.body);
       districtloaded=true;
 Districtlist=CensusDistrictNamesdata['DISTRICT_NAMES'];
 input2=Districtlist[0];

 });
       
      
        print(Districtlist);
      } catch (e) {
        print(e);
      }
    } else {
      print(response.reasonPhrase);
    }
    return CensusDistrictNamesdata;
  }

  //sub-district
  var  CensusSubDistrictNamesdata;
bool districtloaded=false;
  Map Selectionquery3 = new Map<String, dynamic>();
   CensusSubDistrictNamesAPI() async {
    setState(() {
      Selectionquery3['type'] = 'SUBDISTRICT_NAMES';
      Selectionquery3['STATE'] = input1.toString();
      Selectionquery3['DISTRICT'] = input2.toString();
       Selectionquery3['SUB_DISTRICT'] = '';
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6652/electoral_analysis_census/'),
        body: Selectionquery3);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
       
     setState(() {
       CensusSubDistrictNamesdata = json.decode(response.body);
 Subdistrictlist=CensusSubDistrictNamesdata['SUBDISTRICT_NAMES'];
 SUB_DISTRICT=Subdistrictlist[0];
 Subdistrictloaded=true;
 });
       
      
        print(Subdistrictlist);
      } catch (e) {
        print(e);
      }
    } else {
      print(response.reasonPhrase);
    }
    return CensusSubDistrictNamesdata;
  }


  //Village
    var  CensusVillageNamesdata;
bool Subdistrictloaded=false;
  Map Selectionquery4 = new Map<String, dynamic>();
   CensusVillageNamesAPI() async {
    setState(() {
      Selectionquery4['type'] = 'VILLAGE_NAMES';
      Selectionquery4['STATE'] = input1.toString();
      Selectionquery4['DISTRICT'] = input2.toString();
       Selectionquery4['SUB_DISTRICT'] = SUB_DISTRICT.toString();
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6652/electoral_analysis_census/'),
        body: Selectionquery4);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
       
     setState(() {
       CensusVillageNamesdata = json.decode(response.body);
       if(CensusVillageNamesdata['VILLAGE_NAMES'].isEmpty){
        Villagelist.add('NO Data');
       }else{ Villagelist=CensusVillageNamesdata['VILLAGE_NAMES'];}

 Village=Villagelist[0];
 });
       
      
        print(Village);
      } catch (e) {
        print(e);
      }
    } else {
      print(response.reasonPhrase);
    }
    return CensusVillageNamesdata;
  }
}
