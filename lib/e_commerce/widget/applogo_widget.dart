import 'package:fire_base_login/e_commerce/consts/images.dart';
import 'package:flutter/material.dart';

Widget appLogoWidget() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Image.asset(
      icAppLogo,
      width: 77,
      height: 77,
      color: Colors.white,
      fit: BoxFit.fill,
    ),
  );
      //.box.white.size(77, 77).padding(EdgeInsets.all(8)).rounded.make();
}
