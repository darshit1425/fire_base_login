
import 'package:fire_base_login/e_commerce/consts/images.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/views/auth_screen/home/controller/home_controller.dart';
import 'package:fire_base_login/e_commerce/views/home_screen/home_screen.dart';
import 'package:fire_base_login/e_commerce/views/profile/profile_screen/profile_screen.dart';
import 'package:fire_base_login/e_commerce/widget/exit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../cart/cart_screen/cart_screen.dart';
import '../../../category/category_screen/category_screen.dart';

class MainScreen extends GetView<HomeController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: "Home"),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: "Categories"),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: "Cart"),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: "Account"),
    ];

    var navBody = [
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => exitDialog(context),
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              () => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: Colors.red,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(fontFamily: semibold),
            backgroundColor: Colors.white,
            items: navbarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
// child: Row(
//   children: [
//     IconButton(
//         onPressed: () {
//           controller.increament();
//         },
//         icon: Icon(
//           Icons.add,
//           size: 60,
//         )),
//     Text("    ${controller.a.value}  ",
//         style: TextStyle(fontSize: 60)),
//     IconButton(
//         onPressed: () {
//           controller.decreament();
//         },
//         icon: Icon(Icons.remove, size: 60))
//   ],
// ),
