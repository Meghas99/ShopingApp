import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shopping_mart/screen/cart_screen/cart_screen.dart';
import 'package:shopping_mart/screen/category_screen/category_screen.dart';
import 'package:shopping_mart/consts/consts.dart';
import 'package:shopping_mart/controller/home_screen.dart';
import 'package:shopping_mart/screen/profile_screen/profile_screen.dart';
import 'package:shopping_mart/screen/homescreen/home_screen.dart';
import 'package:shopping_mart/widgets/exit_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account)
    ];

    var navBody = [
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen()
    ];
    return WillPopScope(
      onWillPop: () async {
        showDialog(context: context, builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIntex.value))),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIntex.value,
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: redcolor,
            selectedLabelStyle: TextStyle(fontFamily: semibold),
            items: navbarItem,
            onTap: (Value) {
              controller.currentNavIntex.value = Value;
            },
          ),
        ),
      ),
    );
  }
}
