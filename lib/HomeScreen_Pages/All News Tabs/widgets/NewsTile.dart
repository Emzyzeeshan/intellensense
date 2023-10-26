import 'package:flutter/material.dart';
Widget NewspapertabTile({
  required String title,
  required Widget subtitle,
  required String? image,
void Function()? onTap
}) {
  return ListTile(
    dense: false,
onTap: onTap,
    hoverColor: Colors.green,
    title: Column(
      children: [
        Text(title),
        SizedBox(
          height: 8,
        ),
        subtitle
      ],
    ),
    titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 14),
    // subtitle: subtitle,
    // subtitleTextStyle: TextStyle(
    //     fontWeight: FontWeight.w400, color: Colors.black87, fontSize: 10),
    leading: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  image!
                    )))),
  );
}