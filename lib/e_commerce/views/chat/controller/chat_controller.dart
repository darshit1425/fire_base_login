import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_consts/firebase_consts.dart';
import 'package:fire_base_login/e_commerce/views/auth_screen/home/controller/home_controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getChatId();
  }


  var chats=firestore.collection(chatCollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocId;

  var isLoading=false.obs;

  getChatId()async{
    isLoading(true);
    await chats.where("users",isEqualTo: {
      friendId:null,
      currentId:null
    }).limit(1).get().then((QuerySnapshot snapshot) {
      if(snapshot.docs.isNotEmpty){

        chatDocId = snapshot.docs.single.id;
      }else{
        chats.add({
          "created_on": null,
          "last_msg":"",
          "users":{friendId:null, currentId:null},
          "toId":"",
          "fromId":"",
          "friend_name": friendName,
          "sender_name": senderName

        }).then((value) => {
          chatDocId = value.id,
        });
      }
    });
    isLoading(false);
  }

  sendMsg(String msg)async{
    if(msg.trim().isNotEmpty){
      chats.doc(chatDocId).update({
        "created_on": FieldValue.serverTimestamp(),
        "last_msg": msg,
        "toId": friendId,
        "fromId": currentId
      });

      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        "created_on": FieldValue.serverTimestamp(),
        "msg": msg,
        "uid": currentId,
      });
    }else{

    }
  }
}