import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_search.dart';
import 'package:pick_n_pay_user/features/cart/cart_screen.dart';
import 'package:pick_n_pay_user/features/showcase_page/category_card.dart';
import 'package:pick_n_pay_user/features/showcase_page/products_show_screen.dart';
import 'package:pick_n_pay_user/features/showcase_page/see_all_category.dart';
import 'package:pick_n_pay_user/features/showcase_page/shop_card.dart';
import 'package:pick_n_pay_user/features/showcase_page/shop_detailed_list_page.dart';
import 'package:pick_n_pay_user/theme/app_theme.dart';

class ShowcasePage extends StatelessWidget {
  const ShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example cart item count
    int cartItemCount = 3;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's Order Grocery Items",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.normal, color: Colors.black45),
                  ),
                  Text(
                    'Tendulker',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  )
                ],
              ),
              const Spacer(),
              Stack(
                children: [
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
                      color: primaryColor,
                    ),
                  ),
                  if (cartItemCount > 0)
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$cartItemCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Search Bar
          Row(
            children: [
              Expanded(
                child: CustomSearch(
                  onSearch: (query) {},
                ),
              ),
              IconButton(
                color: primaryColor,
                onPressed: () {},
                icon: const Icon(Icons.tune),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Banner Section
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 15),

          // Top Categories
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Categories',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeeAllCategory(),
                      ));
                },
                child: Text(
                  'See all',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 115,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) => CategoryCard(
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductsShowScreen(),
                      ));
                },
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Shops Section
          Text(
            'Shops',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          ),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black26,
            ),
            itemBuilder: (context, index) => ShopCard(
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopDetailedListPage(),
                    ));
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
