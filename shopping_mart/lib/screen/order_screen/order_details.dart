import 'package:intl/intl.dart' as intl;
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/screen/order_screen/components/order_place_details.dart';
import 'package:shopping_mart/screen/order_screen/components/order_status.dart';

class OrderDetails extends StatelessWidget {
  final dynamic datas;
  const OrderDetails({super.key, this.datas});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Order Details"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                orderStatus(
                    color: redcolor,
                    icon: Icons.done,
                    title: "Placed",
                    showDone: datas[0]['order_placed']),
                orderStatus(
                    color: Vx.blue900,
                    icon: Icons.thumb_up,
                    title: "Confirmed",
                    showDone: datas[0]['order_confirmed']),
                orderStatus(
                    color: Colors.yellow,
                    icon: Icons.car_crash,
                    title: "Delivery",
                    showDone: datas[0]['order_on_delivery']),
                orderStatus(
                    color: Colors.purple,
                    icon: Icons.done,
                    title: "Delivered",
                    showDone: datas[0]['order_delivered']),
                const Divider(),
                10.heightBox,
                Column(
                  children: [
                    orderPlaceDetails(
                        d1: datas[0]['order_code'],
                        d2: datas[0]['shipping_method'],
                        title1: "Order Code",
                        title2: "Shipping Method"),
                    orderPlaceDetails(
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format((datas[0]['order_date'].toDate())),
                        d2: datas[0]['payment_method'],
                        title1: "Order date",
                        title2: "payment Method"),
                    orderPlaceDetails(
                        d1: "Unpaid",
                        d2: "Order Placed",
                        title1: "Payment Status",
                        title2: "Delivery Status"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Shipping Address"
                                  .text
                                  .fontFamily(semibold)
                                  .make(),
                              "${datas[0]['order_by_name']}".text.make(),
                              "${datas[0]['order_by_email']}".text.make(),
                              "${datas[0]['order_by_address']}".text.make(),
                              "${datas[0]['order_by_city']}".text.make(),
                              "${datas[0]['order_by_state']}".text.make(),
                              "${datas[0]['order_by_phone']}".text.make(),
                              "${datas[0]['order_by_postalCode']}".text.make(),
                            ],
                          ),
                          SizedBox(
                            width: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Total amount".text.fontFamily(semibold).make(),
                                "${datas[0]['total_amount']}"
                                    .text
                                    .color(redcolor)
                                    .fontFamily(bold)
                                    .make(),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ).box.outerShadowMd.white.make(),
                const Divider(),
                10.heightBox,
                "Ordered Product"
                    .text
                    .size(16)
                    .color(darkFontGrey)
                    .fontFamily(semibold)
                    .makeCentered(),
                10.heightBox,
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(datas[0]['orders'].length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                            title1: datas[0]['orders'][index]['title'],
                            title2: datas[0]['orders'][index]['tprice'],
                            d1: "${datas[0]['orders'][index]['qty']}x",
                            d2: "Refundable"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            //  padding: const EdgeInsets.symmetric(horizontal: 16),
                            width: 30,
                            height: 20,
                            color: Color(datas[0]['orders'][index]['color']),
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  }).toList(),
                )
                    .box
                    .outerShadowMd
                    .white
                    .margin(const EdgeInsets.only(bottom: 4))
                    .make(),
                10.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
