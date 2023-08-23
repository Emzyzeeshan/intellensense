import 'package:flutter/material.dart';

import '../../../../Constants/constants.dart';

class Header extends StatelessWidget {
  final Animation<double> animation;

  const Header({
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);

            },icon: Icon(Icons.arrow_back_ios),color: Colors.black,),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Image.asset(
                'assets/icons/IntelliSense-Logo-Finall_01022023_A.gif',
                height: 90,
              ),
              const SizedBox(height: kSpaceM),
            ],
          ),
        ),
      ],
    );
  }
}
