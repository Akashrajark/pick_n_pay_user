import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_search.dart';
import 'package:pick_n_pay_user/features/showcase_page/shop_card.dart';
import 'package:pick_n_pay_user/features/showcase_page/shop_detailed_list_page.dart';

import '../../common_widgets.dart/custom_alert_dialog.dart';
import 'shops_bloc/shops_bloc.dart';

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  final ShopsBloc _shopItemsBloc = ShopsBloc();

  Map<String, dynamic> params = {
    'query': null,
  };

  List<Map> _shops = [], categories = [];

  @override
  void initState() {
    getShops();
    super.initState();
  }

  void getShops() {
    _shopItemsBloc.add(GetAllShopsEvent(params: params));
    if (params['query'] == null) {
      _shopItemsBloc.add(GetCategoriesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _shopItemsBloc,
        child: BlocConsumer<ShopsBloc, ShopsState>(
          listener: (context, state) {
            if (state is ShopsFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failure',
                  description: state.message,
                  primaryButton: 'Try Again',
                  onPrimaryPressed: () {
                    getShops();
                    Navigator.pop(context);
                  },
                ),
              );
            } else if (state is ShopsGetSuccessState) {
              _shops = state.shops;

              Logger().w(_shops);

              setState(() {});
            } else if (state is ShopsSuccessState) {
              getShops();
            } else if (state is CategoriesGetSuccessState) {
              Logger().w(state.categories);
              categories = state.categories;
              setState(() {});
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomSearch(
                          onSearch: (query) {
                            params['query'] = query;
                            getShops();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Shops Section
                  Text(
                    'Shops',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  if (state is ShopsLoadingState)
                    const Center(child: CircularProgressIndicator()),
                  if (state is ShopsGetSuccessState && _shops.isEmpty)
                    const Center(child: Text('No shops available')),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _shops.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.black26,
                    ),
                    itemBuilder: (context, index) => ShopCard(
                      shopData: _shops[index],
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopDetailedListPage(
                              shop: _shops[index],
                              categories: categories,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
