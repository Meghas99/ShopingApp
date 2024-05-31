import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/consts/list.dart';
import 'package:shopping_mart/controller/auth_controller.dart';
import 'package:shopping_mart/controller/profile_controller.dart';
import 'package:shopping_mart/loading_indicator.dart';
import 'package:shopping_mart/screen/chat_screen/messaging_screen.dart';
import 'package:shopping_mart/screen/order_screen/order_screeen.dart';
import 'package:shopping_mart/screen/profile_screen/components/details_cart.dart';
import 'package:shopping_mart/screen/login/login_Screen.dart';
import 'package:shopping_mart/screen/profile_screen/edit_profile.dart';
import 'package:shopping_mart/screen/wishlist_screen/wishlist_screen.dart';
import 'package:shopping_mart/services/firestore_services.dart';
import 'package:shopping_mart/widgets/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(profileController());
    //  FirestoreServices.getCounts();

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
            stream: FirestoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redcolor),
                  ),
                );
              } else {
                var data = snapshot.data!.docs[0];

                return SafeArea(
                  child: Column(
                    children: [
                      //edit profile button
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: const Align(
                                alignment: Alignment.topRight,
                                child: Icon(Icons.edit, color: whiteColor))
                            .onTap(() {
                          controller.nameController.text = data['name'];

                          Get.to(() => EditProfilescreen(
                                data: data,
                              ));
                        }),
                      ),

                      //users detail section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            data['imageUril'] == ''
                                ? Image.asset(
                                    imgProfile2,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make()
                                : Image.network(
                                    data['imageUril'],
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                            10.widthBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make(),
                                  5.heightBox,
                                  "${data['email']}".text.white.make()
                                ],
                              ),
                            ),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                  color: whiteColor,
                                )),
                                onPressed: () async {
                                  await Get.put(AuthController())
                                      .signoutMethod(context);
                                  Get.offAll(() => const LoginScreen());
                                },
                                child: logout.text.fontFamily(semibold).make()),
                          ],
                        ),
                      ),
                      20.heightBox,

                      FutureBuilder(
                          future: FirestoreServices.getCounts(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: loadingIndicator(),
                              );
                            } else {
                              var countData = snapshot.data;
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  detailsCard(
                                      count: countData[0].toString(),
                                      title: "in your cart",
                                      width: context.screenWidth / 3.3),
                                  detailsCard(
                                      count: countData[1].toString(),
                                      title: "in your wishlist",
                                      width: context.screenWidth / 3.3),
                                  detailsCard(
                                      count: countData[2].toString(),
                                      title: "in your order",
                                      width: context.screenWidth / 3.3),
                                ],
                              );
                            }
                          }),

                      //button section
                      40.heightBox,
                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: lightGrey,
                          );
                        },
                        itemCount: ProfileButtonList.length,
                        itemBuilder: (BuildContext context, index) {
                          return ListTile(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => const Orderscreen());
                                  break;
                                case 1:
                                  Get.to(() => const WishListScreen());
                                  break;
                                case 2:
                                  Get.to(() => const MessagesScreen());
                                  break;
                                default:
                              }
                            },
                            leading: Image.asset(
                              profileButtonsIcon[index],
                              width: 22,
                            ),
                            title: ProfileButtonList[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                          );
                        },
                      )
                          .box
                          .white
                          .rounded
                          .margin(const EdgeInsets.all(12))
                          .padding(const EdgeInsets.symmetric(horizontal: 15))
                          .shadow
                          .make()
                          .box
                          .color(redcolor)
                          .make()
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
