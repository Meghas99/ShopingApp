import 'package:seller_app/const/const.dart';
import 'package:seller_app/controllers/home_controller.dart';
import 'package:seller_app/views/home_screen/home_screen.dart';
import 'package:seller_app/views/order_screen/order_screen.dart';
import 'package:seller_app/views/product_screen/product_screen.dart';
import 'package:seller_app/views/profile_screeen/profile_screen.dart';
import 'package:seller_app/widgets/normal_text.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreens = [
      const HomeScreen(),
      const ProductScreen(),
      const OrderScreen(),
      const ProfileScreen()
    ];

    var bottomNavBar = [
      const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined), label: dashbord),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            color: darkGrey,
            width: 24,
          ),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            color: darkGrey,
            width: 24,
          ),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeranalsettings,
            color: darkGrey,
            width: 24,
          ),
          label: settings),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            onTap: (index) {
              controller.navIndex.value = index;
            },
            currentIndex: controller.navIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: purpleColor,
            unselectedItemColor: darkGrey,
            items: bottomNavBar),
      ),

      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: boldText(text: dashbord, color: fontGrey, size: 18.0),
      // ),

      body: Obx(
        () => Column(
          children: [
            Expanded(child: navScreens.elementAt(controller.navIndex.value))
          ],
        ),
      ),
    );
  }
}
