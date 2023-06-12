import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_consts/firebase_consts.dart';
import 'package:fire_base_login/e_commerce/views/category/category_model/category_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxInt quantity = 0.obs;
  RxInt colorIndex = 0.obs;
  RxInt totalPrice = 0.obs;
  RxBool isFav = false.obs;
  var subcat = [];

  // var isFav = false.obs;

  getSubCategories(title) async {
    var data = await rootBundle
        .loadString("lib/views/category/category_model/category_model.json");
    final decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    subcat.clear();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart(
      {title, img, sellername, color, qty, tprice, context, babaID}) async {
    await firestore.collection(cartCollection).doc().set({
      "title": title,
      "img": img,
      "sellername": sellername,
      "color": color,
      "qty": qty,
      "baba_id": babaID,
      "tprice": tprice,
      "added_by": currentUser?.uid ?? "uid is null"
    });
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  addToWishlist(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      "p_wishlist": FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    SnackBar(content: Text("Added Wishlist"));
  }

  removeFromWishlist(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      "p_wishlist": FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    SnackBar(content: Text("Removed From Wishlist"));
  }

  checkIfFav(data) async {
    if (data["p_wishlist"].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
