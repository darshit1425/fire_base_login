import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_consts/firebase_consts.dart';
import 'package:fire_base_login/e_commerce/views/auth_screen/home/controller/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxInt totalP = 0.obs;
///// text controller for shipping details

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();

  RxInt paymentIndex = 0.obs;

  late dynamic productSnapshot;
  var products = [];

  RxBool placingOrder = false.obs;

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder.value = true;
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      "order_code": "234876451",
      "order_date": FieldValue.serverTimestamp(),
      "order_by": currentUser!.uid,
      "order_by_name": Get.find<HomeController>().username,
      "order_by_email": currentUser!.email,
      "order_by_address": addressController.text,
      "order_by_state": stateController.text,
      "order_by_city": cityController.text,
      "order_by_phone": phoneController.text,
      "order_by_postalcode": postalCodeController.text,
      "shipping_method": "Home Delivery",
      "payment_method": orderPaymentMethod,
      "order_placed": true,
      "order_confirmed": false,
      "order_delivered": false,
      "order_on_delivery": false,
      "total_amount": totalAmount,
      "orders": FieldValue.arrayUnion(products)
    });
    placingOrder.value = false;
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        "color": productSnapshot[i]["color"],
        "img": productSnapshot[i]["img"],
        "baba_id": productSnapshot[i]["baba_id"],
        "tprice": productSnapshot[i]["tprice"],
        "qty": productSnapshot[i]["qty"],
        "title": productSnapshot[i]["title"]
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
