import 'package:fire_base_login/utils/fire_base_helper.dart';
import 'package:flutter/material.dart';

class Add_product extends StatefulWidget {
  const Add_product({Key? key}) : super(key: key);

  @override
  State<Add_product> createState() => _Add_productState();
}

class _Add_productState extends State<Add_product> {


  TextEditingController txtp_name = TextEditingController();
  TextEditingController txtp_notes = TextEditingController();
  TextEditingController txtp_date = TextEditingController();
  TextEditingController txtp_time = TextEditingController();
  TextEditingController txtp_price = TextEditingController();
  TextEditingController txtp_review = TextEditingController();
  TextEditingController txtp_warranty = TextEditingController();
  TextEditingController txtp_paytypes = TextEditingController();
  TextEditingController txtp_modelno = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                TextField(
                  controller: txtp_name,
                  decoration: InputDecoration(
                      focusColor: Colors.blue, hintText: "p_name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtp_notes,
                  decoration: InputDecoration(
                      focusColor: Colors.blue, hintText: "p_notes"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtp_date,
                  decoration: InputDecoration(
                      focusColor: Colors.blue, hintText: "date"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtp_time,
                  decoration: InputDecoration(
                      focusColor: Colors.blue, hintText: "time"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtp_price,
                  decoration: InputDecoration(
                      focusColor: Colors.blue, hintText: "price"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtp_review,
                  decoration: InputDecoration(
                      focusColor: Colors.blue, hintText: "Review"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtp_warranty,
                  decoration: InputDecoration(
                      focusColor: Colors.blue, hintText: "warranty"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtp_paytypes,
                  decoration: InputDecoration(
                      focusColor: Colors.blue, hintText: "paytypes"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtp_modelno,
                  decoration: InputDecoration(
                      focusColor: Colors.blue, hintText: "modelno"),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    FirebaseHelper.firebaseHelper.AddData(
                      p_price: txtp_price.text,
                      p_name: txtp_name.text,
                      p_date: txtp_date.text,
                      p_modelno: txtp_modelno.text,
                      p_notes: txtp_notes.text,
                      p_paytypes: txtp_paytypes.text,
                      p_review: txtp_review.text,
                      p_time: txtp_time.text,
                      p_warranty: txtp_warranty.text,
                    );
                  },
                  child: Text("Save"),
                ),

              ],
            ),
          ),
        ),

        ),

    );
  }
}
