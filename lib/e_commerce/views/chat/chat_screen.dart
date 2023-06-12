import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_consts/firebase_consts.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_services/firebase_service.dart';
import 'package:fire_base_login/e_commerce/views/chat/controller/chat_controller.dart';
import 'package:fire_base_login/e_commerce/views/chat/sender_bubble.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Text("${controller.friendName}",
            style: TextStyle(color: darkFontGrey, fontFamily: semibold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    )
                  : Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirestoreServices.getChatMessage(
                            controller.chatDocId.toString()),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            );
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text("Send a message....",
                                  style: TextStyle(color: darkFontGrey)),
                            );
                          } else {
                            return ListView(
                              children: snapshot.data!.docs.mapIndexed((currentValue, index) {

                                var data= snapshot.data!.docs[index];

                                return Align(
                                    alignment: data["uid"]==currentUser!.uid?Alignment.centerRight: Alignment.centerLeft,
                                    child: senderBubble(data));
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 80,
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.msgController,
                      decoration: const InputDecoration(
                        hintText: "Type a Message....",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: textfieldGrey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: textfieldGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        controller.sendMsg(controller.msgController.text);
                        controller.msgController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
