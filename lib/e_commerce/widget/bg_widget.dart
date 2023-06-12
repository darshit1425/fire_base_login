
import 'package:fire_base_login/e_commerce/consts/images.dart';
import 'package:flutter/material.dart';

Widget bgWidget({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
      image:
          DecorationImage(image: AssetImage(imgBackground), fit: BoxFit.fill),
    ),
    child: child,
  );
}
