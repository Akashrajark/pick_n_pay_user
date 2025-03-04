import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_date_picker.dart';
import 'package:pick_n_pay_user/features/orders/orders_bloc/orders_bloc.dart';
import 'package:pick_n_pay_user/features/showcase_page/product_card.dart';
import 'package:pick_n_pay_user/features/showcase_page/carts_bloc/carts_bloc.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_alert_dialog.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartsBloc _cartsBloc = CartsBloc();
  List<Map<String, dynamic>> _carts = [];
  double _totalPrice = 0.0;
  DateTime? _pickUpTime;

  @override
  void initState() {
    super.initState();
    _cartsBloc.add(GetAllCartsEvent(params: {}));
  }

  void _calculateTotalPrice() {
    _totalPrice = _carts.fold(0.0, (sum, item) {
      return sum + (item['shop_products']['price'] * item['quantity']);
    });
  }

  void _showBottomSheet(BuildContext context) {
    _calculateTotalPrice();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => OrdersBloc(),
          child: BlocConsumer<OrdersBloc, OrdersState>(
            listener: (context, state) {
              if (state is OrdersFailureState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    title: 'Failure',
                    description: state.message,
                    primaryButton: 'Try Again',
                    onPrimaryPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              } else if (state is OrdersSuccessState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Order placed successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Pick Up Time',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    CustomDatePicker(
                      isDateTime: true,
                      firstDate: DateTime.now(),
                      onPick: (pcik) {
                        _pickUpTime = pcik;
                      },
                    ),
                    const Text(
                      'Total Price',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$$_totalPrice',
                      style: const TextStyle(fontSize: 24, color: Colors.green),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_pickUpTime == null) {
                            showDialog(
                              context: context,
                              builder: (context) => CustomAlertDialog(
                                title: 'Error',
                                description: 'Please select pick up time',
                                primaryButton: 'Ok',
                                onPrimaryPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            );
                            return;
                          } else {
                            BlocProvider.of<OrdersBloc>(context).add(
                              AddOrderEvent(
                                orderDetails: {
                                  'p_pickup_time':
                                      _pickUpTime!.toIso8601String(),
                                  'p_status': 'Pending',
                                  'p_price': _totalPrice
                                },
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Plce Order',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider.value(
        value: _cartsBloc,
        child: BlocConsumer<CartsBloc, CartsState>(
          listener: (context, state) {
            if (state is CartsFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failure',
                  description: state.message,
                  primaryButton: 'Try Again',
                  onPrimaryPressed: () {
                    _cartsBloc.add(GetAllCartsEvent(params: {}));
                    Navigator.pop(context);
                  },
                ),
              );
            } else if (state is CartsGetSuccessState) {
              _carts = state.carts;
              Logger().w(_carts);
              _calculateTotalPrice();
              setState(() {});
            } else if (state is CartsSuccessState) {
              _cartsBloc.add(GetAllCartsEvent(params: {}));
            }
          },
          builder: (context, state) {
            if (state is CartsGetSuccessState && _carts.isEmpty) {
              return Center(child: Text('No items in cart'));
            }
            if (state is CartsLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.separated(
              itemBuilder: (context, index) => ProductCard(
                imageUrl: _carts[index]['shop_products']['image_url'],
                title: _carts[index]['shop_products']['name'],
                subtitle: _carts[index]['shop_products']['stock'].toString(),
                price: _carts[index]['shop_products']['price'].toString(),
                cardColor: Colors.white,
                buttonColor: Colors.green,
                onIncrement: () {
                  BlocProvider.of<CartsBloc>(context)
                      .add(AddCartEvent(cartDetails: {
                    'p_product_id': _carts[index]['product_id'],
                    'p_quantity': 1,
                  }));
                },
                onDecrement: () {
                  BlocProvider.of<CartsBloc>(context)
                      .add(AddCartEvent(cartDetails: {
                    'p_product_id': _carts[index]['product_id'],
                    'p_quantity': -1,
                  }));
                },
                counte: _carts[index]['quantity'],
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: _carts.length,
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _showBottomSheet(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Checkout',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
