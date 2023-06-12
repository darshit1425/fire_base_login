import 'package:get/get.dart';

import '../../Utils/api_helper.dart';

class APiController extends GetxController {
  static APiController aPiController = APiController._();

  APiController._();

  Future<String> SendPushNotification(String body, String title) async {
    ApiHelper apiHelper = ApiHelper();
    String msg = await apiHelper.postApiCall(body, title);
    return msg;
  }
}