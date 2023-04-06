import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:lottie/lottie.dart';

Position? _currentPosition;
SliverAppBar createSilverAppBar2() {
  return SliverAppBar(
    toolbarHeight: 50,
    leading: Container(),
    backgroundColor: Color(0xffd2dfff),
    pinned: true,
    flexibleSpace: Padding(
      padding: const EdgeInsets.only(
        top: 35.0,
        left: 10,
        right: 10,
      ),
      child: Container(
        height: 50,
        child: TextFormField(
            decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () {},
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
