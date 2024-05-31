import 'package:seller_app/const/const.dart';
import 'package:velocity_x/velocity_x.dart';

Widget productImages({required label, onPress}) {
  return "$label"
      .text
      .bold
      .size(16.0)
      .color(fontGrey)
      .makeCentered()
      .box
      .color(lightGrey)
      .size(100, 100)
      .roundedSM
      .make();
}
