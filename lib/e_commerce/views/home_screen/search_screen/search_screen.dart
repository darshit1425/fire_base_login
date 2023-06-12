import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../category/item_details/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title ?? "", style: TextStyle(color: darkFontGrey)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No products found"),
            );
          } else {
            var data = snapshot.data!.docs;
            var filtered = data
                .where((element) => element["p_name"]
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase()))
                .toList();

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 300,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8),
                children: filtered
                    .mapIndexed((currentValue, index) => InkWell(
                          onTap: () {
                            Get.to(
                              () => ItemDetails(
                                  title: "${filtered[index]["p_name"]}",
                                  data: filtered[index]),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(blurRadius: 2, color: Colors.black45)
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    filtered[index]["p_image"][0],
                                    width: Get.width * 0.4,
                                    height: Get.height * 0.24,
                                    fit: BoxFit.fill,
                                  ),
                                  Spacer(),
                                  Text(
                                    "${filtered[index]["p_name"]}",
                                    style: TextStyle(
                                      fontFamily: semibold,
                                      color: darkFontGrey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "${filtered[index]["p_price"]}",
                                    style: TextStyle(
                                      fontFamily: bold,
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
