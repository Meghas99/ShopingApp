import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_app/const/const.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  //text controllrs

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isPasswordVisible = true.obs;

  //log i n metord

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? "An error occurred");
    }

    return userCredential;
  }

  // storinng data method
  storeUserdata({
    name,
    pswd,
    email,
  }) async {
    DocumentReference store =
        firestore.collection(vendorCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'pswd': pswd,
      'email': email,
      'imageurl': '',
      'id': currentUser!.uid,
      'cart_count': '00',
      'wishlist_count': '00',
      'order_count': '00'
    });
  }

  signoutMethood(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
