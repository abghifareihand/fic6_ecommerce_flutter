import 'package:fic6_ecommerce_flutter/bloc/cart/cart_bloc.dart';
import 'package:fic6_ecommerce_flutter/bloc/order/order_bloc.dart';
import 'package:fic6_ecommerce_flutter/common/constants.dart';
import 'package:fic6_ecommerce_flutter/common/snackbar.dart';
import 'package:fic6_ecommerce_flutter/common/snap_widget.dart';
import 'package:fic6_ecommerce_flutter/data/datasources/auth_local_datasource.dart';
import 'package:fic6_ecommerce_flutter/data/models/request/order_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Page'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Alamat Pengiriman',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextField(
            controller: _addressController,
            decoration: const InputDecoration(
              hintText: 'Enter your address',
              border: OutlineInputBorder(),
            ),
            maxLines: 4,
          ),
          const SizedBox(
            height: 20.0,
          ),
          DropdownButton<String>(
            items: const [
              DropdownMenuItem(
                value: 'JNE',
                child: Text('JNE'),
              ),
              DropdownMenuItem(
                value: 'JNT',
                child: Text('JNT'),
              ),
              DropdownMenuItem(
                value: 'TIKI',
                child: Text('TIKI'),
              ),
            ],
            hint: const Text('Select Courier'),
            onChanged: (String? value) {
              setState(() {});
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'Product Item',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartSuccess) {
                final item = state.products.toSet().length;
                final data = state.products.toSet();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: item,
                  itemBuilder: (context, index) {
                    final productItem = data.elementAt(index);
                    final countItem = state.products
                        .where((element) => element.id == productItem.id)
                        .length;
                    return ListTile(
                      leading: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              productItem.attributes.image,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        productItem.attributes.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatCurrency(
                              productItem.attributes.price,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            '(${countItem}pcs)',
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ],
      ),
      bottomNavigationBar: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SnapWidget(url: state.model.redirectUrl);
                },
              ),
            );
          }
          if (state is OrderError) {
            showCustomSnackbar(context, 'Error', false);
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartSuccess) {
              
              final quantity = state.products.length;
              final total = state.products
                  .fold(0, (sum, product) => sum + product.attributes.price);
              return Container(
                height: 80,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Total Belanja',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        /// menghitung total harga pakai fold
                        Text(
                          formatCurrency(total),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          final userId = await AuthLocalDatasource().getUserId();
                          final data = Data(
                            items: state.products
                                .map(
                                  (e) => Item(
                                    id: e.id,
                                    productName: e.attributes.name,
                                    productImage: e.attributes.image,
                                    price: e.attributes.price,
                                    quantity: 1,
                                    
                                  ),
                                )
                                .toList(),
                            totalPrice: total,
                            deliveryAddress: _addressController.text,
                            courierName: 'JNE',
                            shippingCost: 22000,
                            statusOrder: 'waitingPayment',
                            userId: userId,
                          );
                          final requestModel = OrderRequestModel(data: data);
                          context
                              .read<OrderBloc>()
                              .add(PayOrderEvent(model: requestModel));
                        },
                        child: const Text(
                          'Pilih Pembayaran',
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
