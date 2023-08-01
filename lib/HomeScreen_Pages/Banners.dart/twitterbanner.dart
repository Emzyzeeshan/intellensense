// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:http/http.dart';
// import 'package:intellensense/LoginPages/widgets/ChartSampleData.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class Twitterbanner extends StatefulWidget {
//   const Twitterbanner({Key? key}) : super(key: key);

//   @override
//   State<Twitterbanner> createState() => _TwitterbannerState();
// }

// class _TwitterbannerState extends State<Twitterbanner> {
//   late Future<dynamic> TwitterLineChartfuturecall = TwitterBannerGraphApi();
//   TooltipBehavior? _TwittertooltipBehavior;
//   TooltipBehavior? _TwittertooltipBehavior1;
//   @override
//   void initState() {
   
//     _TwittertooltipBehavior = TooltipBehavior(
//         enable: true,
//         canShowMarker: false,
//         format: 'point.x : point.y',
//         header: '');
//     _TwittertooltipBehavior1 = TooltipBehavior(
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
//                 child: Padding(
//                   padding: const EdgeInsets.only(top:8.0),
//                   child: Stack(
//                     children: [
                      
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Column(
//                             children: [
//                               Container(decoration: BoxDecoration(
//                                                       border: Border.all(
//                                                           color: Colors
//                                                               .blue.shade600),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15)),
//                                 height: 120,
//                                 width: 120,
//                                 child: SfCircularChart(
//                                     tooltipBehavior: _TwittertooltipBehavior1,
//                                     palette: [
//                                       Color.fromRGBO(19, 136, 8, 0),
//                                       Color.fromRGBO(254, 1, 117, 0),
//                                       Color.fromRGBO(249, 125, 9, 0),
//                                     ],
//                                     series: <PieSeries<ChartSampleData, String>>[
//                                       PieSeries<ChartSampleData, String>(
//                                           explode: true,
//                                           explodeIndex: 0,
//                                           explodeOffset: '10%',
//                                           dataSource: <ChartSampleData>[
//                                             ...TwitterPiegraphChartData
                                            
//                                           ],
//                                           xValueMapper:
//                                               (ChartSampleData data, _) =>
//                                                   data.x as String,
//                                           yValueMapper:
//                                               (ChartSampleData data, _) => data.y,
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
//                                 'FOLLOWERS',
//                                 style: TextStyle(fontSize: 10),
//                               ),
//                             ],
//                           ),
//                           FutureBuilder<dynamic>(
//                             future: TwitterLineChartfuturecall,
//                             builder: (
//                                 BuildContext context,
//                                 AsyncSnapshot<dynamic> snapshot,
//                                 ) {
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
//                                   return  Padding(
//                                     padding: const EdgeInsets.only(top: 35.0),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Text(TwiterBarGraphdata['lead'][0]),
//                                             Image.asset('assets/new Updated images/image_2023_07_12T10_18_35_331Z.png',height: 30,)
//                                           ],
//                                         ),
//                                         Column(
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Image.asset('assets/new Updated images/image_2023_07_12T10_18_25_781Z.png',height: 30,),
//                                                 Text('TRS'),
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
//                                 return Text('State: ${snapshot.connectionState}');
//                               }
//                             },
//                           ),
//                           Column(
//                             children: [
//                               FutureBuilder<dynamic>(
//                                 future: TwitterLineChartfuturecall,
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
//                                       return Padding(
//                                         padding: const EdgeInsets.only(right: 8.0),
//                                         child: Container(decoration: BoxDecoration(
//                                                       border: Border.all(
//                                                           color: Colors
//                                                               .blue.shade600),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15)),
//                                             height: 120,
//                                             width: 120,
//                                             child: SfFunnelChart(
//                                                 palette: [
//                                                   Color.fromRGBO(19, 136, 8, 0),
//                                                   Color.fromRGBO(254, 1, 117, 0),
//                                                   Color.fromRGBO(249, 125, 9, 0),
//                                                 ],
//                                                 //title: ChartTitle(text: isCardView ? '' : 'Website conversion rate'),
//                                                 tooltipBehavior:
//                                                     TooltipBehavior(enable: true),
//                                                 series: FunnelSeries<
//                                                         ChartSampleData, String>(
//                                                     dataSource: <ChartSampleData>[
//                                                       ...TwitterFunnelgraphChartData,
//                                                     ],
//                                                     xValueMapper:
//                                                         (ChartSampleData data,
//                                                                 _) =>
//                                                             data.x as String,
//                                                     yValueMapper:
//                                                         (ChartSampleData data,
//                                                                 _) =>
//                                                             data.y,
//                                                     /*  explode: isCardView ? false : explode,
//                     gapRatio: isCardView ? 0 : gapRatio,*/
//                                                     neckHeight: /*isCardView ? */
//                                                         '20%' /*: neckHeight.toString()*/ +
//                                                             '%',
//                                                     neckWidth: /*isCardView ?*/
//                                                         '25%' /*: neckWidth.toString()*/ +
//                                                             '%',
//                                                     dataLabelSettings:
//                                                         const DataLabelSettings(
//                                                             textStyle: TextStyle(
//                                                                 fontSize: 8),
//                                                             isVisible: true)))),
//                                       );
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
//                                 'Re-Tweet',
//                                 style: TextStyle(fontSize: 10),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
           
//                       FutureBuilder<dynamic>(
//                         future: TwitterLineChartfuturecall,
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
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding:
//                                         const EdgeInsets.only(left: 1.0, top: 50),
//                                     child: Image.asset(
//                                       'assets/icons/Social-Media-Icons-IS-08.png',
//                                       height: 18,
//                                       width: 18,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 140.0, left: 5),
//                                     child: Container(
//                                       height: 165,
//                                       width: 165,
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
//                                                     'With Huge Difference In counts for Tweets and Re-Tweets reports says that ',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontFamily: 'Segoe UI')),
//                                             TextSpan(
//                                                 text: TwiterBarGraphdata['lead'][0],
//                                                 style: new TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.green,
//                                                     fontSize: 20,
//                                                     fontFamily: 'Segoe UI')),
//                                             TextSpan(
//                                                 text:
//                                                     ' is relatively Dominant in Twitter Data.',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontFamily: 'Segoe UI')),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Column(mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 100.0),
//                                         child: FutureBuilder<dynamic>(
//                                           future: TwitterLineChartfuturecall,
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
//                                             } else if (snapshot.connectionState ==
//                                                 ConnectionState.done) {
//                                               if (snapshot.hasError) {
//                                                 return const Text('Error');
//                                               } else if (snapshot.hasData) {
//                                                 return Container(decoration: BoxDecoration(
//                                                       border: Border.all(
//                                                           color: Colors
//                                                               .blue.shade600),
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
//                                                           color: Colors.black,
//                                                           fontSize: 8),
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
//                                                                 color:
//                                                                     Colors.black,
//                                                                 fontSize: 8),
//                                                         labelPosition:
//                                                             ChartDataLabelPosition
//                                                                 .outside,
//                                                         isVisible: false,
//                                                         minimum: 0,
//                                                         maximum: 3000),
//                                                     series: <ColumnSeries<
//                                                         ChartSampleData, String>>[
//                                                       ColumnSeries<
//                                                           ChartSampleData,
//                                                           String>(
//                                                         width: 0.9,
//                                                         dataLabelSettings:
//                                                             const DataLabelSettings(
//                                                                 isVisible: false,
//                                                                 labelAlignment:
//                                                                     ChartDataLabelAlignment
//                                                                         .top),
//                                                         dataSource: <ChartSampleData>[
//                                                           ...TwitterBargraphChartdata
//                                                         ],
//                                                         borderRadius:
//                                                             BorderRadius.circular(
//                                                                 10),
//                                                         xValueMapper:
//                                                             (ChartSampleData
//                                                                         sales,
//                                                                     _) =>
//                                                                 sales.x as String,
//                                                         yValueMapper:
//                                                             (ChartSampleData
//                                                                         sales,
//                                                                     _) =>
//                                                                 sales.y,
//                                                       ),
//                                                     ],
//                                                     tooltipBehavior:
//                                                         _TwittertooltipBehavior,
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
//                                         'Likes',
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
//   var TwiterBarGraphdata;

//   Map TwitterSelectionquery1 = new Map<String, dynamic>();
//   List<ChartSampleData> TwitterBargraphChartdata = [];
//   List<ChartSampleData> TwitterPiegraphChartData = [];
//   List<ChartSampleData> TwitterFunnelgraphChartData = [];
//   Future<dynamic> TwitterBannerGraphApi() async {
   
//       TwitterSelectionquery1['type'] = 'party_data';
//       TwitterSelectionquery1['STATE'] = 'TELANGANA';
//       TwitterSelectionquery1['party_list'] = 'INC,TRS,BJP';
//       //Selectionquery['channel'] = 'YOUTUBE';
  
//     var response = await post(
//         Uri.parse('http://idxp.pilogcloud.com:6659/social_media/'),
//         body: TwitterSelectionquery1);

//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print('inside loop');
//       try {
//         print('inside try');
//         TwiterBarGraphdata = jsonDecode(utf8.decode(response.bodyBytes));
       
//           TwiterBarGraphdata['party_data'].forEach((key, value) {
//             print(key);

//             TwitterBargraphChartdata.add(
//               ChartSampleData(
//                   x: '$key', y: TwiterBarGraphdata['party_data'][key][0]['LIKES']),
//             );
//             TwitterPiegraphChartData.add(
//               ChartSampleData(
//                   x: '$key',
//                   y: TwiterBarGraphdata['party_data'][key][0]['USER_FOLLOWERS'],
//                   text: '$key'),
//             );
//             TwitterFunnelgraphChartData.add(
//               ChartSampleData(
//                   x: '$key',
//                   y: TwiterBarGraphdata['party_data'][key][0]['RETWEET_COUNT'],
//                   text: '$key'),
//             );
//           });

//           // for(int i=0;i<TwiterBarGraphdata['party_data'])
//           // TwitterBargraphChartdata.add(ChartSampleData(x: 'TDP', y: 8683),);
       
//         print('data here');
//         print(TwiterBarGraphdata);
//       } catch (e) {
//         print(TwiterBarGraphdata);
//       }
//     } else {
//       print(response.reasonPhrase);
//     }
//     return TwiterBarGraphdata;
//   }
// }
