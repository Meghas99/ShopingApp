import 'dart:io';

import 'package:get/get.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/controller/profile_controller.dart';
import 'package:shopping_mart/widgets/bg_widget.dart';
import 'package:shopping_mart/widgets/custom_textfield.dart';
import 'package:shopping_mart/widgets/our_buttons.dart';

class EditProfilescreen extends StatelessWidget {
  final dynamic data;
  const EditProfilescreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<profileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //if data image url and controller path is empty
            data['imageUril'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(
                    imgProfile2,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                //if data is not empty but controller path is empty

                : data['imageUril'] != '' && controller.profileImgPath.isEmpty
                    ? Image.network(
                        data['imageUril'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()

                    //if both are empty
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ourButton(
                color: redcolor,
                onpress: () {
                  controller.changeImage(context);
                },
                textcolor: whiteColor,
                title: "Change"),
            const Divider(),
            20.heightBox,
            customTextfield(
                controller: controller.nameController,
                hint: namehint,
                title: name,
                isPass: false),
            10.heightBox,
            customTextfield(
                controller: controller.oldpassController,
                hint: passwordhint,
                title: oldpass,
                isPass: true),
            10.heightBox,
            customTextfield(
                controller: controller.newpassController,
                hint: passwordhint,
                title: newpass,
                isPass: true),
            10.heightBox,
            controller.isloading.value
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redcolor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                        color: redcolor,
                        onpress: () async {
                          controller.isloading(true);

                          //if image is not selectd

                          if (controller.profileImgPath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileimagelink = data['imageUril'];
                          }
//if old password matches database
                          if (data['password'] ==
                              controller.oldpassController.text) {
                            await controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldpassController.text,
                                newpassword: controller.newpassController.text);
                            await controller.updateprofile(
                                imgUrl: controller.profileimagelink,
                                name: controller.nameController.text,
                                password: controller.newpassController.text);
                            VxToast.show(context, msg: "Updated");
                          } else {
                            VxToast.show(context, msg: "wrong old password");
                            controller.isloading(false);
                          }
                        },
                        textcolor: whiteColor,
                        title: "save"),
                  )
          ],
        )
            .box
            .white
            .shadow
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .rounded
            .make(),
      ),
    ));
  }
}
