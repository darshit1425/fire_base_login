import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_services/firebase_service.dart';

import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("My Messages",
            style: TextStyle(fontFamily: semibold, color: darkFontGrey)),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text(
              "No messages yet!",
              style: TextStyle(color: darkFontGrey),
            ));
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text("${data[index]["friend_name"]}",
                              style: TextStyle(
                                  fontFamily: semibold, color: darkFontGrey)),
                          subtitle: Text("${data[index]["last_msg"]}"),
                        ),
                      );
                    },
                  ))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
