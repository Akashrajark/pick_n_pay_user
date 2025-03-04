import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/features/showcase_page/product_card.dart';

class ProductsShowScreen extends StatelessWidget {
  const ProductsShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
            itemBuilder: (context, index) => ProductCard(
              imageUrl:
                  'http://4.bp.blogspot.com/-97neiRv5w_Y/UZ_DQXVaUeI/AAAAAAAAGJI/R4wetsbFGbs/s1600/bc-cherries-1.png',
              title: 'Cherry',
              subtitle: 'surya mugaooo oooooooooo',
              price: '545',
              cardColor: Colors.white,
              buttonColor: Colors.green,
              onIncrement: () {},
              onDecrement: () {},
              counte: 0,
            ),
            itemCount: 10,
          ),
        ),
      ),
    );
  }
}
