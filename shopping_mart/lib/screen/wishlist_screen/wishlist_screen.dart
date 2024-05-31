import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/loading_indicator.dart';
import 'package:shopping_mart/services/firestore_services.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getWishlist(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No wishlist yet".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              '${data[index]['p_images'][0]}',
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            title: '${data[index]['p_name']} '
                                .text
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                            subtitle: '${data[index]['p_price']}'
                                .numCurrency
                                .text
                                .color(redcolor)
                                .fontFamily(semibold)
                                .size(14)
                                .make(),
                            trailing: const Icon(
                              Icons.favorite,
                              color: redcolor,
                            ).onTap(() {
                              firestore
                                  .collection(productsCollection)
                                  .doc(data[index].id)
                                  .set({
                                'p_wishlist':
                                    FieldValue.arrayRemove([currentUser!.uid])
                              }, SetOptions(merge: true));
                            }),
                          );
                        }),
                  ),
                ],
              );
            }
          }),
    );
  }
}
