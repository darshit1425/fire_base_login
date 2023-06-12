import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:flutter/material.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: color),
        ),
        child: Icon(icon, color: color)),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: TextStyle(color: darkFontGrey),
          ),
          showDone ? Icon(Icons.done, color: Colors.red) : Container(),
        ],
      ),
    ),
  );
}
