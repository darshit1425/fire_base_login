import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:flutter/material.dart';

Widget customTextFiled(
    {String? title, String? hint, controller, keyBoardType, isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title ?? "",
          style:
              TextStyle(color: Colors.red, fontFamily: semibold, fontSize: 16)),
      SizedBox(height: 5),
      TextFormField(
        obscureText: isPass,
        controller: controller,
        keyboardType: keyBoardType ?? TextInputType.text,
        decoration: InputDecoration(
          hintStyle: TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
      SizedBox(height: 5),
    ],
  );
}
