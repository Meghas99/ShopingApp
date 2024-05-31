import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/controllers/auth_controller.dart';
import 'package:seller_app/controllers/profile_controller.dart';
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/views/auth_screen/login_screen.dart';
import 'package:seller_app/views/message_screen/message_screen.dart';
import 'package:seller_app/views/profile_screeen/edit_profileScreen.dart';
import 'package:seller_app/views/shop_screen/shop_settingScreen.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/normal_text.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        backgroundColor: purpleColor,
        automaticallyImplyLeading: false,
        title: boldText(text: settings, size: 16.0),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => EditProfileScreen(
                    username: controller.snapshotData['vendor_name']));
              },
              icon: const Icon(
                Icons.edit,
                color: white,
              )),
          TextButton(
            onPressed: () async {
              await Get.find<AuthController>().signoutMethood(context);
              Get.offAll(() => const LogInScreen());
            },
            child: normalText(text: logout),
          )
        ],
      ),
      body: FutureBuilder(
          future: StoreServices.getProfile(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator(circleColor: white);
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: normalText(text: "No data found", color: white),
              );
            } else {
              print("test${snapshot.data!.size.toString()}");

              controller.snapshotData = snapshot.data!.docs[0];

              return Column(
                children: [
                  ListTile(
                    leading: controller.snapshotData['imageUrl'] == ''
                        ? Image.asset(
                            imgProduct,
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.network(controller.snapshotData['imageUrl'],
                                width: 100)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make(),
                    // leading: Image.asset(imgProduct)
                    //     .box
                    //     .roundedFull
                    //     .clip(Clip.antiAlias)
                    //     .make(),
                    title:
                        // boldText(text: "vendor name"),
                        boldText(
                            text: "${controller.snapshotData['vendor_name']}"),
                    subtitle:
                        normalText(text: "${controller.snapshotData['email']}"),
                  ),
                  const Divider(),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: List.generate(
                          profileButtonIcons.length,
                          (index) => ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(() => const ShopSetting());
                                      break;
                                    case 1:
                                      Get.to(() => const MessagesScreen());
                                      break;
                                    default:
                                  }
                                },
                                leading: Icon(
                                  profileButtonIcons[index],
                                  color: white,
                                ),
                                title: normalText(
                                    text: profileButtonTitles[index],
                                    color: white),
                              )),
                    ),
                  )
                ],
              );
            }
          }),
// body:
//  Column(
//         children: [
//           ListTile(
//             leading: Image.asset(imgProduct)
//                 .box
//                 .roundedFull
//                 .clip(Clip.antiAlias)
//                 .make(),
//             title: boldText(text: "Vendor name"),
//             subtitle: normalText(text: "vendoremail@email.com"),
//           ),
//           const Divider(),
//           10.heightBox,
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: List.generate(
//                   profileButtonIcons.length,
//                   (index) => ListTile(
//                         onTap: () {
//                           switch (index) {
//                             case 0:
//                               Get.to(() => const ShopSetting());
//                               break;
//                             case 1:
//                               Get.to(() => const MessagesScreen());
//                               break;
//                               default:
//                           }
//                         },
//                         leading: Icon(profileButtonIcons[index],color: white,),
//                         title: normalText(
//                             text: profileButtonTitles[index], color: white),
//                       )),
//             ),
//           )
//         ],
//       ),
    );
  }
}
