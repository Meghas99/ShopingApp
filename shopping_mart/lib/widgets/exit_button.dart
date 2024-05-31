import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/widgets/our_buttons.dart';

Widget exitDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are you sure you want to exit ?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: redcolor,
                onpress: () {
                  SystemNavigator.pop();
                },
                textcolor: whiteColor,
                title: "yes"),
            ourButton(
                color: redcolor,
                onpress: () {
                  Navigator.pop(context);
                },
                textcolor: whiteColor,
                title: "No"),
          ],
        )
      ],
    ).box.color(lightGrey).roundedSM.make(),
  );
}
