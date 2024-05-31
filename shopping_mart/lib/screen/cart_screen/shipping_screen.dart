import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/controller/cart_controller.dart';
import 'package:shopping_mart/screen/cart_screen/payment_method.dart';
import 'package:shopping_mart/widgets/custom_textfield.dart';
import 'package:shopping_mart/widgets/our_buttons.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        // automaticallyImplyLeading:false ,
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onpress: () {
            if (controller.addressController.text.length > 10) {
              Get.to(() => const PaymentMethods());
            } else {
              VxToast.show(context, msg: "Please fill the form");
            }
          },
          color: redcolor,
          textcolor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customTextfield(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            customTextfield(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            customTextfield(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.StateController),
            customTextfield(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.PostalController),
            customTextfield(
                hint: "Phone",
                isPass: false,
                title: "phone",
                controller: controller.phoneController)
          ],
        ),
      ),
    );
  }
}
