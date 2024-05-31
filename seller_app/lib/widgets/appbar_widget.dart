// ignore_for_file: depend_on_referenced_packages

import 'package:seller_app/const/const.dart';
import 'package:intl/intl.dart' as intl;
import 'package:seller_app/widgets/normal_text.dart';
import 'package:velocity_x/velocity_x.dart';

AppBar appBarWidget(title) {
  return AppBar(
    backgroundColor: white,
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: fontGrey, size: 16.0),
    actions: [
      Center(
          child: normalText(
              text: intl.DateFormat('EEE,MMM,d,' 'yy').format(DateTime.now()),
              color: purpleColor)),
      25.widthBox,
    ],
  );
}
