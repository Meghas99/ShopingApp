// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_app/const/const.dart';
import 'package:intl/intl.dart' as intl;
import 'package:seller_app/controllers/orders_controller.dart';
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/views/order_screen/order_details.dart';
import 'package:seller_app/widgets/appbar_widget.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/normal_text.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrderController());
    return Scaffold(
      appBar: appBarWidget(orders),
      body: StreamBuilder(
          stream: StoreServices.getOrders(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var time = data[index]['order_date'].toDate();
                      return ListTile(
                        onTap: () {
                          Get.to(() => OrderDetails(
                                data: data[index],
                              ));
                        },
                        tileColor: textfieldGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        title: boldText(
                            text: "${data[index]['order_code']}",
                            color: purpleColor,
                            size: 14.0),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month_rounded,
                                  color: fontGrey,
                                ),
                                10.widthBox,
                                boldText(
                                    text: intl.DateFormat()
                                        .add_yMd()
                                        .format(time),
                                    color: fontGrey,
                                    size: 12.0),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.payment_sharp,
                                  color: fontGrey,
                                ),
                                10.widthBox,
                                boldText(text: unpaid, color: red)
                              ],
                            ),
                          ],
                        ),
                        trailing: boldText(
                            text: "${data[index]['total_amount']}",
                            color: purpleColor),
                      ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                    }),
                  ),
                ),
              );
            }
          }),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: SingleChildScrollView(
      //     physics: const BouncingScrollPhysics(),
      //     child: Column(
      //       children: List.generate(
      //           15,
      //           (index) => ListTile(
      //                 onTap: () {
      //                   Get.to(() => const OrderDetails());
      //                 },
      //                 tileColor: textfieldGrey,
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(12)),
      //                 title: boldText(
      //                     text: "894651230.", color: purpleColor, size: 14.0),
      //                 subtitle: Column(
      //                   children: [
      //                     Row(
      //                       children: [
      //                         const Icon(
      //                           Icons.calendar_month_rounded,
      //                           color: fontGrey,
      //                         ),
      //                         10.widthBox,
      //                         boldText(
      //                             text: intl.DateFormat()
      //                                 .add_yMd()
      //                                 .format(DateTime.now()),
      //                             color: fontGrey,
      //                             size: 12.0),
      //                       ],
      //                     ),
      //                     Row(
      //                       children: [
      //                         const Icon(
      //                           Icons.payment_sharp,
      //                           color: fontGrey,
      //                         ),
      //                         10.widthBox,
      //                         boldText(text: unpaid, color: red)
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //                 trailing: boldText(text: "₹40.0", color: purpleColor),
      //               ).box.margin(const EdgeInsets.only(bottom: 4)).make()),
      //     ),
      //   ),
      // ),
    );
  }
}
