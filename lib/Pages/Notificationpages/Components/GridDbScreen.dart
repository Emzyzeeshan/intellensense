import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:pluto_grid/pluto_grid.dart';

class GridDb extends StatefulWidget {
  var Hashtag;
  var Griddata;
  GridDb(this.Hashtag, {Key? key}) : super(key: key);

  @override
  State<GridDb> createState() => _GridDbState();
}

class _GridDbState extends State<GridDb> {
  late final PlutoGridStateManager stateManager;

  final List<PlutoRow> fakeFetchedRows = [];

  Future<PlutoLazyPaginationResponse> fetch(
    PlutoLazyPaginationRequest request,
  ) async {
    List<PlutoRow> tempList = fakeFetchedRows;

    if (request.filterRows.isNotEmpty) {
      final filter = FilterHelper.convertRowsToFilter(
        request.filterRows,
        stateManager.refColumns,
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

  @override
  void initState() {
    super.initState();
    GridDataApi();
  }
  late Future<dynamic> _value1 = GridDataApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<dynamic>(
        future: _value1,
        builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
            ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: SpinKitWave(
                  color: Colors.blue,
                  size: 18,
                ));
          } else if (snapshot.connectionState == ConnectionState.done) {
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
      ),

      //GridDate(),
    );
  }

  GridDate() {
    if (Griddata == null || Griddata['data'] == null)
      return Container(height: 0, width: 0);

    List<PlutoColumn> columns = [
      PlutoColumn(
        enableEditingMode: false,
        title: 'Twitter Id',
        field: 'Grid_ID',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Type',
        field: 'Grid_Type',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Twitter Content',
        field: 'Grid_Content',
        type: PlutoColumnType.text(),
      ),

      PlutoColumn(
        enableEditingMode: false,
        title: 'Publish Date',
        field: 'Grid_Date',
        type: PlutoColumnType.date(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Published Time',
        field: 'Grid_Time',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'User Handle Name',
        field: 'Grid_UserName',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'User Profile Location',
        field: 'Grid_UserLocation',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Likes',
        field: 'Grid_Likes',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Retweets',
        field: 'Grid_Retweets',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Geo Location',
        field: 'Grid_Location',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Geo Coordination',
        field: 'Grid_Coordinates',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Sentiment',
        field: 'Grid_sentiment',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Country',
        field: 'Grid_Country',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'State',
        field: 'Grid_State',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'District',
        field: 'Grid_District',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Constituency Name',
        field: 'Grid_Constituency',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Candidate Party Name',
        field: 'Grid_PartyName',
        type: PlutoColumnType.text(),
      ),
    ];
    List<PlutoRow> rows = Griddata['data']
        .map<PlutoRow>((item) => PlutoRow(cells: {
              'Grid_ID': PlutoCell(value: item['TWEET_ID'] ?? ''),
              //'record_no': PlutoCell(value: widget.Fetchdata['RECORD_NO']),
              'Grid_Type':
                  PlutoCell(value: item['CONTENT_TYPE'] ?? ''),
              'Grid_Content': PlutoCell(value: item['TITLE_CONTENT'] ?? ''),
              'Grid_Date': PlutoCell(value: item['PUBLISHED_DATE'] ?? ''),
              'Grid_Time': PlutoCell(value: item['PUBLISHED_TIME'] ?? ''),
              'Grid_UserName': PlutoCell(value: item['CANDIDATE_NAME'] ?? ''),
              'Grid_UserLocation': PlutoCell(value: item['USER_PROFILE_LOCATION'] ?? ''),
              'Grid_Likes': PlutoCell(value: item['LIKES_COUNT'] ?? ''),
              'Grid_Retweets': PlutoCell(value: item['RETWEETS_COUNT'] ?? ''),
              'Grid_Location': PlutoCell(value: item['GEO_LOCATION'] ?? ''),
              'Grid_Coordinates': PlutoCell(value: item['GEO_COORDINATES'] ?? ''),
              'Grid_sentiment': PlutoCell(value: item['TRANSLATED_SENTIMENT_RESULT'] ?? ''),
              'Grid_Country': PlutoCell(value: item['LOCATION_COUNTRY'] ?? ''),
              'Grid_State': PlutoCell(value: item['LOCATION_STATE'] ?? ''),
              'Grid_District': PlutoCell(value: item['LOCATION_DISTRICT'] ?? ''),
              'Grid_Constituency': PlutoCell(value: item['LOCATION_CONSTITUENCY'] ?? ''),
              'Grid_PartyName': PlutoCell(value: item['CANDIDATE_PARTY_NAME'] ?? ''),
            }))
        .toList();
    return Column(
      children: [
        Expanded(
            child: Container(
          padding: EdgeInsets.all(2),
              child: PlutoGrid(
                columns: columns,
                rows: rows,
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  stateManager = event.stateManager;
                  stateManager.setShowColumnFilter(true);
                },
                onChanged: (PlutoGridOnChangedEvent event) {

                  print(event);
                },
                configuration: const PlutoGridConfiguration(),
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
        ))
      ],
    );
  }

  var Griddata;
  Map query = new Map<String, dynamic>();
  Future<dynamic> GridDataApi() async {
    setState(() {
      query['HASH_TAG'] = '${widget.Hashtag}';
      query['SOCIAL_MEDIA'] = 'TWITTER';
      query['type'] = 'source_data';
    });

    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6656/twitter_hashtag_data/'),
        body: query);

    if (response.statusCode == 200) {
      setState(() {
        Griddata = jsonDecode(utf8.decode(response.bodyBytes));
      });
      print(Griddata);
    } else {
      print(response.reasonPhrase);
    }
    return Griddata;
  }
}
