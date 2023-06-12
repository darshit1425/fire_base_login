import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:flutter/material.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Container(
    padding: EdgeInsets.all(4),
    width: width,
    height: 70,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(6)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(count ?? "",
            style:
                TextStyle(fontSize: 16, color: darkFontGrey, fontFamily: bold)),
        SizedBox(height: 5),
        Text(title ?? "", style: TextStyle(color: darkFontGrey)),
      ],
    ),
  );
}
