
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/images.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/views/category/lists/categories_list.dart';
import 'package:fire_base_login/e_commerce/views/category/product_controller/product_controller.dart';
import 'package:fire_base_login/e_commerce/views/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("Color====>>>>${Colors.red.value}");
    var controller = Get.put(ProductController());
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(title ?? "",
              style: const TextStyle(fontFamily: bold, color: darkFontGrey)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.isFav.value) {
                    controller.removeFromWishlist(data.id);
                    // controller.isFav(false);
                    Get.snackbar(
                      "Remove Favorite",
                      "Successfully",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red,
                    );
                  } else {
                    controller.addToWishlist(data.id);
                    // controller.isFav(true);
                    Get.snackbar(
                      "Add to Favorite",
                      "Successfully",
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.green,
                    );
                  }
                },
                icon: Icon(
                  Icons.favorite_outlined,
                  color: controller.isFav.value ? Colors.red : darkFontGrey,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // padding: EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      height: Get.height * 0.44,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data["p_image"].length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data["p_image"][index],
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(data["p_name"],
                          style: const TextStyle(
                              color: darkFontGrey,
                              fontFamily: semibold,
                              fontSize: 15)),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: golden,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(" ${data["p_price"]}".numCurrency,
                          style: const TextStyle(
                              color: Colors.red,
                              fontFamily: bold,
                              fontSize: 18)),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      height: Get.height * 0.08,
                      color: textfieldGrey,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Seller",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: semibold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${data["p_seller"]}",
                                  style: const TextStyle(
                                      color: darkFontGrey,
                                      fontFamily: semibold),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(
                                () =>  ChatScreen(),
                                arguments: [data["p_seller"], data["baba_id"]],
                              );
                            },
                            child:  CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.message_rounded,
                                  color: darkFontGrey),
                            ),
                          ),
                        ],
                      ),
                    ),
                     SizedBox(height: 10),

                    //// colors
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: MediaQuery.of(context).size.width,
                      height: Get.height * 0.25,
                      color: Colors.white,
                      child: Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                const Text("Color:",
                                    style: TextStyle(
                                        color: textfieldGrey, fontSize: 18)),
                                const SizedBox(width: 50),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: List.generate(
                                      data["p_colors"].length,
                                      (index) => Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller
                                                    .changeColorIndex(index);
                                              },
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Color(
                                                    data["p_colors"][index]),
                                              ),
                                            ),
                                            Visibility(
                                                visible: index ==
                                                    controller.colorIndex.value,
                                                child:  Icon(Icons.done,
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //// quantity row

                            Row(
                              children: [
                                 Text("Quantity:",
                                    style: TextStyle(
                                        color: textfieldGrey, fontSize: 18)),
                                 SizedBox(
                                  width: 20,
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decreaseQuantity();
                                            controller.calculateTotalPrice(
                                                int.parse(data["p_price"]));
                                          },
                                          icon:  Icon(Icons.remove)),
                                      Text("${controller.quantity.value}",
                                          style:  TextStyle(
                                              color: darkFontGrey,
                                              fontSize: 16,
                                              fontFamily: semibold)),
                                      IconButton(
                                          onPressed: () {
                                            controller.increaseQuantity(
                                                int.parse(data["p_quantity"]));
                                            controller.calculateTotalPrice(
                                                int.parse(data["p_price"]));
                                          },
                                          icon: const Icon(Icons.add)),
                                      const SizedBox(width: 10),
                                      Text(
                                        "(${data["p_quantity"]} avilable)",
                                        style: const TextStyle(
                                            color: textfieldGrey),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 15),
                            //// Total
                            Row(
                              children: [
                                const Text("Total:",
                                    style: TextStyle(
                                        color: textfieldGrey, fontSize: 18)),
                                const SizedBox(width: 50),
                                Row(
                                  children: [
                                    Text(
                                        "${controller.totalPrice.value}"
                                            .numCurrency,
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                            fontFamily: semibold)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Description",
                          style: TextStyle(
                              color: darkFontGrey, fontFamily: semibold)),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("${data["p_decs"]}",
                          style: const TextStyle(color: darkFontGrey)),
                    ),

                    const SizedBox(height: 10),

                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        5,
                        (index) => ListTile(
                          title: Text(itemDetailsButtonList[index],
                              style: const TextStyle(
                                  fontFamily: semibold, color: darkFontGrey)),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Products you may also like",
                          style: TextStyle(
                              fontFamily: bold,
                              color: darkFontGrey,
                              fontSize: 16)),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          6,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.all(10),
                            height: Get.height* 0.32,
                            width: Get.width * 0.42,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Image.asset(imgP1,
                                    width: Get.width * 0.4, fit: BoxFit.fill),
                                const SizedBox(height: 10),
                                const Text(
                                  "LapTop 4GB/64GB",
                                  style: TextStyle(
                                    fontFamily: semibold,
                                    color: darkFontGrey,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "\$600",
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
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),
            ///// Cart and Buy

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        if (controller.quantity.value > 0) {
                          controller.addToCart(
                              title: data["p_name"],
                              babaID: data["baba_id"],
                              color: data["p_colors"]
                                  [controller.colorIndex.value],
                              img: data['p_image'][0],
                              qty: controller.quantity.value,
                              sellername: data['p_seller'],
                              tprice: controller.totalPrice.value,
                              context: context);
                          Get.snackbar(
                            "Add to Cart",
                            "Successfully",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.green,

                          );
                        } else {
                          Get.snackbar(
                            "Minimum 1 product is requried",
                            "Failed",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                            // mainButton: TextButton(onPressed: (){
                            //
                            // }, child: Text("Try Again")),
                          );
                        }
                      },
                      child: Container(
                        width: Get.width*0.45,
                        height: Get.height*0.065,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            const BoxShadow(
                                color: Colors.redAccent, blurRadius: 10)
                          ],
                        ),
                        child: const Center(
                          child: Text("Add to Cart",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: semibold)),
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width*0.45,
                      height: Get.height*0.065,
                      decoration: BoxDecoration(
                        color: Colors.amber.shade700,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.amberAccent, blurRadius: 10)
                        ],
                      ),
                      child: const Center(
                        child: Text("Buy now",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: semibold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
