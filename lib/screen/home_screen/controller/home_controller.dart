import 'package:fire_base_login/screen/home_screen/model/home_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Home_Controller extends GetxController {
  RxMap userDetail = {}.obs;

  List<Home_model> DataList = [];

  Home_model updateData = Home_model();

  void getData()
  {
    User? user= FirebaseAuth.instance.currentUser;

  }
}
