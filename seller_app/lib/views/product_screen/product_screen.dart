import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/controllers/product_controller.dart';
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/views/product_screen/add_product.dart';
import 'package:seller_app/views/product_screen/product_details.dart';
import 'package:seller_app/widgets/appbar_widget.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/normal_text.dart';
import 'package:velocity_x/velocity_x.dart';
//import 'package:seller_app/controllers/product_controller.dart';
//import 'package:seller_app/services/store_services.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await controller.getcategories();
            controller.populatedCategoryList();
            Get.to(() => const AddProduct());
          },
          backgroundColor: flotingcolor,
          child: const Icon(Icons.add),
        ),
        appBar: appBarWidget(products),
        body: StreamBuilder(
            stream: StoreServices.getProducts(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        children: List.generate(
                      data.length,
                      (index) => ListTile(
                        onTap: () {
                          Get.to(() => ProductDetails(
                                data: data[index],
                              ));
                        },
                        leading: Image.network(
                          data[index]['p_images'][0],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        title: boldText(
                            text: "${data[index]['p_name']}",
                            color: fontGrey,
                            size: 14.0),
                        subtitle: Row(
                          children: [
                            normalText(
                                text: "${data[index]['p_price']}",
                                color: darkGrey,
                                size: 12.0),
                            10.widthBox,
                            boldText(
                                text: data[index]['is_featured'] == true
                                    ? "Featured"
                                    : "",
                                color: green)
                          ],
                        ),
                        trailing: VxPopupMenu(
                            arrowSize: 0.0,
                            menuBuilder: () => Column(
                                  children: List.generate(
                                      popupMenuIcons.length,
                                      (i) => Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  popupMenuIcons[i],
                                                  color:
                                                      data[index]['featured_id'] ==
                                                                  currentUser!
                                                                      .uid &&
                                                              i == 0
                                                          ? green
                                                          : darkGrey,
                                                ),
                                                10.widthBox,
                                                normalText(
                                                    text:
                                                        data[index]['featured_id'] ==
                                                                    currentUser!
                                                                        .uid &&
                                                                i == 0
                                                            ? "Remove feature"
                                                            : popMenuTitles[i],
                                                    color: darkGrey)
                                              ],
                                            ).onTap(() {
                                              switch (i) {
                                                case 0:
                                                  if (data[index]
                                                          ['is_featured'] ==
                                                      true) {
                                                    controller.removeFeatured(
                                                        data[index].id);

                                                    VxToast.show(context,
                                                        msg: "Removed");
                                                  } else {
                                                    controller.addFeatured(
                                                        data[index].id);
                                                    VxToast.show(context,
                                                        msg: "Added");
                                                  }

                                                  break;

                                                case 1:
                                                  break;
                                                case 2:
                                                  controller.removeProducts(
                                                      data[index].id);
                                                  VxToast.show(context,
                                                      msg: "Product removed");
                                                  break;

                                                default:
                                              }
                                            }),
                                          )),
                                ).box.roundedSM.white.width(200).make(),
                            clickType: VxClickType.singleClick,
                            child: const Icon(Icons.more_vert_outlined)),
                      ),
                    )),
                  ),
                );
              }
            })

        //     Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: SingleChildScrollView(
        //     physics: const BouncingScrollPhysics(),
        //     child: Column(
        //       children: List.generate(
        //           20,
        //           (index) => ListTile(
        //                 onTap: () {
        //                   Get.to(() => const ProductDetails());
        //                 },
        //                 leading: Image.asset(
        //                   imgProduct,
        //                   width: 100,
        //                   height: 100,
        //                   fit: BoxFit.cover,
        //                 ),
        //                 title: boldText(
        //                     text: "Product title", color: fontGrey, size: 14.0),
        //                 subtitle: Row(
        //                   children: [
        //                     normalText(
        //                         text: "₹ 40.0", color: darkGrey, size: 12.0),
        //                     10.widthBox,
        //                     boldText(text: "Featured", color: green)
        //                   ],
        //                 ),
        //                 trailing: VxPopupMenu(
        //                     arrowSize: 0.0,
        //                     menuBuilder: () => Column(
        //                           children: List.generate(
        //                               popupMenuIcons.length,
        //                               (index) => Padding(
        //                                     padding: const EdgeInsets.all(12.0),
        //                                     child: Row(
        //                                       children: [
        //                                         Icon(popupMenuIcons[index]),
        //                                         10.widthBox,
        //                                         normalText(
        //                                             text: popMenuTitles[index],
        //                                             color: darkGrey)
        //                                       ],
        //                                     ).onTap(() {}),
        //                                   )),
        //                         ).box.roundedSM.white.width(200).make(),
        //                     clickType: VxClickType.singleClick,
        //                     child: const Icon(Icons.more_vert_outlined)),
        //               )),
        //     ),
        //   ),
        // )

        );
  }
}
