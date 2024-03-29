import 'dart:convert';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import 'package:pluto_grid/pluto_grid.dart';
import 'package:skeletons/skeletons.dart';

class Census extends StatefulWidget {
  @override
  State<Census> createState() => _CensusState();
}

class _CensusState extends State<Census> {
  List<TableRow> _CensusTabledata = [];
  late final PlutoGridOnLoadedEvent loded;
  final List<PlutoRow> fakeFetchedRows = [];

  Future<PlutoLazyPaginationResponse> fetch(
    PlutoLazyPaginationRequest request,
  ) async {
    List<PlutoRow> tempList = fakeFetchedRows;

    if (request.filterRows.isNotEmpty) {
      final filter = FilterHelper.convertRowsToFilter(
        request.filterRows,
        stateManager!.refColumns,
      );

      tempList = fakeFetchedRows.where(filter!).toList();
    }

    if (request.sortColumn != null && !request.sortColumn!.sort.isNone) {
      tempList = [...tempList];

      tempList.sort((a, b) {
        final sortA = request.sortColumn!.sort.isAscending ? a : b;
        final sortB = request.sortColumn!.sort.isAscending ? b : a;

        return request.sortColumn!.type.compare(
          sortA.cells[request.sortColumn!.field]!.valueForSorting,
          sortB.cells[request.sortColumn!.field]!.valueForSorting,
        );
      });
    }

    final page = request.page;
    const pageSize = 100;
    final totalPage = (tempList.length / pageSize).ceil();
    final start = (page - 1) * pageSize;
    final end = start + pageSize;

    Iterable<PlutoRow> fetchedRows = tempList.getRange(
      max(0, start),
      min(tempList.length, end),
    );

    await Future.delayed(const Duration(milliseconds: 500));

    return Future.value(PlutoLazyPaginationResponse(
      totalPage: totalPage,
      rows: fetchedRows.toList(),
    ));
  }

  late Future<dynamic> _value1 = StateoverviewAPI();
  late Future<dynamic> _value2 = DistrictoverviewAPI();
  late Future<dynamic> _value3 = SubDistrictoverviewAPI();
  late Future<dynamic> statenamedata = CensusStateNamesAPI();
  late Future<dynamic> Districtnamedata = CensusDistrictNamesAPI();
  late Future<dynamic> SubDistrictnamedata = CensusSubDistrictNamesAPI();
  // late Future<dynamic> villagenamedata = CensusVillageNamesAPI();
  List<TableRow> StateoverviewTabledata = [];

  String? input1 = 'TELANGANA';
  String? input2 = 'Select District';
  String? SUB_DISTRICT;
  String? Village;
  List Statelist = [];
  List Districtlist = [];
  List Subdistrictlist = [];
  // List Villagelist = [];
  PlutoGridStateManager? stateManager;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
                      return Center(
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Center(
                              child: SpinKitWave(
                            color: Colors.blue,
                            size: 18,
                          )),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.47,
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
                                  Subdistrictdataloaded = false;
                                  districtdataloaded = false;
                                  input1 = value as String;
                                  Districtlist.clear();
                                  print(input1);
                                  districtvisible == true
                                      ? Districtnamedata =
                                          CensusDistrictNamesAPI()
                                      : null;
                                  SUB_DISTRICT = 'Select Sub District';
                                  Subdistrictlist.clear();
                                  _CensusTabledata.clear();
                                  StateoverviewTabledata.clear();
                                  _value1 = StateoverviewAPI();
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
                  width: MediaQuery.of(context).size.width * 0.47,
                  child: FutureBuilder<dynamic>(
                    future: Districtnamedata,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: Center(
                                child: SpinKitWave(
                              color: Colors.blue,
                              size: 18,
                            )),
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          return DropdownButtonHideUnderline(
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
                                          style: const TextStyle(),
                                        ),
                                      )).toList(),
                              value: input2,
                              onChanged: (value) {
                                setState(() {
                                  Subdistrictdataloaded = false;
                                  _DistrictTabledata.clear();
                                  districtdataloaded = true;
                                  input2 = value as String;
                                  print(input2);
                                  districtloaded == true
                                      ? SubDistrictnamedata =
                                          CensusSubDistrictNamesAPI()
                                      : null;
                                  _value2 = DistrictoverviewAPI();
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
            SizedBox(
              height: 5,
            ),

            SizedBox(
              height: 10,
            ),
            //sub district
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.47,
                  child: FutureBuilder<dynamic>(
                    future: SubDistrictnamedata,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: Center(
                                child: SpinKitWave(
                              color: Colors.blue,
                              size: 18,
                            )),
                          ),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Text(
                                '${SUB_DISTRICT}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items:
                                  Subdistrictlist.map<DropdownMenuItem<String>>(
                                      (itemm) => DropdownMenuItem<String>(
                                            value: itemm.toString(),
                                            child: Text(
                                              itemm,
                                              style: const TextStyle(),
                                            ),
                                          )).toList(),
                              value: SUB_DISTRICT,
                              onChanged: (value) {
                                setState(() {
                                  Subdistrictdataloaded = true;
                                  districtdataloaded = false;
                                  _SubDistrictTabledata.clear();
                                  SUB_DISTRICT = value as String;
                                  print(SUB_DISTRICT);
                                  // Subdistrictloaded == true
                                  //     ? villagenamedata =
                                  //         CensusVillageNamesAPI()
                                  //     : null;
                                  _value3 = SubDistrictoverviewAPI();
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
                // Spacer(),
                // //village
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.47,
                //   child: FutureBuilder<dynamic>(
                //     future: villagenamedata,
                //     builder: (
                //       BuildContext context,
                //       AsyncSnapshot<dynamic> snapshot,
                //     ) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return SkeletonParagraph(
                //           style: SkeletonParagraphStyle(
                //               lines: 1,
                //               lineStyle: SkeletonLineStyle(
                //                 height: 30,
                //                 width: MediaQuery.of(context).size.width * 0.42,
                //                 borderRadius: BorderRadius.circular(8),
                //                 // minLength: MediaQuery.of(context).size.width / 6,
                //                 // maxLength: MediaQuery.of(context).size.width / 3,
                //               )),
                //         );
                //       } else if (snapshot.connectionState ==
                //           ConnectionState.done) {
                //         if (snapshot.hasError) {
                //           return const Text('Error');
                //         } else if (snapshot.hasData) {
                //           return DropdownButtonHideUnderline(
                //             child: DropdownButton2(
                //               isExpanded: true,
                //               hint: Text(
                //                 '${Village}',
                //                 style: TextStyle(
                //                   fontSize: 12,
                //                   color: Theme.of(context).hintColor,
                //                 ),
                //               ),
                //               items: Villagelist.map<DropdownMenuItem<String>>(
                //                   (itemm) => DropdownMenuItem<String>(
                //                         value: itemm.toString(),
                //                         child: Text(
                //                           itemm,
                //                           style: const TextStyle(),
                //                         ),
                //                       )).toList(),
                //               value: Village,
                //               onChanged: (value) {
                //                 setState(() {
                //                   Village = value as String;
                //                   print(Village);
                //                 });
                //               },
                //               buttonStyleData: const ButtonStyleData(
                //                 padding: EdgeInsets.all(6),
                //                 decoration: BoxDecoration(
                //                     color: Color.fromARGB(255, 245, 239, 239),
                //                     borderRadius: BorderRadius.only(
                //                         topRight: Radius.circular(15),
                //                         bottomLeft: Radius.circular(15),
                //                         bottomRight: Radius.circular(15),
                //                         topLeft: Radius.circular(15))),
                //                 height: 40,
                //               ),
                //               dropdownStyleData: const DropdownStyleData(
                //                 maxHeight: 200,
                //               ),
                //               menuItemStyleData: const MenuItemStyleData(
                //                 height: 40,
                //               ),
                //               isDense: true,
                //             ),
                //           );
                //         } else {
                //           return const Text('Empty data');
                //         }
                //       } else {
                //         return Text('State: ${snapshot.connectionState}');
                //       }
                //     },
                //   ),
                // ),
              ],
            ),

            SizedBox(
              height: 20,
            ),

            districtdataloaded == false && Subdistrictdataloaded == false
                ? FutureBuilder<dynamic>(
                    future: _value1,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    color: Color(0xffd2dfff),
                                    elevation: 10,
                                    child: Center(
                                      child: SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Center(
                                            child: SpinKitWave(
                                          color: Colors.blue,
                                          size: 18,
                                        )),
                                      ),
                                    ))),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Color(0xffd2dfff),
                                elevation: 10,
                                child: Center(
                                    child: SpinKitWave(
                                  color: Colors.blue,
                                  size: 18,
                                )),
                              ),
                            )
                          ],
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          return GridDate();
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    },
                  )
                : Container(),

            districtdataloaded == true
                ? FutureBuilder<dynamic>(
                    future: _value2,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    color: Color(0xffd2dfff),
                                    elevation: 10,
                                    child: Center(
                                      child: SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Center(
                                            child: SpinKitWave(
                                          color: Colors.blue,
                                          size: 18,
                                        )),
                                      ),
                                    ))),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Color(0xffd2dfff),
                                elevation: 10,
                                child: Center(
                                    child: SpinKitWave(
                                  color: Colors.blue,
                                  size: 18,
                                )),
                              ),
                            )
                          ],
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          return DistrictData();
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    },
                  )
                : Container(),
            Subdistrictdataloaded == true
                ? FutureBuilder<dynamic>(
                    future: _value3,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    color: Color(0xffd2dfff),
                                    elevation: 10,
                                    child: Center(
                                      child: SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Center(
                                            child: SpinKitWave(
                                          color: Colors.blue,
                                          size: 18,
                                        )),
                                      ),
                                    ))),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Color(0xffd2dfff),
                                elevation: 10,
                                child: Center(
                                    child: SpinKitWave(
                                  color: Colors.blue,
                                  size: 18,
                                )),
                              ),
                            )
                          ],
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else if (snapshot.hasData) {
                          return SubDistrictData();
                        } else {
                          return const Text('Empty data');
                        }
                      } else {
                        return Text('State: ${snapshot.connectionState}');
                      }
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  GridDate() {
    if (SateOverviewdata == null || SateOverviewdata['STATE_AGG_DATA'] == null)
      return Container(height: 0, width: 0);

    List<PlutoColumn> columns = [
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.left,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'DISTRICT',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'DISTRICT',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'DISTRICT',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL HOUSEHOLDS',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL HOUSEHOLDS',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_HOUSEHOLDS',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL POPULATION',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL POPULATION',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_POPULATION',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL POP MALE',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL POP MALE',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_POP_MALE',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL POP FEMALE',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL POP FEMALE',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_POP_FEMALE',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'SC POPULATION',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'SC POPULATION',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'SC_POPULATION',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'ST POPULATION',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'ST POPULATION',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'ST_POPULATION',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'LITERATES',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'LITERATES',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'LITERATES',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'ILLITERATES',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'ILLITERATES',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'ILLITERATES',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL WORKERS',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL WORKERS',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_WORKERS',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'CULTIVATORS',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'CULTIVATORS',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'CULTIVATORS',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.right,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'AGRICULTURAL LABOURS',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'AGRICULTURAL LABOURS',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'AGRICULTURAL_LABOURS',
        type: PlutoColumnType.text(),
      ),
    ];
    List<PlutoRow> rows = SateOverviewdata['STATE_AGG_DATA']
        .map<PlutoRow>((item) => PlutoRow(
        
        cells: {
              'DISTRICT': PlutoCell(value: item['DISTRICT'] ?? ''),
              'TOTAL_HOUSEHOLDS':
                  PlutoCell(value: item['TOTAL_HOUSEHOLDS'] ?? ''),
              'TOTAL_POPULATION':
                  PlutoCell(value: item['TOTAL_POPULATION'] ?? ''),
              'TOTAL_POP_MALE': PlutoCell(value: item['TOTAL_POP_MALE'] ?? ''),
              'TOTAL_POP_FEMALE':
                  PlutoCell(value: item['TOTAL_POP_FEMALE'] ?? ''),
              'SC_POPULATION': PlutoCell(value: item['SC_POPULATION'] ?? ''),
              'ST_POPULATION': PlutoCell(value: item['ST_POPULATION'] ?? ''),
              'LITERATES': PlutoCell(value: item['LITERATES'] ?? ''),
              'ILLITERATES': PlutoCell(value: item['ILLITERATES'] ?? ''),
              'TOTAL_WORKERS': PlutoCell(value: item['TOTAL_WORKERS'] ?? ''),
              'CULTIVATORS': PlutoCell(value: item['CULTIVATORS'] ?? ''),
              'AGRICULTURAL_LABOURS':
                  PlutoCell(value: item['AGRICULTURAL_LABOURS'] ?? ''),
            }))
        .toList();
    return Column(
      children: [
        Card(
            // color: Color(0xffd2dfff),
            elevation: 10,
            child: Table(children: [
              TableRow(children: [
                Container(
                    height: 30,
                    color: Color(0xff86a8e7),
                    child: Center(
                        child: Text(
                      '$input1 ',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ))),
                Container(
                    height: 30,
                    color: Color(0xff86a8e7),
                    child: Center(
                        child: Text(
                      'Census Data',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ))),
              ]),
              ..._CensusTabledata
            ])),
        SizedBox(
          height: 20,
        ),
        Container(
          color: Color(0xffd2dfff),
          height: 450,
          width: 400,
          child: PlutoGrid(
            columns: columns,
            rows: rows,
            onLoaded: (PlutoGridOnLoadedEvent event) {
              setState(() {
                stateManager = event.stateManager;
                stateManager!.setShowColumnFilter(true);
              });
              print(event);
            },
            configuration: const PlutoGridConfiguration(
                style: PlutoGridStyleConfig(
              rowColor: Color(0xffd2dfff),
              borderColor: Colors.grey,
              gridBackgroundColor: Color(0xffd2dfff),
            )),
            createFooter: (stateManager) {
              stateManager.setPageSize(100, notify: false); // default 40
              return PlutoPagination(stateManager);
            },
            /*createFooter: (stateManager) {
              return PlutoLazyPagination(
                // Determine the first page.
                // Default is 1.
                initialPage: 1,

                // First call the fetch function to determine whether to load the page.
                // Default is true.
                initialFetch: false,

                // Decide whether sorting will be handled by the server.
                // If false, handle sorting on the client side.
                // Default is true.
                fetchWithSorting: true,

                // Decide whether filtering is handled by the server.
                // If false, handle filtering on the client side.
                // Default is true.
                fetchWithFiltering: true,

                // Determines the page size to move to the previous and next page buttons.
                // Default value is null. In this case,
                // it moves as many as the number of page buttons visible on the screen.
                pageSizeToMove: 15,
                fetch: fetch,
                stateManager: stateManager,
              );
            },*/
          ),
        ),
      ],
    );
  }

  DistrictData() {
    if (DistrictOverviewdata == null ||
        DistrictOverviewdata['DISTRICT_AGG_DATA'] == null)
      return Container(height: 0, width: 0);

    List<PlutoColumn> columns2 = [
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'SUB-DISTRICT',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'SUB-DISTRICT',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'SUB-DISTRICT',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL HOUSEHOLDS',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL HOUSEHOLDS',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_HOUSEHOLDS',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL POPULATION',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL POPULATION',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_POPULATION',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL POP MALE',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL POP MALE',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_POP_MALE',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL POP FEMALE',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL POP FEMALE',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_POP_FEMALE',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'SC POPULATION',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'SC POPULATION',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'SC_POPULATION',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'ST POPULATION',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'ST POPULATION',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'ST_POPULATION',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'LITERATES',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'LITERATES',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'LITERATES',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'ILLITERATES',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'ILLITERATES',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'ILLITERATES',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL WORKERS',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL WORKERS',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_WORKERS',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'CULTIVATORS',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'CULTIVATORS',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'CULTIVATORS',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'AGRICULTURAL LABOURS',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'AGRICULTURAL LABOURS',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'AGRICULTURAL_LABOURS',
        type: PlutoColumnType.text(),
      ),
    ];
    List<PlutoRow> rows2 = DistrictOverviewdata['DISTRICT_AGG_DATA']
        .map<PlutoRow>((item) => PlutoRow(cells: {
              'SUB-DISTRICT': PlutoCell(value: item['SUB_DISTRICT'] ?? ''),
              'TOTAL_HOUSEHOLDS': PlutoCell(
                value: item['TOTAL_HOUSEHOLDS'] ?? '',
              ),
              'TOTAL_POPULATION':
                  PlutoCell(value: item['TOTAL_POPULATION'] ?? ''),
              'TOTAL_POP_MALE': PlutoCell(value: item['TOTAL_POP_MALE'] ?? ''),
              'TOTAL_POP_FEMALE':
                  PlutoCell(value: item['TOTAL_POP_FEMALE'] ?? ''),
              'SC_POPULATION': PlutoCell(value: item['SC_POPULATION'] ?? ''),
              'ST_POPULATION': PlutoCell(value: item['ST_POPULATION'] ?? ''),
              'LITERATES': PlutoCell(value: item['LITERATES'] ?? ''),
              'ILLITERATES': PlutoCell(value: item['ILLITERATES'] ?? ''),
              'TOTAL_WORKERS': PlutoCell(value: item['TOTAL_WORKERS'] ?? ''),
              'CULTIVATORS': PlutoCell(value: item['CULTIVATORS'] ?? ''),
              'AGRICULTURAL_LABOURS':
                  PlutoCell(value: item['AGRICULTURAL_LABOURS'] ?? ''),
            }))
        .toList();
    return Column(
      children: [
        Card(
            // color: Color(0xffd2dfff),
            elevation: 10,
            child: Table(children: [
              TableRow(children: [
                Container(
                    height: 30,
                    color: Color(0xff86a8e7),
                    child: Row(
                      children: [
                        Text(
                          '$input2 ',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    )),
                Container(
                    height: 30,
                    color: Color(0xff86a8e7),
                    child: Center(
                        child: Text(
                      'Census Data',
                      style: GoogleFonts.nunitoSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ))),
              ]),
              ..._DistrictTabledata
            ])),
        SizedBox(
          height: 20,
        ),
        Container(
          // color: Color(0xffd2dfff),
          height: 450,
          width: 400,
          child: PlutoGrid(
            columns: columns2,
            rows: rows2,
            onLoaded: (PlutoGridOnLoadedEvent event) {
              setState(() {
                stateManager = event.stateManager;
                stateManager!.setShowColumnFilter(true);
              });
              print(event);
            },
            configuration: const PlutoGridConfiguration(
                style: PlutoGridStyleConfig(
              // rowColor: Color(0xffd2dfff),
              borderColor: Colors.grey,
              // gridBackgroundColor: Color(0xffd2dfff),
            )),
            createFooter: (stateManager) {
              stateManager.setPageSize(100, notify: false); // default 40
              return PlutoPagination(stateManager);
            },
            /*createFooter: (stateManager) {
              return PlutoLazyPagination(
                // Determine the first page.
                // Default is 1.
                initialPage: 1,

                // First call the fetch function to determine whether to load the page.
                // Default is true.
                initialFetch: false,

                // Decide whether sorting will be handled by the server.
                // If false, handle sorting on the client side.
                // Default is true.
                fetchWithSorting: true,

                // Decide whether filtering is handled by the server.
                // If false, handle filtering on the client side.
                // Default is true.
                fetchWithFiltering: true,

                // Determines the page size to move to the previous and next page buttons.
                // Default value is null. In this case,
                // it moves as many as the number of page buttons visible on the screen.
                pageSizeToMove: 15,
                fetch: fetch,
                stateManager: stateManager,
              );
            },*/
          ),
        ),
      ],
    );
  }

  SubDistrictData() {
    if (SubDistrictOverviewdata == null ||
        SubDistrictOverviewdata['SUB_DISTRICT_AGG_DATA'] == null)
      return Container(height: 0, width: 0);
    List<PlutoColumn> columns3 = [
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'VILLAGE',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'VILLAGE',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'VILLAGE',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL HOUSEHOLDS',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL HOUSEHOLDS',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_HOUSEHOLDS',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL POPULATION',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL POPULATION',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_POPULATION',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL POP MALE',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL POP MALE',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_POP_MALE',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL POP FEMALE',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL POP FEMALE',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_POP_FEMALE',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'SC POPULATION',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'SC POPULATION',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'SC_POPULATION',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'ST POPULATION',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'ST POPULATION',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'ST_POPULATION',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'LITERATES',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'LITERATES',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'LITERATES',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'ILLITERATES',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'ILLITERATES',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'ILLITERATES',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'TOTAL WORKERS',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'TOTAL WORKERS',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'TOTAL_WORKERS',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'CULTIVATORS',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'CULTIVATORS',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'CULTIVATORS',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        backgroundColor: Color(0xff86a8e7),
        enableEditingMode: false,
        title: 'AGRICULTURAL LABOURS',
        titleSpan: TextSpan(
          children: [
            WidgetSpan(
              child: Center(
                child: Text(
                  'AGRICULTURAL LABOURS',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
        field: 'AGRICULTURAL_LABOURS',
        type: PlutoColumnType.text(),
      ),
    ];
    List<PlutoRow> rows3 = SubDistrictOverviewdata['SUB_DISTRICT_AGG_DATA']
        .map<PlutoRow>((item) => PlutoRow(cells: {
              'VILLAGE': PlutoCell(value: item['VILLAGE'] ?? ''),
              'TOTAL_HOUSEHOLDS':
                  PlutoCell(value: item['TOTAL_HOUSEHOLDS'] ?? ''),
              'TOTAL_POPULATION':
                  PlutoCell(value: item['TOTAL_POPULATION'] ?? ''),
              'TOTAL_POP_MALE': PlutoCell(value: item['TOTAL_POP_MALE'] ?? ''),
              'TOTAL_POP_FEMALE':
                  PlutoCell(value: item['TOTAL_POP_FEMALE'] ?? ''),
              'SC_POPULATION': PlutoCell(value: item['SC_POPULATION'] ?? ''),
              'ST_POPULATION': PlutoCell(value: item['ST_POPULATION'] ?? ''),
              'LITERATES': PlutoCell(value: item['LITERATES'] ?? ''),
              'ILLITERATES': PlutoCell(value: item['ILLITERATES'] ?? ''),
              'TOTAL_WORKERS': PlutoCell(value: item['TOTAL_WORKERS'] ?? ''),
              'CULTIVATORS': PlutoCell(value: item['CULTIVATORS'] ?? ''),
              'AGRICULTURAL_LABOURS':
                  PlutoCell(value: item['AGRICULTURAL_LABOURS'] ?? ''),
            }))
        .toList();
    return Column(children: [
      Card(
          // color: Color(0xffd2dfff),
          elevation: 10,
          child: Table(children: [
            TableRow(children: [
              Container(
                  height: 30,
                  color: Color(0xff86a8e7),
                  child: Center(
                      child: Text(
                    '$SUB_DISTRICT',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ))),
              Container(
                  height: 30,
                  color: Color(0xff86a8e7),
                  child: Center(
                      child: Text(
                    'Census Data',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ))),
            ]),
            ..._SubDistrictTabledata
          ])),
      SizedBox(
        height: 20,
      ),
      Container(
        // color: Color(0xffd2dfff),
        height: 450,
        width: 400,
        child: PlutoGrid(
          columns: columns3,
          rows: rows3,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            setState(() {
              stateManager = event.stateManager;
              stateManager!.setShowColumnFilter(true);
            });
            print(event);
          },
          configuration: const PlutoGridConfiguration(
              style: PlutoGridStyleConfig(
            // rowColor: Color(0xffd2dfff),
            borderColor: Colors.grey,
            // gridBackgroundColor: Color(0xffd2dfff),
          )),
          createFooter: (stateManager) {
            stateManager.setPageSize(100, notify: false); // default 40
            return PlutoPagination(stateManager);
          },
          /*createFooter: (stateManager) {
              return PlutoLazyPagination(
                // Determine the first page.
                // Default is 1.
                initialPage: 1,

                // First call the fetch function to determine whether to load the page.
                // Default is true.
                initialFetch: false,

                // Decide whether sorting will be handled by the server.
                // If false, handle sorting on the client side.
                // Default is true.
                fetchWithSorting: true,

                // Decide whether filtering is handled by the server.
                // If false, handle filtering on the client side.
                // Default is true.
                fetchWithFiltering: true,

                // Determines the page size to move to the previous and next page buttons.
                // Default value is null. In this case,
                // it moves as many as the number of page buttons visible on the screen.
                pageSizeToMove: 15,
                fetch: fetch,
                stateManager: stateManager,
              );
            },*/
        ),
      ),
    ]);
  }

  var CensusStateNamesdata;
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
          SUB_DISTRICT = 'Select Sub-district';

          districtvisible = true;
        });
        Statelist = CensusStateNamesdata['STATE_NAMES'];

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
  var CensusDistrictNamesdata;
  bool districtvisible = false;
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
          districtloaded = true;
          Districtlist = CensusDistrictNamesdata['DISTRICT_NAMES'];
          input2 = Districtlist[0];
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
  var CensusSubDistrictNamesdata;
  bool districtloaded = false;
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
          Subdistrictlist = CensusSubDistrictNamesdata['SUBDISTRICT_NAMES'];
          SUB_DISTRICT = Subdistrictlist[0];
          // Subdistrictloaded = true;
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

  // //Village
  // var CensusVillageNamesdata;
  // bool Subdistrictloaded = false;
  // Map Selectionquery4 = new Map<String, dynamic>();
  // CensusVillageNamesAPI() async {
  //   setState(() {
  //     Selectionquery4['type'] = 'VILLAGE_NAMES';
  //     Selectionquery4['STATE'] = input1.toString();
  //     Selectionquery4['DISTRICT'] = input2.toString();
  //     Selectionquery4['SUB_DISTRICT'] = SUB_DISTRICT.toString();
  //   });
  //   var response = await post(
  //       Uri.parse('http://idxp.pilogcloud.com:6652/electoral_analysis_census/'),
  //       body: Selectionquery4);

  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     try {
  //       setState(() {
  //         CensusVillageNamesdata = json.decode(response.body);
  //         if (CensusVillageNamesdata['VILLAGE_NAMES'].isEmpty) {
  //           Villagelist.add('Select Village');
  //         } else {
  //           Villagelist = CensusVillageNamesdata['VILLAGE_NAMES'];
  //         }

  //         Village = Villagelist[0];
  //       });

  //       print(Village);
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  //   return CensusVillageNamesdata;
  // }

  //District Overview api
  bool districtdataloaded = false;
  var DistrictOverviewdata;
  List<TableRow> _DistrictTabledata = [];
  Map Selectionquery6 = new Map<String, dynamic>();
  DistrictoverviewAPI() async {
    setState(() {
      Selectionquery6['type'] = 'DISTRICT_OVERVIEW';
      Selectionquery6['STATE'] = input1.toString();
      Selectionquery6['DISTRICT'] = input2.toString();
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6652/electoral_analysis_census/'),
        body: Selectionquery6);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        setState(() {
          DistrictOverviewdata = json.decode(response.body);
        });
        DistrictOverviewdata['DISTRICT_OVERVIEW'][0].keys.forEach((key) {
          _DistrictTabledata.add(TableRow(children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '${key}',
                style: GoogleFonts.nunitoSans(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '${DistrictOverviewdata['DISTRICT_OVERVIEW'][0]['${key}']}',
                style: GoogleFonts.nunitoSans(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )),
          ]));
        });

        print(DistrictOverviewdata);
      } catch (e) {
        print(e);
      }
    } else {
      print(response.reasonPhrase);
    }
    return DistrictOverviewdata;
  }

//sub district overview API
  bool Subdistrictdataloaded = false;
  var SubDistrictOverviewdata;
  List<TableRow> _SubDistrictTabledata = [];
  Map Selectionquery7 = new Map<String, dynamic>();
  SubDistrictoverviewAPI() async {
    setState(() {
      Selectionquery6['type'] = 'SUB_DISTRICT_OVERVIEW';
      Selectionquery6['STATE'] = input1.toString();
      Selectionquery6['DISTRICT'] = input2.toString();
      Selectionquery6['SUB_DISTRICT'] = SUB_DISTRICT.toString();
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6652/electoral_analysis_census/'),
        body: Selectionquery6);

    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        setState(() {
          SubDistrictOverviewdata = json.decode(response.body);
        });
        SubDistrictOverviewdata['SUB_DISTRICT_OVERVIEW'][0].keys.forEach((key) {
          _SubDistrictTabledata.add(TableRow(children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '${key}',
                style: GoogleFonts.nunitoSans(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '${SubDistrictOverviewdata['SUB_DISTRICT_OVERVIEW'][0]['${key}']}',
                style: GoogleFonts.nunitoSans(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )),
          ]));
        });

        print(SubDistrictOverviewdata);
      } catch (e) {
        print(e);
      }
    } else {
      print(response.reasonPhrase);
    }
    return SubDistrictOverviewdata;
  }

//State overview data
  var SateOverviewdata;

  Map Selectionquery5 = new Map<String, dynamic>();
  StateoverviewAPI() async {
    setState(() {
      Selectionquery5['type'] = 'STATE_OVERVIEW';
      Selectionquery5['STATE'] = input1.toString();
    });
    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6652/electoral_analysis_census/'),
        body: Selectionquery5);
    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        setState(() {
          SateOverviewdata = json.decode(response.body);
        });

        SateOverviewdata['STATE_OVERVIEW'][0].keys.forEach((key) {
          setState(() {
            _CensusTabledata.add(
              TableRow(children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '${key}',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '${SateOverviewdata['STATE_OVERVIEW'][0]['${key}']}',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            );
          });
        });

        print(SateOverviewdata);
      } catch (e) {
        print(e);
      }
    } else {
      print(response.reasonPhrase);
    }
    return SateOverviewdata;
  }
}
