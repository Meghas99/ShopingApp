import 'package:seller_app/const/const.dart';

class StoreServices {
  static getProfile(uid) {
    return firestore
        .collection(vendorCollection)
        .where('id', isEqualTo: uid)
        .get();
  }

  static getMessage(uid) {
    return firestore
        .collection(chatCollection)
        .where('toId', isEqualTo: uid)
        .snapshots();
  }

  static getOrders(uid) {
    return firestore
        .collection(ordersCollection)
        .where('vendor', arrayContains: uid)
        .snapshots();
  }

  static getProducts(uid) {
    return firestore
        .collection(prodctsCollection)
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }

  // static getPopularProducts(uid) {
  //   return firestore
  //       .collection(prodctsCollection)
  //       .where('vendor_id', isEqualTo: uid)
  //       .orderBy('p_wishlist'.length);
  // }
}
