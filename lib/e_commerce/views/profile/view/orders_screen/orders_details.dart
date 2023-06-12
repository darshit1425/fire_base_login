
import 'package:fire_base_login/e_commerce/consts/colors.dart';
import 'package:fire_base_login/e_commerce/consts/styles.dart';
import 'package:fire_base_login/e_commerce/views/profile/view/orders_screen/components/order_place_details.dart';
import 'package:fire_base_login/e_commerce/views/profile/view/orders_screen/components/order_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Order Details",
            style: TextStyle(fontFamily: semibold, color: darkFontGrey)),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              orderStatus(
                  color: Colors.red,
                  title: "Placed",
                  icon: Icons.done,
                  showDone: data["order_placed"]),
              orderStatus(
                  color: Colors.blue,
                  title: "Confirmed",
                  icon: Icons.thumb_up,
                  showDone: data["order_confirmed"]),
              orderStatus(
                  color: Colors.yellow,
                  title: "On Delivery",
                  icon: Icons.car_crash,
                  showDone: data["order_on_delivery"]),
              orderStatus(
                  color: Colors.purple,
                  title: "Delivered",
                  icon: Icons.done_all_rounded,
                  showDone: data["order_delivered"]),
              Divider(),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 2,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    orderPlaceDetails(
                        title1: "Order Code",
                        title2: "Shipping Method",
                        d1: data["order_code"],
                        d2: data["shipping_method"]),
                    orderPlaceDetails(
                        title1: "Order Date",
                        title2: "Payment Method",
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format((data["order_date"].toDate())),
                        d2: data["payment_method"]),
                    orderPlaceDetails(
                        title1: "Payment Status",
                        title2: "Delivery Status",
                        d1: "Order Placed",
                        d2: "Unpaid"),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Shipping Address",
                                  style: TextStyle(fontFamily: semibold)),
                              Text("Name: ${data["order_by_name"]}"),
                              Text("Email: ${data["order_by_email"]}"),
                              Text("Address: ${data["order_by_address"]}"),
                              Text("City: ${data["order_by_city"]}"),
                              Text("State: ${data["order_by_state"]}"),
                              Text("Phone: ${data["order_by_phone"]}"),
                              Text("PostalCode: ${data["order_by_postalcode"]}"),
                            ],
                          ),
                          SizedBox(
                            // height: 20,
                            width: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Amount",
                                    style: TextStyle(fontFamily: semibold)),
                                Text("${data["total_amount"]}",
                                    style: TextStyle(
                                        fontFamily: bold, color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Divider(),
              SizedBox(height: 10),

              Center(
                child: Text("Ordered Product",
                    style: TextStyle(
                        color: darkFontGrey, fontSize: 16, fontFamily: semibold)),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 2,
                    )
                  ],
                ),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(data["orders"].length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                          title1: data["orders"][index]["title"],
                          title2:  data["orders"][index]["tprice"],
                          d1: "${ data["orders"][index]["qty"]}x",
                          d2: "Refundable"
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            height: 20,
                            width: 30,
                            color: Color(data["orders"][index]["color"]),
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
