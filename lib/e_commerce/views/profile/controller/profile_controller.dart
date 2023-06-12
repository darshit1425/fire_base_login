import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_consts/firebase_consts.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {

  var nameController=TextEditingController();
  var passwordController=TextEditingController();

  var profileImgPath = "".obs;
  var profileImgLink = "";
  var isLoading= false.obs;

  changeImage(BuildContext context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      SnackBar(content: Text("Error${e.toString()}"));
    }
  }

  uploadProfileImage() async {
    var filename = base64Decode(profileImgPath.value);
    var destination = "images/${currentUser!.uid}/$filename";
    var FirebaseStorage;
    var reference = FirebaseStorage.instance.ref().child(destination);
    await reference.putFile(File(profileImgPath.value));
    profileImgLink = await reference.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    var store = firestore.collection(userCollection).doc(currentUser!.uid);
    await store.set(
      {
        "name": name,
        "password": password,
        "imageUrl": imgUrl,
      },
      SetOptions(merge: true),
    );
    isLoading(false);
  }
}
