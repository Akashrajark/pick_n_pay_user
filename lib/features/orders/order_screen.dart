import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
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
              Logger().w(_orders[0]);
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsScreen(order: order),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text('Order #${order['id']}'),
                    subtitle: Text('Status: ${order['status']}'),
                    trailing: Text('\$${order['price']}'),
                  ),
                );
                // return ListTile(
                //   title: Text('Order #${order['id']}'),
                //   subtitle: Text('Status: ${order['status']}'),
                //   trailing: Text('\$${order['price']}'),
                // );
              },
            );
          },
        ),
      ),
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order ID: ${order['id']}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Text('Created At: ${order['created_at']}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              Text('Status: ${order['status']}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              Text('Price: \$${order['price']}',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 16),
              Text('Items:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...order['order_items'].map<Widget>((item) {
                final product = item['shop_products'];
                final shop = product['shops'];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.network(
                                product['image_url'],
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['name'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('Quantity: ${item['quantity']}',
                                        style: TextStyle(fontSize: 16)),
                                    Text('Price: \$${item['price']}',
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text('Shop: ${shop['name']}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                              'Address: ${shop['address_line']}, ${shop['place']}, ${shop['district']}, ${shop['state']}, ${shop['pincode']}',
                              style: TextStyle(fontSize: 16)),
                          Text(
                              'Contact: ${shop['phone']}, ${shop['contact_email']}',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
