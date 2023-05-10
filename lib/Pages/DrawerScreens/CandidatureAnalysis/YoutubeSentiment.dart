import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class YoutubeSentiment extends StatefulWidget {
  const YoutubeSentiment({super.key});

  @override
  State<YoutubeSentiment> createState() => _YoutubeSentimentState();
}

class _YoutubeSentimentState extends State<YoutubeSentiment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('hi')),
    );
  }
}
