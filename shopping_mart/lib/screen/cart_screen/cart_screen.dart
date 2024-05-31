import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/controller/auth_controller.dart';
import 'package:shopping_mart/controller/cart_controller.dart';
import 'package:shopping_mart/loading_indicator.dart';
import 'package:shopping_mart/screen/cart_screen/shipping_screen.dart';
import 'package:shopping_mart/screen/login/login_Screen.dart';
import 'package:shopping_mart/services/firestore_services.dart';
import 'package:shopping_mart/widgets/our_buttons.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 100,
          child: ourButton(
            color: redcolor,
            onpress: () {
              Get.to(() => const ShippingDetails());
            },
            title: "Proceed to shipping",
            textcolor: whiteColor,
          ),
        ),
        appBar: AppBar(
          title: "Shopping cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.network(
                                  "${data[index]['img']}",
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                title:
                                    "${data[index]['title']}   (x${data[index]['qty']})"
                                        .text
                                        .fontFamily(semibold)
                                        .size(16)
                                        .make(),
                                subtitle: "${data[index]['tprice']}"
                                    .text
                                    .color(redcolor)
                                    .fontFamily(semibold)
                                    .make(),
                                trailing: const Icon(
                                  Icons.delete,
                                  color: redcolor,
                                ).onTap(() {
                                  FirestoreServices.deleteDocument(
                                      data[index].id);
                                }),
                              );
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total price"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          Obx(
                            () => "${controller.totalP.value}"
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(redcolor)
                                .make(),
                          )
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(12))
                          .color(golden)
                          .width(context.screenWidth)
                          .roundedSM
                          .make(),
                      // SizedBox(
                      //   width: context.screenWidth - 60,
                      //   child: ourButton(
                      //       color: redcolor,
                      //       onpress: () {},
                      //       title: "Proceed to shipping",
                      //       textcolor: whiteColor),
                      // )
                    ],
                  ),
                );
              }
            }));
  }
}
