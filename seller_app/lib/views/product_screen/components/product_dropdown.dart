import 'package:seller_app/const/const.dart';
import 'package:seller_app/controllers/product_controller.dart';
import 'package:seller_app/widgets/normal_text.dart';
import 'package:velocity_x/velocity_x.dart';

Widget productDropdown(
    hint, List<String> list, dropvalue, ProductController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
      child: DropdownButton(
          hint: normalText(
              //text: "choose category",
              text: "$hint",
              color: fontGrey),
          //value: null,
          value: dropvalue.value == '' ? null : dropvalue.value,
          isExpanded: true,
          items: list.map((e) {
            return DropdownMenuItem(
              value: e,
              child: e.toString().text.make(),
            );
          }).toList(),
          // items: const [],
          onChanged: (newValue) {
            if (hint == "Category") {
              controller.subcategoryvalue.value = '';

              controller.populatedSubCategory(newValue.toString());
            }
            dropvalue.value = newValue.toString();
          }),
    )
        .box
        .white
        .roundedSM
        .padding(const EdgeInsets.symmetric(horizontal: 4))
        .make(),
  );
}
