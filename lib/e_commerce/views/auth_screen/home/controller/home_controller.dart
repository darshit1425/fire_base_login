import 'package:fire_base_login/e_commerce/firebase/firebase_consts/firebase_consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var username = '';

  var featuredList = [];

  var searchController = TextEditingController();

  getUsername() async {
    var n = await firestore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    username = n;
    // print("USERNAME=====>>>>>${username}");
  }

  // RxInt current = 1.obs;
  // Rx<ModelClass>? modelClass1;
  // Rx<ModelClass> modelClass = ModelClass(a: "a", b: "b").obs;

  // Rx<int> a = 0.obs;

  // increament() {
  //   print("INCREMENT CALLED....");
  //   a.value++;
  // }
  //
  // decreament() {
  //   print("DECREAMENT CALLED....");
  //   a.value--;
  // }
}

// class ModelClass {
//   String a;
//   String b;
//   ModelClass({required this.a, required this.b});
// }
