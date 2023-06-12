import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/views/category/category_details/category_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget featuredButton({String? title, icon}) {
  return InkWell(
    onTap: () {
      Get.to(() => CategoryDetails(title: title));
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(4),
      width: Get.width * 0.5,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Image.asset(icon, width: 60, fit: BoxFit.fill),
          const SizedBox(height: 10),
          Text(title ?? "",
              style:
                  const TextStyle(fontFamily: semibold, color: darkFontGrey)),
        ],
      ),
    ),
  );
}
