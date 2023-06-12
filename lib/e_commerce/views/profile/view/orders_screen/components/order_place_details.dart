import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:flutter/material.dart';


Widget orderPlaceDetails({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${title1}", style: TextStyle(fontFamily: semibold)),
            Text("${d1}",
                style: TextStyle(color: Colors.red, fontFamily: semibold)),
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${title2}", style: TextStyle(fontFamily: semibold)),
              Text("${d2}"),
            ],
          ),
        ),
      ],
    ),
  );
}
