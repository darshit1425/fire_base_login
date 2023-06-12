import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_consts/firebase_consts.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_services/firebase_service.dart';
import 'package:fire_base_login/e_commerce/views/cart/controller/cart_controller.dart';
import 'package:fire_base_login/e_commerce/views/cart/shipping/shipping_screen.dart';
import 'package:fire_base_login/e_commerce/widget/our_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: SizedBox(
          height: Get.height*0.06,
          width: context.screenWidth - 60,
          child: ourButton(
              color: Colors.red,
              title: "Proceed to shipping",
              textColor: Colors.white,
              onPress: () {
                Get.to(() => ShippingDetails());
              }),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text("Shopping Cart",
              style: TextStyle(color: darkFontGrey, fontFamily: semibold)),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("Cart is empty",
                    style: TextStyle(color: darkFontGrey)),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              leading: Image.network("${data[index]['img']}",
                                  width: 80, fit: BoxFit.cover),
                              title: Text(
                                  '${data[index]['title']} (*${data[index]['qty']})',
                                  style: const TextStyle(
                                      fontFamily: semibold, fontSize: 16)),
                              subtitle: Text(
                                  "${data[index]["tprice"]}".numCurrency,
                                  style: const TextStyle(
                                      color: Colors.red, fontFamily: semibold)),
                              trailing: IconButton(
                                onPressed: () {
                                  FirestoreServices.deleteDocument(
                                      data[index].id);
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                              ));
                        },
                      ),
                    ),
                    Container(
                      width: Get.width*0.75,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(color: lightGolden),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total Price",
                              style: TextStyle(
                                  fontFamily: semibold, color: darkFontGrey)),
                          Obx(
                            () => Text("${controller.totalP.value}".numCurrency,
                                style: const TextStyle(
                                    fontFamily: semibold, color: Colors.red)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            }
          },
        ));
  }
}
