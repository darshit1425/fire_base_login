import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_services/firebase_service.dart';
import 'package:fire_base_login/e_commerce/views/category/item_details/item_details.dart';
import 'package:fire_base_login/e_commerce/views/category/product_controller/product_controller.dart';
import 'package:fire_base_login/e_commerce/widget/bg_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.put(ProductController());
  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bgWidget(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(widget.title ?? "",
                      style: const TextStyle(
                          fontFamily: bold, color: Colors.white)),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      controller.subcat.length,
                      (index) => InkWell(
                        onTap: () {
                          switchCategory("${controller.subcat[index]}");
                          setState(() {});
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: Get.width * 0.34,
                          height: Get.height * 0.075,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(controller.subcat[index],
                                style: const TextStyle(
                                    fontFamily: semibold,
                                    color: darkFontGrey,
                                    fontSize: 12)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            StreamBuilder(
              stream: productMethod,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.red),
                      ),
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text("No products found!",
                          style: TextStyle(color: darkFontGrey)),
                    ),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 250,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller.checkIfFav(data[index]);
                            Get.to(() => ItemDetails(
                                  title: "${data[index]["p_name"]}",
                                  data: data[index],
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    data[index]["p_image"][0],
                                    width: Get.width * 0.4,
                                    height: Get.height * 0.19,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    " ${data[index]["p_name"]}",
                                    style: const TextStyle(
                                      fontFamily: semibold,
                                      color: darkFontGrey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    " ${data[index]["p_price"]}".numCurrency,
                                    style: const TextStyle(
                                      fontFamily: bold,
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
