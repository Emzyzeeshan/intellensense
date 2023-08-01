// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:http/http.dart';
// import 'package:intellensense/LoginPages/widgets/ChartSampleData.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class FaceBookBanner extends StatefulWidget {
//   const FaceBookBanner({Key? key}) : super(key: key);

//   @override
//   State<FaceBookBanner> createState() => _FaceBookBannerState();
// }

// class _FaceBookBannerState extends State<FaceBookBanner> {
//   late Future<dynamic> FacebookLineChartfuturecall = FaceBookBannerGraphApi();
//   TooltipBehavior? _FacebooktooltipBehavior;
//   TooltipBehavior? _FacebooktooltipBehavior1;
  
//   @override
//   void initState() {
//     _FacebooktooltipBehavior = TooltipBehavior(
//         enable: true,
//         canShowMarker: false,
//         format: 'point.x : point.y',
//         header: '');
//     _FacebooktooltipBehavior1 = TooltipBehavior(
//         enable: true,
//         canShowMarker: false,
//         format: 'point.x : point.y',
//         header: '');
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Center(
//             child: Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               elevation: 5,
//               child: Container(
//                 height: 250,
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   gradient: LinearGradient(
//                     colors: const [
//                       /*Color.fromARGB(255, 100, 149, 235),
//                       Color(0xffe4e0f8),*/
//                       Colors.white,
//                       Colors.white
//                     ],
//                     tileMode: TileMode.decal,
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: Stack(
//                     children: [
//                       /*Positioned(
//                         top: 25,
//                         left: 100,
//                         child: DefaultTextStyle(
//                           style: const TextStyle(
//                             fontSize: 20.0,
//                             fontFamily: 'Segoe UI',
//                           ),
//                           child: AnimatedTextKit(
//                             repeatForever: true,
//                             animatedTexts: [
//                               RotateAnimatedText('TWITTER',
//                                   textStyle: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'Segoe UI',color: Colors.black)),
//                               RotateAnimatedText('BATTLE',
//                                   textStyle: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'Segoe UI',color: Colors.black)),
//                             ],
//                             onTap: () {
//                               print("Tap Event");
//                             },
//                           ),
//                         ),
//                       ),*/
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Column(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                     border:
//                                         Border.all(color: Colors.blueAccent),
//                                     borderRadius: BorderRadius.circular(15)),
//                                 height: 120,
//                                 width: 120,
//                                 child: SfCircularChart(
//                                     tooltipBehavior: _FacebooktooltipBehavior1,
//                                     palette: [
//                                       Color.fromRGBO(254, 1, 117, 0),
//                                       Color.fromRGBO(19, 136, 8, 0),
//                                       Color.fromRGBO(249, 125, 9, 0),
//                                     ],
//                                     series: <PieSeries<ChartSampleData,
//                                         String>>[
//                                       PieSeries<ChartSampleData, String>(
//                                           explode: true,
//                                           explodeIndex: 0,
//                                           explodeOffset: '10%',
//                                           dataSource: <ChartSampleData>[
//                                             ...FaceBookPiegraphChartData
//                                             // ChartSampleData(
//                                             //     x: 'David', y: 13, text: 'Dav \n 13%'),
//                                             // ChartSampleData(
//                                             //     x: 'Steve', y: 24, text: 'Ste\n 24%'),
//                                             // ChartSampleData(
//                                             //     x: 'Jack', y: 25, text: 'Jack \n 25%'),
//                                             // ChartSampleData(
//                                             //     x: 'Others', y: 38, text: 'Other \n 38%'),
//                                           ],
//                                           xValueMapper:
//                                               (ChartSampleData data, _) =>
//                                                   data.x as String,
//                                           yValueMapper:
//                                               (ChartSampleData data, _) =>
//                                                   data.y,
//                                           dataLabelMapper:
//                                               (ChartSampleData data, _) =>
//                                                   data.text,
//                                           startAngle: 90,
//                                           endAngle: 90,
//                                           dataLabelSettings:
//                                               const DataLabelSettings(
//                                                   isVisible: true)),
//                                     ]),
//                               ),
//                               Text(
//                                 'Likes',
//                                 style: TextStyle(fontSize: 10),
//                               ),
//                             ],
//                           ),
//                           FutureBuilder<dynamic>(
//                             future: FacebookLineChartfuturecall,
//                             builder: (
//                               BuildContext context,
//                               AsyncSnapshot<dynamic> snapshot,
//                             ) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return SpinKitWave(
//                                   color: Colors.blue,
//                                   size: 18,
//                                 );
//                               } else if (snapshot.connectionState ==
//                                   ConnectionState.done) {
//                                 if (snapshot.hasError) {
//                                   return const Text('Error');
//                                 } else if (snapshot.hasData) {
//                                   return Padding(
//                                     padding: const EdgeInsets.only(top: 35.0),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Text(FaceBookBarGraphdata['lead'][0]),
//                                             Image.asset(
//                                               'assets/new Updated images/image_2023_07_12T10_18_35_331Z.png',
//                                               height: 30,
//                                             )
//                                           ],
//                                         ),
//                                         Column(
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Image.asset(
//                                                   'assets/new Updated images/image_2023_07_12T10_18_25_781Z.png',
//                                                   height: 30,
//                                                 ),
//                                                 Text('YSRCP'),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 } else {
//                                   return const Text('Empty data');
//                                 }
//                               } else {
//                                 return Text(
//                                     'State: ${snapshot.connectionState}');
//                               }
//                             },
//                           ),
//                           Column(
//                             children: [
//                               FutureBuilder<dynamic>(
//                                 future: FacebookLineChartfuturecall,
//                                 builder: (
//                                   BuildContext context,
//                                   AsyncSnapshot<dynamic> snapshot,
//                                 ) {
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.waiting) {
//                                     return SpinKitWave(
//                                       color: Colors.blue,
//                                       size: 18,
//                                     );
//                                   } else if (snapshot.connectionState ==
//                                       ConnectionState.done) {
//                                     if (snapshot.hasError) {
//                                       return const Text('Error');
//                                     } else if (snapshot.hasData) {
//                                       return Container(
//                                           decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   color: Colors.blueAccent),
//                                               borderRadius:
//                                                   BorderRadius.circular(15)),
//                                           height: 120,
//                                           width: 120,
//                                           child: SfFunnelChart(
//                                               palette: [
//                                                 Color.fromRGBO(254, 1, 117, 0),
//                                                 Color.fromRGBO(19, 136, 8, 0),
//                                                 Color.fromRGBO(249, 125, 9, 0),
//                                               ],
//                                               //title: ChartTitle(text: isCardView ? '' : 'Website conversion rate'),
//                                               tooltipBehavior:
//                                                   TooltipBehavior(enable: true),
//                                               series: FunnelSeries<
//                                                       ChartSampleData, String>(
//                                                   dataSource: <ChartSampleData>[
//                                                     ...FaceBookFunnelgraphChartData,
//                                                   ],
//                                                   xValueMapper:
//                                                       (ChartSampleData data, _) =>
//                                                           data.x as String,
//                                                   yValueMapper:
//                                                       (ChartSampleData data, _) =>
//                                                           data.y,
//                                                   /*  explode: isCardView ? false : explode,
//                     gapRatio: isCardView ? 0 : gapRatio,*/
//                                                   neckHeight: /*isCardView ? */
//                                                       '20%' /*: neckHeight.toString()*/ +
//                                                           '%',
//                                                   neckWidth: /*isCardView ?*/
//                                                       '25%' /*: neckWidth.toString()*/ +
//                                                           '%',
//                                                   dataLabelSettings:
//                                                       const DataLabelSettings(
//                                                           textStyle:
//                                                               TextStyle(fontSize: 8),
//                                                           isVisible: true))));
//                                     } else {
//                                       return const Text('Empty data');
//                                     }
//                                   } else {
//                                     return Text(
//                                         'State: ${snapshot.connectionState}');
//                                   }
//                                 },
//                               ),
//                               Text(
//                                 'Comments',
//                                 style: TextStyle(fontSize: 10),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
                      
//                       FutureBuilder<dynamic>(
//                         future: FacebookLineChartfuturecall,
//                         builder: (
//                           BuildContext context,
//                           AsyncSnapshot<dynamic> snapshot,
//                         ) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return SpinKitWave(
//                               color: Colors.blue,
//                               size: 18,
//                             );
//                           } else if (snapshot.connectionState ==
//                               ConnectionState.done) {
//                             if (snapshot.hasError) {
//                               return const Text('Error');
//                             } else if (snapshot.hasData) {
//                               return Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 1.0, top: 60),
//                                     child: Image.asset(
//                                       'assets/icons/Social-Media-Icons-IS-06.png',
//                                       height: 18,
//                                       width: 18,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 140.0, left: 5),
//                                     child: Container(
//                                       height: 150,
//                                       width: 150,
//                                       child: RichText(
//                                         text: new TextSpan(
//                                           // Note: Styles for TextSpans must be explicitly defined.
//                                           // Child text spans will inherit styles from parent
//                                           style: new TextStyle(
//                                             fontSize: 12.0,
//                                             color: Colors.black,
//                                           ),
//                                           children: <TextSpan>[
//                                             TextSpan(
//                                                 text:
//                                                     ' From Posts to public response ',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18,
//                                                     fontFamily: 'Segoe UI')),
//                                             TextSpan(
//                                                 text: FaceBookBarGraphdata['lead'][0],
//                                                 style: new TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.green,
//                                                     fontSize: 20,
//                                                     fontFamily: 'Segoe UI')),
//                                             TextSpan(
//                                                 text:
//                                                     ' is leading in all aspects',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18,
//                                                     fontFamily: 'Segoe UI')),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 100.0),
//                                         child: FutureBuilder<dynamic>(
//                                           future: FacebookLineChartfuturecall,
//                                           builder: (
//                                             BuildContext context,
//                                             AsyncSnapshot<dynamic> snapshot,
//                                           ) {
//                                             if (snapshot.connectionState ==
//                                                 ConnectionState.waiting) {
//                                               return SpinKitWave(
//                                                 color: Colors.blue,
//                                                 size: 18,
//                                               );
//                                             } else if (snapshot
//                                                     .connectionState ==
//                                                 ConnectionState.done) {
//                                               if (snapshot.hasError) {
//                                                 return const Text('Error');
//                                               } else if (snapshot.hasData) {
//                                                 return Container(
//                                                   decoration: BoxDecoration(
//                                                       border: Border.all(
//                                                           color: Colors
//                                                               .blueAccent),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15)),
//                                                   height: 100,
//                                                   width: 135,
//                                                   child: SfCartesianChart(
//                                                     palette: <Color>[
//                                                       Color(0xffff7f50),
//                                                       Color(0xfff0ead6),
//                                                       Color(0xffffd700),
//                                                       Color(0xff264348),
//                                                     ],
//                                                     plotAreaBorderWidth: 0,
//                                                     primaryXAxis: CategoryAxis(
//                                                       labelStyle:
//                                                           const TextStyle(
//                                                               color:
//                                                                   Colors.black,
//                                                               fontSize: 8),
//                                                       axisLine: const AxisLine(
//                                                           width: 0),
//                                                       labelPosition:
//                                                           ChartDataLabelPosition
//                                                               .outside,
//                                                       majorTickLines:
//                                                           const MajorTickLines(
//                                                               width: 0),
//                                                       majorGridLines:
//                                                           const MajorGridLines(
//                                                               width: 0),
//                                                     ),
//                                                     primaryYAxis: NumericAxis(
//                                                         labelStyle:
//                                                             const TextStyle(
//                                                                 color: Colors
//                                                                     .black,
//                                                                 fontSize: 8),
//                                                         labelPosition:
//                                                             ChartDataLabelPosition
//                                                                 .outside,
//                                                         isVisible: false,
//                                                         minimum: 0,
//                                                         maximum: 2000),
//                                                     series: <ColumnSeries<
//                                                         ChartSampleData,
//                                                         String>>[
//                                                       ColumnSeries<
//                                                           ChartSampleData,
//                                                           String>(
//                                                         width: 0.9,
//                                                         dataLabelSettings:
//                                                             const DataLabelSettings(
//                                                                 isVisible:
//                                                                     false,
//                                                                 labelAlignment:
//                                                                     ChartDataLabelAlignment
//                                                                         .top),
//                                                         dataSource: <ChartSampleData>[
//                                                           ...FaceBookBargraphChartdata
//                                                         ],
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         xValueMapper:
//                                                             (ChartSampleData
//                                                                         sales,
//                                                                     _) =>
//                                                                 sales.x
//                                                                     as String,
//                                                         yValueMapper:
//                                                             (ChartSampleData
//                                                                         sales,
//                                                                     _) =>
//                                                                 sales.y,
//                                                       ),
//                                                     ],
//                                                     tooltipBehavior:
//                                                         _FacebooktooltipBehavior,
//                                                   ),
//                                                 );
//                                               } else {
//                                                 return const Text('Empty data');
//                                               }
//                                             } else {
//                                               return Text(
//                                                   'State: ${snapshot.connectionState}');
//                                             }
//                                           },
//                                         ),
//                                       ),
//                                       Text(
//                                         'Views',
//                                         style: TextStyle(fontSize: 10),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               );
//                             } else {
//                               return const Text('Empty data');
//                             }
//                           } else {
//                             return Text('State: ${snapshot.connectionState}');
//                           }
//                         },
//                       ),
                     
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ]);
//   }

//   //Bar Graph data
//   var FaceBookBarGraphdata;

//   Map FaceBookSelectionquery1 = new Map<String, dynamic>();
//   List<ChartSampleData> FaceBookBargraphChartdata = [];
//   List<ChartSampleData> FaceBookPiegraphChartData = [];
//   List<ChartSampleData> FaceBookFunnelgraphChartData = [];
//   Future<dynamic> FaceBookBannerGraphApi() async {
//     var body = json.encode({
//       "type": "party_data",
//       "STATE": 'ANDHRA PRADESH',
//       "party_list": 'TDP, YSRCP',
//       //"social_handle": "YOUTUBE"
//     });
//     var headers = {'Content-Type': 'application/json'};
//     var response = await post(
//         Uri.parse('http://idxp.pilogcloud.com:6659/social_media_FB/'),
//         headers: headers,
//         body: body);

//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print('inside loop');
//       try {
//         print('inside try');
//         FaceBookBarGraphdata = jsonDecode(utf8.decode(response.bodyBytes));
//         setState(() {
//           FaceBookBarGraphdata['party_data'].forEach((key, value) {
//             print(key);

//             FaceBookBargraphChartdata.add(
//               ChartSampleData(
//                   x: '$key', y: FaceBookBarGraphdata['party_data'][key][0]['LIKES']),
//             );
//             FaceBookPiegraphChartData.add(
//               ChartSampleData(
//                   x: '$key',
//                   y: FaceBookBarGraphdata['party_data'][key][0]['COMMENTS'],
//                   text: '$key'),
//             );
//             FaceBookFunnelgraphChartData.add(
//               ChartSampleData(
//                   x: '$key',
//                   y: FaceBookBarGraphdata['party_data'][key][0]['SHARES'],
//                   text: '$key'),
//             );
//           });

//           // for(int i=0;i<FaceBookBarGraphdata['party_data'])
//           // FaceBookBargraphChartdata.add(ChartSampleData(x: 'TDP', y: 8683),);
//         });
//         print('data here');
//         print(FaceBookBarGraphdata);
//       } catch (e) {
//         print(FaceBookBarGraphdata);
//       }
//     } else {
//       print(response.reasonPhrase);
//     }
//     return FaceBookBarGraphdata;
//   }
// }
