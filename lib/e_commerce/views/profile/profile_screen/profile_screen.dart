import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/controller/auth_controller.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_services/firebase_service.dart';
import 'package:fire_base_login/e_commerce/views/auth_screen/login/view/login_screen.dart';
import 'package:fire_base_login/e_commerce/views/profile/details_card/details_card.dart';
import 'package:fire_base_login/e_commerce/views/profile/edit_profile_screen/edit_profile_screen.dart';
import 'package:fire_base_login/e_commerce/views/profile/lists/account_list/account.dart';
import 'package:fire_base_login/e_commerce/views/profile/view/messaging_screen/messaging_screen.dart';
import 'package:fire_base_login/e_commerce/views/profile/view/orders_screen/orders_screen.dart';
import 'package:fire_base_login/e_commerce/views/profile/view/wishlist_screen/wishlist_screen.dart';
import 'package:fire_base_login/e_commerce/widget/bg_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(ProfileController());
    // FirestoreServices.getCounts();

    return Scaffold(
      body: bgWidget(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        Get.to(() => EditProfileScreen(
                          // data: data,
                        ));
                      },
                      child: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/s2.jpg"),
                      radius: 30,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dummy name",
                          // "${data["name"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: semibold,
                          ),
                        ),
                        Text(
                          "Dummy email",
                          // "${data["email"]}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 90),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          await Get.put(AuthController())
                              .signoutMethod(context);
                          Get.offAll(() => LoginScreen());
                        },
                        child: Text("Log Out",
                            style: TextStyle(
                                fontFamily: semibold, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                FutureBuilder(
                  future: FirestoreServices.getCounts(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      );
                    } else {
                      var countData = snapshot.data;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detailsCard(
                              count: countData[0].toString(),
                              title: "in your cart",
                              width: context.screenWidth / 3.5),
                          detailsCard(
                              count: countData[1].toString(),
                              title: "in your wishlist",
                              width: context.screenWidth / 3.5),
                          detailsCard(
                              count: countData[2].toString(),
                              title: " your ordered",
                              width: context.screenWidth / 3.5),
                        ],
                      );
                    }
                  },
                ),
                Container(
                  color: Colors.red.shade600,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.black38, blurRadius: 2)
                        ]),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: profileButtonList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => OrderScreen());
                                break;
                              case 1:
                                Get.to(() => WishlistScreen());
                                break;
                              case 2:
                                Get.to(() => MessagesScreen());
                                break;
                            }
                          },
                          leading:
                              Image.asset(profileButtonIcon[index], width: 22),
                          title: Text("${profileButtonList[index]}",
                              style: TextStyle(
                                  fontFamily: semibold, color: darkFontGrey)),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(color: lightGrey);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // child: StreamBuilder(
        //   stream: FirestoreServices.getUser(currentUser!.uid),
        //   builder:
        //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //     if (!snapshot.hasData) {
        //       return Center(
        //         child: CircularProgressIndicator(
        //           color: Colors.red,
        //         ),
        //       );
        //     } else {
        //       print("Length===>>>>>>>${snapshot.data?.docs.length}");
        //       var data = snapshot.data!.docs[0];
        //       return SafeArea(
        //         child: Container(
        //           padding: EdgeInsets.all(8),
        //           child: Column(
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Align(
        //                   alignment: Alignment.topRight,
        //                   child: InkWell(
        //                     onTap: () {
        //                       Get.to(() => EditProfileScreen(
        //                             data: data,
        //                           ));
        //                     },
        //                     child: Icon(Icons.edit, color: Colors.white),
        //                   ),
        //                 ),
        //               ),
        //               Row(
        //                 children: [
        //                   CircleAvatar(
        //                     backgroundImage: AssetImage(imgProfile2),
        //                     radius: 30,
        //                   ),
        //                   SizedBox(width: 10),
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text(
        //                         "${data["name"]}",
        //                         style: TextStyle(
        //                           color: Colors.white,
        //                           fontFamily: semibold,
        //                         ),
        //                       ),
        //                       Text(
        //                         "${data["email"]}",
        //                         style: TextStyle(color: Colors.white),
        //                       ),
        //                     ],
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.only(left: 20),
        //                     child: OutlinedButton(
        //                       style: OutlinedButton.styleFrom(
        //                         side: BorderSide(
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                       onPressed: () async {
        //                         await Get.put(AuthController())
        //                             .signoutMethod(context);
        //                         Get.offAll(() => LoginScreen());
        //                       },
        //                       child: Text("Log Out",
        //                           style: TextStyle(
        //                               fontFamily: semibold,
        //                               color: Colors.white)),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(height: 20),
        //               FutureBuilder(
        //                 future: FirestoreServices.getCounts(),
        //                 builder:
        //                     (BuildContext context, AsyncSnapshot snapshot) {
        //                   if (!snapshot.hasData) {
        //                     return Center(
        //                       child: CircularProgressIndicator(
        //                         color: Colors.red,
        //                       ),
        //                     );
        //                   } else {
        //                     var countData = snapshot.data;
        //                     return Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                       children: [
        //                         detailsCard(
        //                             count: countData[0].toString(),
        //                             title: "in your cart",
        //                             width: context.screenWidth / 3.5),
        //                         detailsCard(
        //                             count: countData[1].toString(),
        //                             title: "in your wishlist",
        //                             width: context.screenWidth / 3.5),
        //                         detailsCard(
        //                             count: countData[2].toString(),
        //                             title: " your ordered",
        //                             width: context.screenWidth / 3.5),
        //                       ],
        //                     );
        //                   }
        //                 },
        //               ),
        //               Container(
        //                 color: Colors.red.shade600,
        //                 child: Container(
        //                   padding: EdgeInsets.symmetric(horizontal: 16),
        //                   margin: EdgeInsets.all(12),
        //                   decoration: BoxDecoration(
        //                       color: Colors.white,
        //                       borderRadius: BorderRadius.circular(10),
        //                       boxShadow: [
        //                         BoxShadow(color: Colors.black38, blurRadius: 2)
        //                       ]),
        //                   child: ListView.separated(
        //                     shrinkWrap: true,
        //                     itemCount: profileButtonList.length,
        //                     itemBuilder: (context, index) {
        //                       return ListTile(
        //                         onTap: () {
        //                           switch (index) {
        //                             case 0:
        //                               Get.to(() => OrderScreen());
        //                               break;
        //                             case 1:
        //                               Get.to(() => WishlistScreen());
        //                               break;
        //                             case 2:
        //                               Get.to(() => MessagesScreen());
        //                               break;
        //                           }
        //                         },
        //                         leading: Image.asset(profileButtonIcon[index],
        //                             width: 22),
        //                         title: Text("${profileButtonList[index]}",
        //                             style: TextStyle(
        //                                 fontFamily: semibold,
        //                                 color: darkFontGrey)),
        //                       );
        //                     },
        //                     separatorBuilder: (context, index) {
        //                       return Divider(color: lightGrey);
        //                     },
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}
