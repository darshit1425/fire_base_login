import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/images.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_services/firebase_service.dart';
import 'package:fire_base_login/e_commerce/views/auth_screen/home/controller/home_controller.dart';
import 'package:fire_base_login/e_commerce/views/category/item_details/item_details.dart';
import 'package:fire_base_login/e_commerce/views/home_screen/home_button/featured_button.dart';
import 'package:fire_base_login/e_commerce/views/home_screen/home_button/home_button.dart';
import 'package:fire_base_login/e_commerce/views/home_screen/list/lists.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'search_screen/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;

  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);
  final PageController _pageController1 = PageController(initialPage: 0);
  final PageController _pageController3 = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < sliderList.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
      _pageController1.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
      _pageController3.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          color: lightGrey,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: Get.height * 0.07,
                  color: lightGrey,
                  child: TextFormField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (controller
                                .searchController.text.isNotEmptyAndNotNull) {
                              Get.to(() => SearchScreen(
                                    title: controller.searchController.text,
                                  ));
                            }
                          },
                          icon: const Icon(Icons.search)),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Search anything....",
                      hintStyle: const TextStyle(color: Colors.black12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          // padding: const EdgeInsets.symmetric(horizontal: 1),
                          height: Get.height * 0.23,
                          width: MediaQuery.of(context).size.width,
                          child: PageView.builder(
                            controller: _pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: sliderList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    sliderList[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            homeButton(
                              height: Get.height * 0.12,
                              width: Get.width * 0.42,
                              title: "Today Deal",
                              icon: icTodaysDeal,
                            ),
                            homeButton(
                              height: Get.height * 0.12,
                              width: Get.width * 0.42,
                              title: "Flash Deal",
                              icon: icFlashDeal,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          height: Get.height * 0.23,
                          width: MediaQuery.of(context).size.width,
                          child: PageView.builder(
                            controller: _pageController1,
                            scrollDirection: Axis.horizontal,
                            itemCount: sliderList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    secondSliderList[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            3,
                            (index) => homeButton(
                              height: Get.height * 0.12,
                              width: Get.width * 0.28,
                              icon: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              title: index == 0
                                  ? "Top Categories"
                                  : index == 1
                                      ? "Brand"
                                      : "Top Seller",
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Featured Categories",
                              style: TextStyle(
                                  color: darkFontGrey,
                                  fontFamily: semibold,
                                  fontSize: 18)),
                        ),
                        const SizedBox(height: 20),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              3,
                              (index) => Column(
                                children: [
                                  featuredButton(
                                    icon: featuredImages1[index],
                                    title: featuredTitle1[index],
                                  ),
                                  const SizedBox(height: 10),
                                  featuredButton(
                                    icon: featuredImages2[index],
                                    title: featuredTitle2[index],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        ///// Featured Product
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration:
                              const BoxDecoration(color: Colors.redAccent),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Featured Product",
                                style: TextStyle(
                                    fontFamily: bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: FutureBuilder(
                                  future:
                                      FirestoreServices.getFeaturedProducts(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.red,
                                        ),
                                      );
                                    } else if (snapshot.data!.docs.isEmpty) {
                                      return const Center(
                                        child: Text("No featured products",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18)),
                                      );
                                    } else {
                                      var featuredData = snapshot.data!.docs;
                                      return Row(
                                        children: List.generate(
                                          featuredData.length,
                                          (index) => InkWell(
                                            onTap: () {
                                              Get.to(
                                                () => ItemDetails(
                                                    title:
                                                        "${featuredData[index]["p_name"]}",
                                                    data: featuredData[index]),
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 4),
                                              padding: const EdgeInsets.all(8),
                                              height: Get.height * 0.3,
                                              width: Get.width * 0.4,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.network(
                                                      featuredData[index]
                                                          ["p_image"][0],
                                                      width: 150,
                                                      height: 150,
                                                      fit: BoxFit.fill),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    "${featuredData[index]["p_name"]}",
                                                    style: const TextStyle(
                                                      fontFamily: semibold,
                                                      color: darkFontGrey,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    "${featuredData[index]["p_price"]}",
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
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          height: Get.height * 0.23,
                          width: MediaQuery.of(context).size.width,
                          child: PageView.builder(
                            controller: _pageController3,
                            scrollDirection: Axis.horizontal,
                            itemCount: sliderList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    secondSliderList[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        StreamBuilder(
                          stream: FirestoreServices.allProducts(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              );
                            } else {
                              var allProductsData = snapshot.data!.docs;
                              return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: allProductsData.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 300,
                                ),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => ItemDetails(
                                            title:
                                                "${allProductsData[index]["p_name"]}",
                                            data: allProductsData[index]),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              allProductsData[index]["p_image"]
                                                  [0],
                                              width: Get.width * 0.4,
                                              height: Get.height * 0.24,
                                              fit: BoxFit.fill,
                                            ),
                                            const Spacer(),
                                            Text(
                                              "${allProductsData[index]["p_name"]}",
                                              style: const TextStyle(
                                                fontFamily: semibold,
                                                color: darkFontGrey,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "${allProductsData[index]["p_price"]}",
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
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
