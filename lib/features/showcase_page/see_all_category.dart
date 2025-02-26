import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/features/showcase_page/category_card.dart';
import 'package:pick_n_pay_user/features/showcase_page/products_show_screen.dart';

class SeeAllCategory extends StatelessWidget {
  const SeeAllCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) => CategoryCard(
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsShowScreen(),
                    ));
              },
            ),
            itemCount: 10,
          ),
        ),
      ),
    );
  }
}
