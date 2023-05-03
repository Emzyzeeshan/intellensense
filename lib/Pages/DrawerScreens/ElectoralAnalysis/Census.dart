import 'package:flutter/material.dart';

class Census extends StatefulWidget {
  const Census({super.key});

  @override
  State<Census> createState() => _CensusState();
}

class _CensusState extends State<Census> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('Census')],
    );
  }
}
