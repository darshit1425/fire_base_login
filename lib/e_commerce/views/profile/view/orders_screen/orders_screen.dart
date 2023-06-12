import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_services/firebase_service.dart';
import 'package:fire_base_login/e_commerce/views/profile/view/orders_screen/orders_details.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("My Orders",
            style: TextStyle(fontFamily: semibold, color: darkFontGrey)),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text(
              "No orders yet!",
              style: TextStyle(color: darkFontGrey),
            ));
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text("${index + 1}",
                      style: TextStyle(color: darkFontGrey)),
                  title: Text("${data[index]["order_code"]}".toString(),
                      style: const TextStyle(
                          color: Colors.red, fontFamily: semibold)),
                  subtitle: Text(
                      data[index]["total_amount"].toString().numCurrency,
                      style: const TextStyle(fontFamily: bold)),
                  trailing: IconButton(
                      onPressed: () {
                        Get.to(() => OrdersDetails(data: data[index]));
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded,
                          color: darkFontGrey)),
                );
              },
            );
          }
        },
      ),
    );
  }
}
