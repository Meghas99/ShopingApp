import 'package:flutter/material.dart';
import 'package:shopping_mart/consts/consts.dart';

Widget applogo() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(EdgeInsets.all(8))
      .rounded
      .make();
}
