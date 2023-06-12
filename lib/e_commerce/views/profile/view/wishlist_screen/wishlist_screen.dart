import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_consts/firebase_consts.dart';
import 'package:fire_base_login/e_commerce/firebase/firebase_services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("My Wishlist",style: TextStyle(fontFamily: semibold,color: darkFontGrey)),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlist(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return Center(child: Text("No orders yet!",style: TextStyle(color: darkFontGrey),));
          }else{
            var data= snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading: Image.network("${data[index]['p_image'][0]}",
                              width: 80, fit: BoxFit.cover),
                          title: Text(
                              '${data[index]['p_name']} ',
                              style: const TextStyle(
                                  fontFamily: semibold, fontSize: 16)),
                          subtitle: Text(
                              "${data[index]["p_price"]}".numCurrency,
                              style: const TextStyle(
                                  color: Colors.red, fontFamily: semibold)),
                          trailing: IconButton(
                            onPressed: () async{
                              await firestore.collection(productsCollection).doc(data[index].id).set({
                                "p_wishlist": FieldValue.arrayRemove([currentUser!.uid])
                              },SetOptions(merge: true));
                            },
                            icon: Icon(Icons.favorite, color: Colors.red),
                          ));
                    },
                  ),
                ),
              ],
            );
          }

        },),
    );
  }
}
