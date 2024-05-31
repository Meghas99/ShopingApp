import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/views/product_screen/product_details.dart';
import 'package:seller_app/widgets/appbar_widget.dart';
import 'package:seller_app/widgets/dashboard_button.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/normal_text.dart';
import 'package:velocity_x/velocity_x.dart';
//import 'package:seller_app/services/store_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: appBarWidget(dashbord),
        body: StreamBuilder(
            stream: StoreServices.getProducts(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              } else {
                var data = snapshot.data!.docs;

                data = data.sortedBy((a, b) =>
                    b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashbordButton(context,
                              title: products,
                              count: "${data.length}",
                              icon: icProducts),
                          dashbordButton(context,
                              title: orders, count: 269, icon: icOrders),
                        ],
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashbordButton(context,
                              title: rating, count: 4.5, icon: icStar),
                          dashbordButton(context,
                              title: totalSales, count: 135, icon: icOrders),
                        ],
                      ),
                      10.heightBox,
                      const Divider(),
                      10.heightBox,
                      boldText(
                          text: popularproducts, color: darkGrey, size: 16.0),
                      20.heightBox,
                      ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            data.length,
                            (index) => data[index]['p_wishlist'].length == 0
                                ? const SizedBox()
                                : ListTile(
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
                                        // text: "\$40",
                                        color: fontGrey,
                                        size: 14.0),
                                    subtitle: normalText(
                                        text: "${data[index]['p_price']}",
                                        // text: "\$40",
                                        color: darkGrey,
                                        size: 12.0),
                                  )),
                      )
                    ],
                  ),
                );
              }
            }));
  }
}
