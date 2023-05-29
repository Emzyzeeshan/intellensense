import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


Position? _currentPosition;
SliverAppBar createSilverAppBar2() {
  return SliverAppBar(
  forceElevated: true,
    leading: Text(''),
    backgroundColor: Color(0xffd2dfff),
    pinned: true,
    flexibleSpace: Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Container(
        height: 40,
        child: TextFormField(
            decoration: InputDecoration(
              isDense: true,
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () {
            },
            icon: Icon(
              Icons.search_outlined,
              color: Colors.black,
            ),
          ),
          hintText: 'Search...',
          filled: true,
          fillColor: Colors.blue.shade100,
        )),
      ),
    ),
  );
}

bool viewnews = false;
