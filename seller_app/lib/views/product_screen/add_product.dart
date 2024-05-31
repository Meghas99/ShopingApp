import 'package:seller_app/const/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_app/controllers/product_controller.dart';
import 'package:seller_app/views/product_screen/components/product_dropdown.dart';
import 'package:seller_app/views/product_screen/components/product_images.dart';
import 'package:seller_app/widgets/custom_textfield.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/normal_text.dart';
import 'package:velocity_x/velocity_x.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return Obx(() => Scaffold(
          backgroundColor: purpleColor,
          appBar: AppBar(
            backgroundColor: purpleColor,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: white,
              ),
            ),
            title: boldText(text: "Add Product", color: white, size: 16.0),
            actions: [
              controller.isloading.value
                  ? loadingIndicator(circleColor: white)
                  : TextButton(
                      onPressed: () async {
                        controller.isloading(true);
                        await controller.uploadImages();
                        await controller.uploadProducts(context);
                        Get.back();
                      },
                      child: normalText(text: save, color: white),
                    ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTextFiled(
                    hint: "eg. BMW",
                    label: "Product Name",
                    controller: controller.pNameController,
                  ),
                  10.heightBox,
                  customTextFiled(
                    hint: "eg. Description",
                    label: "Description",
                    isDesc: true,
                    controller: controller.pDescController,
                  ),
                  10.heightBox,
                  customTextFiled(
                    hint: "eg. 15000",
                    label: "Price",
                    controller: controller.pPriceController,
                  ),
                  10.heightBox,
                  customTextFiled(
                    hint: "eg. 549",
                    label: "Quantity",
                    controller: controller.pQuantityController,
                  ),
                  10.heightBox,
                  productDropdown(
                    "Category",
                    controller.categoryList,
                    controller.categoryvalue,
                    controller,
                  ),
                  10.heightBox,
                  productDropdown(
                    "Subcategory",
                    controller.subcategoryList,
                    controller.subcategoryvalue,
                    controller,
                  ),
                  10.heightBox,
                  const Divider(color: white),
                  boldText(
                      text: "Choose Product Images",
                      color: white.withOpacity(.85)),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        3,
                        (index) => controller.pImagesList[index] != null
                            ? Image.file(controller.pImagesList[index]!,
                                    width: 100)
                                .onTap(() {
                                controller.pickImage(index, context);
                              })
                            : productImages(label: "${index + 1}").onTap(() {
                                controller.pickImage(index, context);
                              }),
                        //  productImages(label: "${index + 1}")
                      ),
                    ),
                  ),
                  10.heightBox,
                  normalText(
                    text: "First image will be your display image",
                    color: lightGrey.withOpacity(.40),
                  ),
                  10.heightBox,
                  const Divider(color: white),
                  boldText(
                      text: "Choose Product Color",
                      color: white.withOpacity(.85)),
                  10.heightBox,
                  Obx(
                    () => Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(
                        9,
                        (index) => Stack(
                          alignment: Alignment.center,
                          children: [
                            VxBox()
                                .color(Vx.randomPrimaryColor)
                                .roundedFull
                                .margin(const EdgeInsets.all(8))
                                .size(70, 70)
                                .make()
                                .onTap(() {
                              controller.selectedColorIndex.value = index;
                            }),
                            controller.selectedColorIndex.value == index
                                ? const Icon(Icons.done, color: white)
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
