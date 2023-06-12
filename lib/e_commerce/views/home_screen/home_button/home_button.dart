import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget homeButton(
    {double? width, double? height, icon, String? title, onPress}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black26)]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: Get.width * 0.07,
        ),
        SizedBox(height: 5),
        Text(title!,
            style: TextStyle(fontFamily: semibold, color: darkFontGrey)),
      ],
    ),
  );
}
