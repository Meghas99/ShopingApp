import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/controllers/auth_controller.dart';
import 'package:seller_app/views/home_screen/home.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/normal_text.dart';
import 'package:seller_app/widgets/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.heightBox,
              normalText(text: welcome, size: 18.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(
                    icLogo,
                    width: 70,
                    height: 80,
                  )
                      .box
                      .border(color: white)
                      .rounded
                      .padding(const EdgeInsets.all(8.0))
                      .make(),
                  10.widthBox,
                  boldText(
                    text: appname,
                    size: 22.0,
                  ),
                ],
              ),
              60.heightBox,
              normalText(text: loginTo, size: 18.0, color: lightGrey),
              20.heightBox,
              Obx(
                () => Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                        hintText: emailhint,
                        prefixIcon: Icon(
                          Icons.email,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    10.heightBox,
                    TextFormField(
                      controller: controller.passwordController,
                      obscureText: controller.isPasswordVisible.value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                        hintText: passwordhint,
                        prefixIcon: const Icon(
                          Icons.password,
                          color: purpleColor,
                        ),
                        suffixIcon: IconButton(
                          icon:  Icon(
                            
                              controller.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: purpleColor,
                          ),
                          onPressed: () {
                            controller.togglePasswordVisibility();
                          },
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    10.heightBox,
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: normalText(
                          text: forgotPassword,
                          color: purpleColor,
                        ),
                      ),
                    ),
                    20.heightBox,
                    SizedBox(
                      width: context.screenWidth - 100,
                         child: controller.isloading.value
                            ? loadingIndicator()
                      : ourButton(
                        title: login,
                        color: purpleColor,
                        

                        onPress: () async {
                          controller.isloading(true);
                          await controller
                              .loginMethod(context: context)
                              .then((value) {
                            if (value != null) {
                              VxToast.show(context, msg: "Logged in");
                              controller.isloading(false);
                              Get.offAll(() => const Home());
                            } else {
                              controller.isloading(false);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .outerShadowMd
                    .padding(const EdgeInsets.all(8))
                    .make(),
              ),
              20.heightBox,
              Center(child: normalText(text: anyProblem, color: lightGrey)),
              const Spacer(),
              Center(
                child: boldText(text: credit),
              ),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
  
  
}
