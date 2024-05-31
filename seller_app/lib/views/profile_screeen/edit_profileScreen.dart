import 'dart:io';

import 'package:seller_app/const/const.dart';
import 'package:seller_app/controllers/profile_controller.dart';
import 'package:seller_app/widgets/custom_textfield.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/normal_text.dart';
import 'package:velocity_x/velocity_x.dart';
//import 'package:d_mart_seller/controllers/profile_controler.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    // TODO: implement initState
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          backgroundColor: purpleColor,
          title: boldText(text: editProfile, size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator()
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);

                      //if image is not selected
                      if (controller.profileImagePath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink =
                            controller.snapshotData['imageUrl'];
                      }

                      //if old pass matches

                      if (controller.snapshotData['password'] ==
                          controller.oldPassController.text) {
                        await controller.changeAuthPassword(
                            email: controller.snapshotData['email'],
                            password: controller.oldPassController.text,
                            newpassword: controller.newPassController.text);

                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.newPassController.text);
                        VxToast.show(context, msg: "Updated");
                      } else if (controller
                              .oldPassController.text.isEmptyOrNull &&
                          controller.newPassController.text.isEmptyOrNull) {
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.snapshotData['password']);
                      } else {
                        VxToast.show(context, msg: "Some error occured");
                        controller.isloading(false);
                      }
                    },
                    child: normalText(text: save),
                  )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              controller.snapshotData['imageUrl'] == '' &&
                      controller.profileImagePath.isEmpty
                  ? Image.asset(imgProduct, width: 80, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()

                  //if data is not empty but controller path is empty
                  : controller.snapshotData['imageUrl'] != '' &&
                          controller.profileImagePath.isEmpty
                      ? Image.network(
                          controller.snapshotData['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()

                      //if both are empty
                      : Image.file(
                          File(controller.profileImagePath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: white),
                onPressed: () {
                  controller.changeImage(context);
                },
                child: normalText(text: changeimg, color: fontGrey),
              ),
              10.heightBox,
              const Divider(
                color: white,
              ),
              customTextFiled(
                  label: name,
                  hint: "eg. Jacob J Jose",
                  controller: controller.nameController),
              5.heightBox,
              30.heightBox,
              Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(text: "Change your password", color: white)),
              15.0.heightBox,
              CustomTextFieldHide(
                  label: password,
                  hint: passwordhint,
                  controller: controller.oldPassController),
              5.heightBox,
              CustomTextFieldHide(
                  label: confirmpswd,
                  hint: passwordhint,
                  controller: controller.newPassController),
              5.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
