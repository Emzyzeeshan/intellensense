import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class YoutubePivot extends StatefulWidget {


  var Hashtag;
   YoutubePivot(this.Hashtag, {Key? key}) : super(key: key);

  @override
  State<YoutubePivot> createState() => _YoutubePivotState();
}

class _YoutubePivotState extends State<YoutubePivot> {

  static List<Animal> Columns = [
    Animal(id: 1, name: "publishedDate"),
    Animal(id: 2, name: "keyWords"),
    Animal(id: 3, name: "likesCount"),
    Animal(id: 4, name: "handlerName"),
    Animal(id: 5, name: "translatedSentimentResult"),
    Animal(id: 6, name: "postiveSentimentCount"),
    Animal(id: 7, name: "dislikesCount"),
    Animal(id: 8, name: "negativeSentimentCount"),
    Animal(id: 9, name: "publishedTime"),
    Animal(id: 10, name: "viewsCount"),
    Animal(id: 11, name: "commentsCount"),
    Animal(id: 12, name: "candidatePartyName"),
    Animal(id: 13, name: "titleContent"),
    Animal(id: 14, name: "contentType"),
    Animal(id: 15, name: "neutralSentimentCount"),
  ];
  final _items = Columns
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  //List<Animal> _selectedAnimals = [];
  List<Animal> _selectedAnimals2 = [];
  List<Animal> _selectedAnimals3 = [];
  //List<Animal> _selectedAnimals4 = [];
  List<Animal> _selectedAnimals5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selectedAnimals5 = Columns;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              MultiSelectDialogField(
                items: _items,
                title: Text("Animals"),
                selectedColor: Colors.blue,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                buttonIcon: Icon(
                  Icons.arrow_downward,
                  color: Colors.blue,
                ),
                buttonText: Text(
                  "Select Column",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  //_selectedAnimals = results;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Animal {
  final int id;
  final String name;

  Animal({
    required this.id,
    required this.name,
  });
}
