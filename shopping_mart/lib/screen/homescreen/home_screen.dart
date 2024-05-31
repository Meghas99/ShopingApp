import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/consts/list.dart';
import 'package:shopping_mart/controller/home_screen.dart';

import 'package:shopping_mart/loading_indicator.dart';
import 'package:shopping_mart/screen/category_screen/item_details.dart';
import 'package:shopping_mart/screen/homescreen/components/featured_button.dart';
import 'package:shopping_mart/screen/homescreen/search_screen.dart';
import 'package:shopping_mart/services/firestore_services.dart';
import 'package:shopping_mart/widgets/home_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
        color: lightGrey,
        padding: const EdgeInsets.all(12),
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 50,
                color: lightGrey,
                child: TextFormField(
                  controller: controller.searchController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: const Icon(Icons.search).onTap(() {
                        if (controller
                            .searchController.text.isNotEmptyAndNotNull) {
                          Get.to(() => SearchScrn(
                                title: controller.searchController.text,
                              ));
                        }
                      }),
                      filled: true,
                      fillColor: whiteColor,
                      hintText: searchanything,
                      hintStyle: const TextStyle(color: textfieldGrey)),
                ),
              ),
              10.heightBox,
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      //swipers brands

                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: slidersList.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              slidersList[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            2,
                            (index) => homeButton(
                                  height: context.screenHeight * 0.15,
                                  width: context.screenWidth / 2.5,
                                  icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                  title: index == 0 ? todayDeal : flashsale,
                                )),
                      ),
                      10.heightBox,
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: slidersList.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              secondSliderList[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            3,
                            (index) => homeButton(
                                  height: context.screenHeight * 0.15,
                                  width: context.screenWidth / 3.5,
                                  icon: index == 0
                                      ? icTopCategories
                                      : index == 1
                                          ? icBrands
                                          : icTopSeller,
                                  title: index == 0
                                      ? topcategories
                                      : index == 1
                                          ? brand
                                          : topsellers,
                                )),
                      ),

                      //featured categories
                      20.heightBox,
                      Align(
                          alignment: Alignment.centerLeft,
                          child: featuredCategoris.text
                              .color(darkFontGrey)
                              .size(18)
                              .fontFamily(semibold)
                              .make()),
                      20.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            3,
                            (index) => Column(
                              children: [
                                featuredButton(
                                    icon: featuredImages1[index],
                                    title: featuredTitle1[index]),
                                10.heightBox,
                                featuredButton(
                                    icon: featuredImages2[index],
                                    title: featuredTitle2[index]),
                              ],
                            ),
                          ).toList(),
                        ),
                      ),

                      //featured product
                      20.heightBox,
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: const BoxDecoration(color: redcolor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            featuredProduct.text.white
                                .fontFamily(bold)
                                .size(18)
                                .make(),
                            10.heightBox,
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: FutureBuilder(
                                    future:
                                        FirestoreServices.getFeaturedProducts(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: loadingIndicator(),
                                        );
                                      } else if (snapshot.data!.docs.isEmpty) {
                                        return "No featured products"
                                            .text
                                            .white
                                            .makeCentered();
                                      } else {
                                        var featuredData = snapshot.data!.docs;
                                        return Row(
                                          children: List.generate(
                                              featuredData.length,
                                              (index) => Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.network(
                                                        featuredData[index]
                                                            ['p_images'][0],
                                                        width: 130,
                                                        height: 130,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      10.heightBox,
                                                      "${featuredData[index]['p_name']}"
                                                          .text
                                                          .fontFamily(semibold)
                                                          .color(darkFontGrey)
                                                          .make(),
                                                      10.heightBox,
                                                      "${featuredData[index]['p_price']}"
                                                          .text
                                                          .color(redcolor)
                                                          .fontFamily(bold)
                                                          .size(16)
                                                          .make()
                                                    ],
                                                  )
                                                      .box
                                                      .white
                                                      .margin(const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4))
                                                      .rounded
                                                      .padding(
                                                          const EdgeInsets.all(
                                                              8))
                                                      .make()
                                                      .onTap(() {
                                                    Get.to(() => ItemDetails(
                                                          title:
                                                              "${featuredData[index]['p_name']}",
                                                          data: featuredData[
                                                              index],
                                                        ));
                                                  })),
                                        );
                                      }
                                    }))
                          ],
                        ),
                      ),

                      //third swiper

                      20.heightBox,
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: slidersList.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              secondSliderList[index],
                              fit: BoxFit.fill,
                            )
                                .box
                                .rounded
                                .clip(Clip.antiAlias)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 8))
                                .make();
                          }),

                      20.heightBox,
                      StreamBuilder(
                          stream: FirestoreServices.allProducts(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return loadingIndicator();
                            } else {
                              var allproductsdata = snapshot.data!.docs;
                              return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: allproductsdata.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        mainAxisExtent: 300),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                          allproductsdata[index]['p_images'][0],
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover),
                                      const Spacer(),
                                      "${allproductsdata[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "${allproductsdata[index]['p_price']}"
                                          .text
                                          .color(redcolor)
                                          .fontFamily(bold)
                                          .size(12)
                                          .make(),
                                      10.heightBox,
                                    ],
                                  ).box.white.roundedSM.make().onTap(() {
                                    Get.to(() => ItemDetails(
                                          title:
                                              "${allproductsdata[index]['p_name']}",
                                          data: allproductsdata[index],
                                        ));
                                  });
                                },
                              );
                            }
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
