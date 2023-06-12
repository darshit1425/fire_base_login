import 'package:fire_base_login/screen/home_screen/controller/home_controller.dart';
import 'package:fire_base_login/screen/home_screen/model/home_model.dart';
import 'package:fire_base_login/utils/fire_base_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Add_product extends StatefulWidget {
  const Add_product({Key? key}) : super(key: key);

  @override
  State<Add_product> createState() => _Add_productState();
}

class _Add_productState extends State<Add_product> {
  Home_Controller contoller = Get.put(Home_Controller());
  TextEditingController txtp_name = TextEditingController();
  TextEditingController txtp_notes = TextEditingController();
  TextEditingController txtp_date = TextEditingController(
      text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
  TextEditingController txtp_time = TextEditingController(
      text:
          "${DateTime.now().day}/ ${DateTime.now().month}/ ${DateTime.now().year}");
  TextEditingController txtp_price = TextEditingController();
  TextEditingController txtp_review = TextEditingController();
  TextEditingController txtp_warranty = TextEditingController();
  TextEditingController txtp_paytypes = TextEditingController();
  TextEditingController txtp_modelno = TextEditingController();
  TextEditingController txtp_image = TextEditingController();

  Home_model home_model = Get.arguments;

  @override
  void initState() {
    super.initState();

    home_model.checkupdate == 1 ? NewData() : OldData();
  }

  void NewData() {
    txtp_name = TextEditingController(
      text: "${home_model.p_name}",
    );
    txtp_modelno = TextEditingController(
      text: "${home_model.p_modelno}",
    );

    txtp_review = TextEditingController(
      text: "${home_model.p_review}",
    );
    txtp_price = TextEditingController(
      text: "${home_model.p_price}",
    );
    txtp_time = TextEditingController(
      text: "${home_model.p_time}",
    );
    txtp_date = TextEditingController(
      text: "${home_model.p_date}",
    );
    txtp_notes = TextEditingController(
      text: "${home_model.p_notes}",
    );
    txtp_warranty = TextEditingController(
      text: "${home_model.p_warranty}",
    );
    txtp_paytypes = TextEditingController(
      text: "${home_model.p_paytypes}",
    );
    txtp_image = TextEditingController(
      text: "${home_model.p_image}",
    );
  }

  void OldData() {
    txtp_name = TextEditingController();
    txtp_paytypes = TextEditingController();
    txtp_warranty = TextEditingController();
    txtp_notes = TextEditingController();
    txtp_date = TextEditingController(
        text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
    txtp_time = TextEditingController(
        text:
            "${DateTime.now().day}/ ${DateTime.now().month}/ ${DateTime.now().year}");
    txtp_price = TextEditingController();

    txtp_modelno = TextEditingController();
    txtp_review = TextEditingController();
    txtp_image = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(
            "Add Data",
            style: TextStyle(fontSize: 22),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(196, 135, 198, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                ),
                                child: TextField(
                                  controller: txtp_name,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "p_name",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: txtp_notes,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "p_Notes",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade400,
                                thickness: 0.2,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: txtp_time,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "p_time",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade400,
                                thickness: 0.2,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: txtp_date,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "P_date",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade400,
                                thickness: 0.2,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: txtp_price,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "p_Price",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade400,
                                thickness: 0.2,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: txtp_review,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "p_Review",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade400,
                                thickness: 0.2,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: txtp_warranty,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "p_warranty",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade400,
                                thickness: 0.2,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: txtp_paytypes,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "p_Paytypes",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade400,
                                thickness: 0.2,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: txtp_modelno,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "p_Modelno",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: TextField(
                                  controller: txtp_image,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "p_image",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    home_model.checkupdate == 0
                        ? FirebaseHelper.firebaseHelper.AddData(
                            p_price: txtp_price.text,
                            p_name: txtp_name.text,
                            p_date: txtp_date.text,
                            p_modelno: txtp_modelno.text,
                            p_notes: txtp_notes.text,
                            p_paytypes: txtp_paytypes.text,
                            p_review: txtp_review.text,
                            p_time: txtp_time.text,
                            p_warranty: txtp_warranty.text,
                      p_image: txtp_image.text,

                          )
                        : FirebaseHelper.firebaseHelper.UpadteData(
                            p_name: txtp_name.text,
                            p_notes: txtp_notes.text,
                            p_date: txtp_date.text,
                            p_time: txtp_time.text,
                            p_price: txtp_price.text,
                            p_review: txtp_review.text,
                            p_warranty: txtp_warranty.text,
                            p_paytypes: txtp_paytypes.text,
                            p_modelno: txtp_modelno.text,
                            p_image: txtp_image.text,
                            key: home_model.key,
                          );
                    ;
                    // ):FirebaseHelper.firebaseHelper.UpadteData(String key);
                    Get.back();
                  },
                  child: home_model.checkupdate == 0
                      ? Text("Add")
                      : Text("Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// TextField(
//   controller: txtp_name,
//   decoration: InputDecoration(
//       focusColor: Colors.blue, hintText: "p_name"),
// ),
// SizedBox(
//   height: 10,
// ),
// TextField(
//   controller: txtp_notes,
//   decoration: InputDecoration(
//       focusColor: Colors.blue, hintText: "p_notes"),
// ),
// SizedBox(
//   height: 10,
// ),
// TextField(
//   controller: txtp_date,
//   decoration: InputDecoration(
//       focusColor: Colors.blue, hintText: "date"),
// ),
// SizedBox(
//   height: 10,
// ),
// TextField(
//   controller: txtp_time,
//   decoration: InputDecoration(
//       focusColor: Colors.blue, hintText: "time"),
// ),
// SizedBox(
//   height: 10,
// ),
// TextField(
//   controller: txtp_price,
//   decoration: InputDecoration(
//       focusColor: Colors.blue, hintText: "price"),
// ),
// SizedBox(
//   height: 10,
// ),
// TextField(
//   controller: txtp_review,
//   decoration: InputDecoration(
//       focusColor: Colors.blue, hintText: "Review"),
// ),
// SizedBox(
//   height: 10,
// ),
// TextField(
//   controller: txtp_warranty,
//   decoration: InputDecoration(
//       focusColor: Colors.blue, hintText: "warranty"),
// ),
// SizedBox(
//   height: 10,
// ),
// TextField(
//   controller: txtp_paytypes,
//   decoration: InputDecoration(
//       focusColor: Colors.blue, hintText: "paytypes"),
// ),
// SizedBox(
//   height: 10,
// ),
// TextField(
//   controller: txtp_modelno,
//   decoration: InputDecoration(
//       focusColor: Colors.blue, hintText: "modelno"),
// ),
