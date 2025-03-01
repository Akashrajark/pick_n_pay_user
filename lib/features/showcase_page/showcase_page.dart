import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_search.dart';
import 'package:pick_n_pay_user/features/cart/cart_screen.dart';
import 'package:pick_n_pay_user/features/showcase_page/category_card.dart';
import 'package:pick_n_pay_user/features/showcase_page/dummy_data.dart';
import 'package:pick_n_pay_user/features/showcase_page/see_all_category.dart';
import 'package:pick_n_pay_user/features/showcase_page/shop_card.dart';
import 'package:pick_n_pay_user/features/showcase_page/shop_detailed_list_page.dart';
import 'package:pick_n_pay_user/theme/app_theme.dart';

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  int _currentBannerPage = 0;
  final PageController _bannerController = PageController();

  final List<String> _bannerImages = [
    'https://img.freepik.com/premium-photo/fresh-organic-vegetables-fruits-shelf-supermarket-farmers-market-healthy-food-concept-vitamins-minerals-tomatoes-capsicum-cucumbers-mushrooms-zucchini_197589-1218.jpg?w=1380',
    'https://img.freepik.com/free-photo/shopping-basket-with-groceries_23-2148949450.jpg',
    'https://img.freepik.com/free-photo/fruits-vegetables-basket_144627-17342.jpg',
    'https://img.freepik.com/free-photo/various-vegetables-black-table_1205-9728.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startBannerAutoScroll();
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  void _startBannerAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        if (_currentBannerPage < _bannerImages.length - 1) {
          _currentBannerPage++;
        } else {
          _currentBannerPage = 0;
        }

        _bannerController.animateToPage(
          _currentBannerPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );

        _startBannerAutoScroll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int cartItemCount = 3;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Pick N Pay',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold, color: secondaryColor),
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
                    Positioned(
                      right: 0,
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
          CategoryList(),
          const SizedBox(height: 20),
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
            itemCount: dummyShops.length,
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
              shop: dummyShops[index],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
