import 'package:flutter/material.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  final VoidCallback onSkip;

  const Header({
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset('assets/icons/IntelliSense-Logo-Finall_01022023_A.gif',height: 60,color: Colors.white,),
        /*const Logo(
          color: kWhite,
          size: 32.0,
        ),*/
        GestureDetector(
          onTap: onSkip,
          child: Text(
            'Skip',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: kWhite,
                ),
          ),
        ),
      ],
    );
  }
}
