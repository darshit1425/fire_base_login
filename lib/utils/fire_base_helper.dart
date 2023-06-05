import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> Singup({required email, required password}) async {
    String msg = "";

    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => msg = "Success")
        .catchError((e) => msg = "Faild $e");
    return msg;
  }

  String? SingIn({required email, required password}) {
    String? msg;
    firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print("succes Login");
      msg = "sucees";
    }).catchError((e) {
      print("$e");
      msg = ("$e");
    });

    return msg;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Get.offAndToNamed('/'));
  }

  bool CheckUser() {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }

  Future<String> signInWithGoogle() async {
    String? msg;
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => msg = "Success")
        .catchError((e) => msg = "$e");
    return msg!;
  }

// GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
// GoogleSignInAuthentication? Auth =
//     await googleSignInAccount?.authentication;
//
// var crede = GoogleAuthProvider.credential(
//     accessToken: Auth?.accessToken, idToken: Auth?.idToken);
//
// await firebaseAuth
//     .signInWithCredential(crede)

//    DATA BASE -> UID TODO  -> DATA

  Map UserData() {
    User? user = firebaseAuth.currentUser;

    String? image = user!.photoURL;
    String? name = user.displayName;
    String? email = user.email;
    String? phone = user.phoneNumber;

    return {
      "image": image,
      "name": name,
      "email": email,
      "phone": phone,
    };
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> AddData(
      {p_name,
      p_notes,
      p_date,
      p_time,
      p_price,
      p_review,
      p_warranty,
      p_paytypes,
      p_modelno}) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    await firestore.collection("Product").doc("$uid").collection("todo").add({
      "p_name": p_name,
      "p_notes": p_notes,
      "p_date": p_date,
      "p_time": p_time,
      "p_price": p_price,
      "p_review": p_review,
      "p_warranty": p_warranty,
      "p_paytypes": p_paytypes,
      "p_modelno": p_modelno,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> GetData() {
    User? user = firebaseAuth.currentUser;
    var uid = user!.uid;

    return firestore
        .collection("Product")
        .doc("$uid")
        .collection("todo")
        .snapshots();
  }

  void UpadteData({
    required p_name,
    required p_notes,
    required p_date,
    required p_time,
    required p_price,
    required p_review,
    required p_warranty,
    required p_paytypes,
    required p_modelno,
    required key,
  }) {
    User? user = firebaseAuth.currentUser;
    var uid = user!.uid;
    firestore
        .collection("Product")
        .doc("$uid")
        .collection("todo")
        .doc(key)
        .set({
      "p_name": p_name,
      "p_notes": p_notes,
      "p_date": p_date,
      "p_time": p_time,
      "p_price": p_price,
      "p_review": p_review,
      "p_warranty": p_warranty,
      "p_paytypes": p_paytypes,
      "p_modelno": p_modelno,
    });
  }

  Future<void> deletedata(String key) async {
    User? user = firebaseAuth.currentUser;
    var uid = user!.uid;


    await   firestore
        .collection("Product")
        .doc("$uid")
        .collection("todo")
        .doc(key).delete();

  }
}
