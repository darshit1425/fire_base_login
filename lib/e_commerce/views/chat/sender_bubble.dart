import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_consts/firebase_consts.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import '';


Widget senderBubble(DocumentSnapshot data) {
  var t =
      data["created_on"] == null ? DateTime.now() : data["created_on"].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  return Directionality(
    textDirection:
        data["uid"] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding:  EdgeInsets.all(12),
      margin:  EdgeInsets.only(bottom: 8),
      decoration:  BoxDecoration(
        color: data["uid"] == currentUser!.uid ? Colors.red: darkFontGrey,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${data["msg"]}", style: TextStyle(fontSize: 16,color: Colors.white)),
          SizedBox(height: 10),
          Text(
            "11:45 PM",
            style: TextStyle(color: Colors.white.withOpacity(0.5)),
          )
        ],
      ),
    ),
  );
}
