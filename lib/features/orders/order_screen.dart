import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_alert_dialog.dart';
import 'orders_bloc/orders_bloc.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final OrdersBloc _ordersBloc = OrdersBloc();
  List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    super.initState();
    _ordersBloc.add(GetAllOrdersEvent(params: {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: BlocProvider.value(
        value: _ordersBloc,
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
                    _ordersBloc.add(GetAllOrdersEvent(params: {}));
                    Navigator.pop(context);
                  },
                ),
              );
            } else if (state is OrdersGetSuccessState) {
              _orders = state.orders;
              setState(() {});
            } else if (state is OrdersSuccessState) {
              _ordersBloc.add(GetAllOrdersEvent(params: {}));
            }
          },
          builder: (context, state) {
            if (state is OrdersLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is OrdersGetSuccessState && _orders.isEmpty) {
              return Center(child: Text('No orders available'));
            }
            return ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return ListTile(
                  title: Text('Order #${order['id']}'),
                  subtitle: Text('Status: ${order['status']}'),
                  trailing: Text('\$${order['price']}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
