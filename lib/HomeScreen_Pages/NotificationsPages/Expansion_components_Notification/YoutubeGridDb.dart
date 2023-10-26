import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:pluto_grid/pluto_grid.dart';

class YoutubeGridDb extends StatefulWidget {
  var Hashtag;
  var Griddata;
  YoutubeGridDb(this.Hashtag, {Key? key}) : super(key: key);

  @override
  State<YoutubeGridDb> createState() => _YoutubeGridDbState();
}

class _YoutubeGridDbState extends State<YoutubeGridDb> {
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
    if (Griddata == null || Griddata['grid_data'] == null)
      return Container(height: 0, width: 0);

    List<PlutoColumn> columns = [
     /* PlutoColumn(
        enableEditingMode: false,
        title: 'Twitter Id',
        field: 'Grid_ID',
        type: PlutoColumnType.text(),
      ),*/
      PlutoColumn(textAlign: PlutoColumnTextAlign.left,
        enableEditingMode: false,
        title: 'Published Date',
        field: 'Grid_Published_Date',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Published Time',
        field: 'Grid_Published_Time',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Title Content',
        field: 'Grid_Title_Content',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Handler Name',
        field: 'Grid_Handler_Name',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(textAlign: PlutoColumnTextAlign.right,
        enableEditingMode: false,
        title: 'Likes Count',
        field: 'Grid_Likes',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(textAlign: PlutoColumnTextAlign.right,
        enableEditingMode: false,
        title: 'Views Count',
        field: 'Grid_Views',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(textAlign: PlutoColumnTextAlign.right,
        enableEditingMode: false,
        title: 'Dislikes Count',
        field: 'Grid_DisLikes',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(textAlign: PlutoColumnTextAlign.right,
        enableEditingMode: false,
        title: 'Comments Count',
        field: 'Grid_Comments',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Media Types',
        field: 'Grid_Media_Types',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Title Sentiment',
        field: 'Grid_Title_Sentiment',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(textAlign: PlutoColumnTextAlign.right,
        enableEditingMode: false,
        title: 'Positive Sentiment',
        field: 'Grid_Positive_Sentiment',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(textAlign: PlutoColumnTextAlign.right,
        enableEditingMode: false,
        title: 'Negative Sentiment',
        field: 'Grid_Negative_Sentiment',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(textAlign: PlutoColumnTextAlign.right,
        enableEditingMode: false,
        title: 'Neutral Sentiment',
        field: 'Grid_Neutral_Sentiment',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Party Name',
        field: 'Grid_Party_Name',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableEditingMode: false,
        title: 'Key Words',
        field: 'Grid_Key_Words',
        type: PlutoColumnType.text(),
      ),
    ];
    List<PlutoRow> rows = Griddata['grid_data']
        .map<PlutoRow>((item) => PlutoRow(cells: {
     // 'Grid_ID': PlutoCell(value: item['TWEET_ID'] ?? ''),
      'Grid_Published_Date': PlutoCell(value: item['PUBLISHED_DATE'] ?? ''),
      'Grid_Published_Time': PlutoCell(value: item['PUBLISHED_TIME'] ?? ''),
      'Grid_Title_Content': PlutoCell(value: item['TITLE_CONTENT'] ?? ''),
      'Grid_Handler_Name': PlutoCell(value: item['HANDLER_NAME'] ?? ''),
      'Grid_Likes': PlutoCell(value: item['LIKES_COUNT'] ?? ''),
      'Grid_Views': PlutoCell(value: item['VIEWS_COUNT'] ?? ''),
      'Grid_DisLikes': PlutoCell(value: item['DISLIKES_COUNT'] ?? ''),
      'Grid_Comments': PlutoCell(value: item['COMMENTS_COUNT'] ?? ''),
      'Grid_Media_Types': PlutoCell(value: item['CONTENT_TYPE'] ?? ''),
      'Grid_Title_Sentiment': PlutoCell(value: item['TRANSLATED_SENTIMENT_RESULT'] ?? ''),
      'Grid_Positive_Sentiment': PlutoCell(value: item['POSTIVE_SENTIMENT_COUNT'] ?? ''),
      'Grid_Negative_Sentiment': PlutoCell(value: item['NEGATIVE_SENTIMENT_COUNT'] ?? ''),
      'Grid_Neutral_Sentiment': PlutoCell(value: item['NEUTRAL_SENTIMENT_COUNT'] ?? ''),
      'Grid_Party_Name': PlutoCell(value: item['CANDIDATE_PARTY_NAME'] ?? ''),
      'Grid_Key_Words': PlutoCell(value: item['KEY_WORDS'] ?? ''),
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
      query['candidate_name'] = '${widget.Hashtag}';
      query['channel'] = 'YOUTUBE';
      query['type'] = 'channel_videos';
    });

    var response = await post(
        Uri.parse('http://idxp.pilogcloud.com:6656/active_youtube_channel/'),
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
