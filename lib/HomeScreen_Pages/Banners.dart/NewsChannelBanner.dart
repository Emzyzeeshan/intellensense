// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:http/http.dart';
// import 'package:intellensense/LoginPages/widgets/ChartSampleData.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class NewsChannelBanner extends StatefulWidget {
//   const NewsChannelBanner({Key? key}) : super(key: key);

//   @override
//   State<NewsChannelBanner> createState() => _NewsChannelBannerState();
// }

// class _NewsChannelBannerState extends State<NewsChannelBanner> {
//   late Future<dynamic> NewschannelLineChartfuturecall = NewsChannelBannerGraphApi();
//   TooltipBehavior? _NewsChanneltooltipBehavior;
//   TooltipBehavior? _NewsChanneltooltipBehavior1;
//   @override
//   void initState() {
   
//     _NewsChanneltooltipBehavior = TooltipBehavior(
//         enable: true,
//         canShowMarker: false,
//         format: 'point.x : point.y',
//         header: '');
//     _NewsChanneltooltipBehavior1 = TooltipBehavior(
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
                 
//                 ),
//                 child: FutureBuilder<dynamic>(
//                                           future: NewschannelLineChartfuturecall,
//                                           builder: (
//                                               BuildContext context,
//                                               AsyncSnapshot<dynamic> snapshot,
//                                               ) {
//                                             if (snapshot.connectionState ==
//                                                 ConnectionState.waiting) {
//                                               return SpinKitWave(
//                                                 color: Colors.blue,
//                                                 size: 18,
//                                               );
//                                             } else if (snapshot.connectionState ==
//                                                 ConnectionState.done) {
//                                               if (snapshot.hasError) {
//                                                 return const Text('Error');
//                                               } else if (snapshot.hasData) {
//                                                 return    Padding(
//                   padding: const EdgeInsets.only(top:8.0),
//                   child: Stack(
//                     children: [
                     
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Column(
//                             children: [
//                               Container( decoration: BoxDecoration(
//                                                       border: Border.all(
//                                                           color: Colors
//                                                               .greenAccent),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15)),
//                                 height: 120,
//                                 width: 120,
//                                 child: SfCircularChart(
//                                     tooltipBehavior: _NewsChanneltooltipBehavior1,
//                                     palette: [
//                                       Color.fromRGBO(0, 142, 70,0),
//                                       Color.fromRGBO(255, 255, 0,0),
//                                       Color.fromRGBO(236, 13, 195,0),
//                                     ],
//                                     series: <PieSeries<ChartSampleData, String>>[
//                                       PieSeries<ChartSampleData, String>(
//                                           explode: true,
//                                           explodeIndex: 0,
//                                           explodeOffset: '10%',
//                                           dataSource: <ChartSampleData>[
//                                             ...NewsChannelPiegraphChartData
//                                             // ChartSampleData(
//                                             //     x: 'David', y: 13, text: 'Dav \n 13%'),
//                                             // ChartSampleData(
//                                             //     x: 'Steve', y: 24, text: 'Ste\n 24%'),
//                                             // ChartSampleData(
//                                             //     x: 'Jack', y: 25, text: 'Jack \n 25%'),
//                                             // ChartSampleData(
//                                             //     x: 'Others', y: 38, text: 'Other \n 38%'),
//                                           ],
//                                           xValueMapper: (ChartSampleData data, _) =>
//                                           data.x as String,
//                                           yValueMapper: (ChartSampleData data, _) =>
//                                           data.y,
//                                           dataLabelMapper:
//                                               (ChartSampleData data, _) => data.text,
//                                           startAngle: 90,
//                                           endAngle: 90,
//                                           dataLabelSettings: const DataLabelSettings(
//                                               isVisible: true)),
//                                     ]),
//                               ),
//                               Text(
//                                 'Likes',
//                                 style: TextStyle(fontSize: 10),
//                               ),
//                             ],
//                           ),
//                          Padding(
//                                     padding: const EdgeInsets.only(top: 35.0),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Text(NewsChannelBarGraphdata['lead'][0]),
//                                             Image.asset('assets/new Updated images/image_2023_07_12T10_18_35_331Z.png',height: 30,)
//                                           ],
//                                         ),
//                                         Column(
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Image.asset('assets/new Updated images/image_2023_07_12T10_18_25_781Z.png',height: 30,),
//                                                 Text('TDP'),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                           Column(
//                             children: [
//                              Container(decoration: BoxDecoration(
//                                                       border: Border.all(
//                                                           color: Colors
//                                                               .greenAccent),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15)),
//                                           height: 120,
//                                           width: 120,
//                                           child: SfFunnelChart(palette: [
//                                             Color.fromRGBO(0, 142, 70,0),
//                                             Color.fromRGBO(255, 255, 0,0),
//                                             Color.fromRGBO(236, 13, 195,0),
//                                           ],
//                                               //title: ChartTitle(text: isCardView ? '' : 'Website conversion rate'),
//                                               tooltipBehavior:
//                                               TooltipBehavior(enable: true),
//                                               series: FunnelSeries<ChartSampleData,
//                                                   String>(
//                                                   dataSource: <ChartSampleData>[
//                                                     ...NewsChannelFunnelgraphChartData,
//                                                   ],
//                                                   xValueMapper:
//                                                       (ChartSampleData data, _) =>
//                                                   data.x as String,
//                                                   yValueMapper:
//                                                       (ChartSampleData data, _) =>
//                                                   data.y,
//                                                   /*  explode: isCardView ? false : explode,
//                     gapRatio: isCardView ? 0 : gapRatio,*/
//                                                   neckHeight: /*isCardView ? */
//                                                   '20%' /*: neckHeight.toString()*/ +
//                                                       '%',
//                                                   neckWidth: /*isCardView ?*/
//                                                   '25%' /*: neckWidth.toString()*/ +
//                                                       '%',
//                                                   dataLabelSettings:
//                                                   const DataLabelSettings(textStyle: TextStyle(fontSize: 8 ),
//                                                       isVisible: true)))),
//                               Text(
//                                 'Comments',
//                                 style: TextStyle(fontSize: 10),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
                 
//                       Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 5.0,top: 60),
//                                     child: Image.asset(
//                                       'assets/new Updated images/img.png',
//                                       height: 29,
//                                       width: 29,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 140.0,left: 5),
//                                     child: Container(
//                                       height: 100,
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
//                                                 text: NewsChannelBarGraphdata['lead'][0],
//                                                 style: new TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.green,
//                                                     fontSize: 20,
//                                                     fontFamily: 'Segoe UI')),
//                                             TextSpan(
//                                                 text:
//                                                 ' is overpowering ',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 18,
//                                                     fontFamily: 'Segoe UI')),
//                                             TextSpan(
//                                                 text: "Multiple Parties",
//                                                 style: new TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     //color: Colors.red,
//                                                     fontSize: 18,
//                                                     fontFamily: 'Segoe UI')),
//                                             TextSpan(
//                                                 text:
//                                                 ' in all aspects.',
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
//                                         padding: const EdgeInsets.only(top: 100.0),
//                                         child:Container(decoration: BoxDecoration(
//                                                       border: Border.all(
//                                                           color: Colors
//                                                               .greenAccent),
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
//                                                       labelStyle: const TextStyle(
//                                                           color: Colors.black, fontSize: 8),
//                                                       axisLine: const AxisLine(width: 0),
//                                                       labelPosition:
//                                                       ChartDataLabelPosition.outside,
//                                                       majorTickLines:
//                                                       const MajorTickLines(width: 0),
//                                                       majorGridLines:
//                                                       const MajorGridLines(width: 0),
//                                                     ),
//                                                     primaryYAxis: NumericAxis(
//                                                         labelStyle: const TextStyle(
//                                                             color: Colors.black, fontSize: 8),
//                                                         labelPosition:
//                                                         ChartDataLabelPosition.outside,
//                                                         isVisible: false,
//                                                         minimum: 0,
//                                                         maximum: 800),
//                                                     series: <ColumnSeries<ChartSampleData,
//                                                         String>>[
//                                                       ColumnSeries<ChartSampleData, String>(
//                                                         width: 0.9,
//                                                         dataLabelSettings:
//                                                         const DataLabelSettings(
//                                                             isVisible: false,
//                                                             labelAlignment:
//                                                             ChartDataLabelAlignment.top),
//                                                         dataSource: <ChartSampleData>[
//                                                           ...NewsChannelBargraphChartdata
//                                                         ],
//                                                         borderRadius: BorderRadius.circular(10),
//                                                         xValueMapper:
//                                                             (ChartSampleData sales, _) =>
//                                                         sales.x as String,
//                                                         yValueMapper:
//                                                             (ChartSampleData sales, _) => sales.y,
//                                                       ),
//                                                     ],
//                                                     tooltipBehavior: _NewsChanneltooltipBehavior,
//                                                   ),
//                                                 ),
//                                       ),
//                                       Text(
//                                         'Views',
//                                         style: TextStyle(fontSize: 10),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
                      
//                     ],
//                   ),
//                 );
//                                               } else {
//                                                 return const Text('Empty data');
//                                               }
//                                             } else {
//                                               return Text('State: ${snapshot.connectionState}');
//                                             }
//                                           },
//                                         ),
                
                
              
//               ),
//             ),
//           )
//         ]);
//   }

//   //Bar Graph data
//   var NewsChannelBarGraphdata;

//   Map NewschannelSelectionquery1 = new Map<String, dynamic>();
//   List<ChartSampleData> NewsChannelBargraphChartdata = [];
//   List<ChartSampleData> NewsChannelPiegraphChartData = [];
//   List<ChartSampleData> NewsChannelFunnelgraphChartData = [];
//   Future<dynamic> NewsChannelBannerGraphApi() async {
//     var body = json.encode({
//     "type": "party_data",
//     "STATE": 'ANDHRA PRADESH',
//     "party_list": 'TDP, YSRCP, TRS',
//     "social_handle": "NEWS_CHANNEL"
//     });
//     var headers = {'Content-Type': 'application/json'};
//     var response = await post(
//         Uri.parse('http://idxp.pilogcloud.com:6659/social_media_YT/'),
//         headers: headers,
//         body: body);

//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print('inside loop');
//       try {
//         print('inside try');
//         NewsChannelBarGraphdata = jsonDecode(utf8.decode(response.bodyBytes));
//         setState(() {
//           NewsChannelBarGraphdata['party_data'].forEach((key, value) {
//             print(key);

//             NewsChannelBargraphChartdata.add(
//               ChartSampleData(
//                   x: '$key', y: NewsChannelBarGraphdata['party_data'][key][0]['LIKES']),
//             );
//             NewsChannelPiegraphChartData.add(
//               ChartSampleData(
//                   x: '$key',
//                   y: NewsChannelBarGraphdata['party_data'][key][0]['COMMENTS'],
//                   text: '$key'),
//             );
//             NewsChannelFunnelgraphChartData.add(
//               ChartSampleData(
//                   x: '$key',
//                   y: NewsChannelBarGraphdata['party_data'][key][0]['VIEWS'],
//                   text: '$key'),
//             );
//           });

//           // for(int i=0;i<NewsChannelBarGraphdata['party_data'])
//           // NewsChannelBargraphChartdata.add(ChartSampleData(x: 'TDP', y: 8683),);
//         });
//         print('data here');
//         print(NewsChannelBarGraphdata);
//       } catch (e) {
//         print(NewsChannelBarGraphdata);
//       }
//     } else {
//       print(response.reasonPhrase);
//     }
//     return NewsChannelBarGraphdata;
//   }
// }








