
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/views/category/category_details/category_details.dart';
import 'package:fire_base_login/e_commerce/views/category/lists/categories_list.dart';
import 'package:fire_base_login/e_commerce/views/category/product_controller/product_controller.dart';
import 'package:fire_base_login/e_commerce/widget/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      body: bgWidget(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text("Categories",
                  style: TextStyle(fontFamily: bold, color: Colors.white)),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: GridView.builder(
                    itemCount: 9,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 180,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.getSubCategories(categoriesList[index]);
                          Get.to(() =>
                              CategoryDetails(title: categoriesList[index]));
                        },
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                categoriesImages[index],
                                height: Get.height * 0.14,
                                width: Get.width * 0.4,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(categoriesList[index],
                                  style: TextStyle(color: darkFontGrey),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
