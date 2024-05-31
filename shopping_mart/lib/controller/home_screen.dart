import 'package:get/get.dart';
import 'package:shopping_mart/consts/consts.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getusername();
    super.onInit();
  }

  var currentNavIntex = 0.obs;

  var username = '';
  var searchController = TextEditingController();

  getusername() async {
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    username = n;
    print(username);
  }
}
