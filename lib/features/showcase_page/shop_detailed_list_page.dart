import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/features/showcase_page/product_card.dart';

class ShopDetailedListPage extends StatelessWidget {
  const ShopDetailedListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Shop name",
                style: TextStyle(color: Colors.black),
              ),
              background: Image.network(
                "https://www.shutterstock.com/shutterstock/photos/2152391795/display_1500/stock-photo-tirupati-andhra-pradesh-india-september-an-indian-shopkeeper-selling-snacks-and-drinks-at-2152391795.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => SizedBox(
                height: 170,
                child: ProductCard(
                    imageUrl:
                        'http://4.bp.blogspot.com/-97neiRv5w_Y/UZ_DQXVaUeI/AAAAAAAAGJI/R4wetsbFGbs/s1600/bc-cherries-1.png',
                    title: 'Cherry',
                    subtitle: 'Cherry pazham',
                    price: '56',
                    cardColor: Colors.white,
                    buttonColor: Colors.green),
              ),
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
