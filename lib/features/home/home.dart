import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/features/orders/order_screen.dart';
import 'package:pick_n_pay_user/features/profile/profile_screen.dart';
import 'package:pick_n_pay_user/features/showcase_page/showcase_page.dart';
import 'package:pick_n_pay_user/theme/app_theme.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../cart/cart_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: selectedIndex != 3
          ? AppBar(
              title: const Text(
                "Pick N Pay",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              backgroundColor: primaryColor,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartScreen(),
                        ));
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          : null,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          Center(child: Text("Map Page")),
          ShowcasePage(),
          OrderScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: WaterDropNavBar(
        waterDropColor: primaryColor,
        backgroundColor: Colors.white,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          pageController.animateToPage(
            selectedIndex,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutQuad,
          );
        },
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            filledIcon: CupertinoIcons.house_fill,
            outlinedIcon: CupertinoIcons.house,
          ),
          BarItem(
            filledIcon: Icons.storefront_rounded,
            outlinedIcon: Icons.storefront,
          ),
          BarItem(
            filledIcon: Icons.shopping_bag,
            outlinedIcon: Icons.shopping_bag_outlined,
          ),
          BarItem(
            filledIcon: Icons.person_2,
            outlinedIcon: Icons.person_2_outlined,
          ),
        ],
      ),
    );
  }
}
