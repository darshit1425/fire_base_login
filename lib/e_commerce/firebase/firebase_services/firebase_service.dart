
import 'package:fire_base_login/e_commerce/firebase/firebase_consts/firebase_consts.dart';

class FirestoreServices {
  ////get user data
  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //// get product according to category
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where("p_category", isEqualTo: category)
        .snapshots();
  }

  static getSubCategoryProducts(title) {
    return firestore
        .collection(productsCollection)
        .where("p_subcategory", isEqualTo: title)
        .snapshots();
  }

  //// get cart
  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //// delete document
  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  //// get all the message
  static getChatMessage(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy("created_on", descending: false)
        .snapshots();
  }

  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where("order_by", isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlist() {
    return firestore
        .collection(productsCollection)
        .where("p_wishlist", arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestore
        .collection(chatCollection)
        .where("formId", isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where("added_by", isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productsCollection)
          .where("p_wishlist", arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where("order_by", arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static allProducts() {
    return firestore.collection(productsCollection).snapshots();
  }

  ////get Featured Products Method
  static getFeaturedProducts() {
    return firestore
        .collection(productsCollection)
        .where("is_featured", isEqualTo: true)
        .get();
  }

  static searchProducts(title) {
    return firestore.collection(productsCollection).get();
  }
}
