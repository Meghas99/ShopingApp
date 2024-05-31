import 'package:seller_app/const/const.dart';
import 'package:seller_app/controllers/profile_controller.dart';
import 'package:seller_app/widgets/custom_textfield.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/normal_text.dart';
import 'package:velocity_x/velocity_x.dart';

class ShopSetting extends StatelessWidget {
  const ShopSetting({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopSettings, size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.updateShop(
                        shopAddress: controller.ShopAddressController.text,
                        shopMobile: controller.ShopMobController.text,
                        shopName: controller.ShopNameController.text,
                        shopwebsite: controller.ShopWebsiteController.text,
                        shopdesc: controller.ShopDescController.text,
                      );
                      VxToast.show(context, msg: "Shop details updated");
                    },
                    child: normalText(text: save),
                  )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextFiled(
                  label: shopName,
                  hint: nameHint,
                  controller: controller.ShopNameController),
              10.heightBox,
              customTextFiled(
                  label: address,
                  hint: shopAddress,
                  controller: controller.ShopAddressController),
              10.heightBox,
              customTextFiled(
                  label: mobile,
                  hint: shopMobileHint,
                  controller: controller.ShopMobController),
              10.heightBox,
              customTextFiled(
                  label: website,
                  hint: shopWebsiteHint,
                  controller: controller.ShopWebsiteController),
              10.heightBox,
              customTextFiled(
                  label: decsription,
                  hint: shopDescHint,
                  isDesc: true,
                  controller: controller.ShopDescController),
            ],
          ),
        ),
      ),
    );
  }
}
