import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/features/showcase_page/category_card.dart';

class SeeAllCategory extends StatelessWidget {
  const SeeAllCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CategoryList()),
      ),
    );
  }
}
