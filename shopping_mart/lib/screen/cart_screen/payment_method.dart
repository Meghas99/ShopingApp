import 'package:get/get.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/consts/list.dart';
import 'package:shopping_mart/controller/cart_controller.dart';
import 'package:shopping_mart/loading_indicator.dart';
import 'package:shopping_mart/screen/homescreen/home.dart';
import 'package:shopping_mart/widgets/our_buttons.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: controller.placingOrder.value
            ? Center(
                child: loadingIndicator(),
              )
            : ourButton(
                onpress: () async {
                  await controller.placeMyOrder(
                      orderPaymentMethod:
                          paymentMethods[controller.paymentIndex.value],
                      totalAmount: controller.totalP.value);

                  await controller.clearCart();

                  VxToast.show(context, msg: "Order placed successfully");
                  Get.offAll(const Home());
                },
                color: redcolor,
                textcolor: whiteColor,
                title: "Place my order",
              ),
      ),
      appBar: AppBar(
        title: " Choose Payment method"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(
          () => Column(
              children: List.generate(paymentMethodsImg.length, (index) {
            return GestureDetector(
              onTap: () {
                controller.changePaymentIndex(index);
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: controller.paymentIndex.value == index
                          ? redcolor
                          : Colors.transparent,
                      // style: BorderStyle.solid,
                      width: 4,
                    )),
                margin: const EdgeInsets.only(bottom: 8),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(
                      paymentMethodsImg[index],
                      width: double.infinity,
                      height: 100,
                      color: controller.paymentIndex.value == index
                          ? Colors.black.withOpacity(0.4)
                          : Colors.transparent,
                      colorBlendMode: controller.paymentIndex.value == index
                          ? BlendMode.darken
                          : BlendMode.color,
                      fit: BoxFit.cover,
                    ),
                    controller.paymentIndex.value == index
                        ? Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                                activeColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                value: true,
                                onChanged: (Value) {}),
                          )
                        : Container(),
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: paymentMethods[index]
                          .text
                          .white
                          .fontFamily(semibold)
                          .size(16)
                          .make(),
                    )
                  ],
                ),
              ),
            );
          })),
        ),
      ),
    );
  }
}
