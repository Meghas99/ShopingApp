import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shopping_mart/consts/consts.dart';

import 'package:shopping_mart/controller/auth_controller.dart';
import 'package:shopping_mart/screen/homescreen/home.dart';
import 'package:shopping_mart/widgets/applogo.dart';
import 'package:shopping_mart/widgets/bg_widget.dart';
import 'package:shopping_mart/widgets/custom_textfield.dart';
import 'package:shopping_mart/widgets/our_buttons.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;

  var controller = Get.put(AuthController());

  //textcontroller
  var nameContoller = TextEditingController();
  var emailContoller = TextEditingController();
  var passwordContoller = TextEditingController();
  var passwordRetypeContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.07).heightBox,
          applogo(),
          10.heightBox,
          "join in SMart $appname".text.fontFamily(bold).white.size(18).make(),
          10.heightBox,
          Obx(
            () => Column(
              children: [
                customTextfield(
                    hint: namehint,
                    title: name,
                    controller: nameContoller,
                    isPass: false),
                customTextfield(
                    title: email,
                    hint: emailHint,
                    controller: emailContoller,
                    isPass: false),
                customTextfield(
                    title: password,
                    hint: passwordhint,
                    controller: passwordContoller,
                    isPass: true),
                customTextfield(
                    title: retypePassword,
                    hint: passwordhint,
                    controller: passwordRetypeContoller,
                    isPass: true),

                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgetPAss.text.make())),
                5.heightBox,
                //ourButton().box.width(context.screenWidth-50).make(),

                Row(
                  children: [
                    Checkbox(
                        activeColor: redcolor,
                        checkColor: whiteColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        }),
                    10.widthBox,
                    Expanded(
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            )),
                        TextSpan(
                            text: termsandCount,
                            style: TextStyle(
                              fontFamily: regular,
                              color: redcolor,
                            )),
                        TextSpan(
                            text: " & ",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            )),
                        TextSpan(
                            text: privacyPolicy,
                            style: TextStyle(
                              fontFamily: bold,
                              color: redcolor,
                            ))
                      ])),
                    )
                  ],
                ),
                5.heightBox,
                controller.isloading.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redcolor),
                      )
                    : ourButton(
                        color: isCheck == true ? redcolor : blue,
                        title: signup,
                        textcolor: whiteColor,
                        onpress: () async {
                          if (isCheck != false) {
                            try {
                              controller.isloading(true);
                              await controller
                                  .signupMethod(
                                      email: emailContoller.text,
                                      password: passwordContoller.text,
                                      context: context)
                                  .then((value) {
                                return controller.storeuserData(
                                    email: emailContoller.text,
                                    password: passwordContoller.text,
                                    name: nameContoller.text);
                              }).then((value) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              });
                            } catch (e) {
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                              controller.isloading(false);
                            }
                          }
                        }).box.width(context.screenWidth - 50).make(),

                10.heightBox,
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: alreadyHaveAccount,
                      style: TextStyle(fontFamily: bold, color: fontGrey)),
                  TextSpan(
                      text: login,
                      style: TextStyle(fontFamily: bold, color: redcolor))
                ])).onTap(() {
                  Get.back();
                })
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          )
        ],
      )),
    ));
  }
}
