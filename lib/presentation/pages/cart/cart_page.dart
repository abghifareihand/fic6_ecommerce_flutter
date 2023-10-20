import 'package:fic6_ecommerce_flutter/bloc/cart/cart_bloc.dart';
import 'package:fic6_ecommerce_flutter/common/constants.dart';
import 'package:fic6_ecommerce_flutter/data/datasources/auth_local_datasource.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/auth/login_page.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/checkout/checkout_page.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/detail/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartSuccess) {
                if (state.products.isEmpty) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Image.network(
                              /// get image dari index
                              'https://ecs7.tokopedia.net/assets-unify/il-header-cart-empty.jpg',
                              height: 150,
                              width: 150,
                            ),
                          ),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Wah, keranjang belanjaan kamu kosong nih',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  'Yuk, isi dengan barang-barang impianmu!',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Mulai Belanja"),
                        ),
                      ),
                    ],
                  );
                }
                final uniqueItem = state.products.toSet().length;
                final data = state.products.toSet();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: uniqueItem,
                  itemBuilder: (context, index) {
                    final product = data.elementAt(index);
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailPage(
                                id: product.id,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                /// get image dari index
                                product.attributes.image,
                                height: 120,
                                width: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.attributes.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    formatCurrency(product.attributes.price),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    product.attributes.inStock
                                        ? 'Tersedia'
                                        : 'Tidak Tersedia',
                                    style: TextStyle(
                                      color: product.attributes.inStock
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context.read<CartBloc>().add(
                                              RemoveFromCartEvent(
                                                  product: product));
                                        },
                                        child: const Icon(
                                          Icons.remove_circle_outline,
                                        ),
                                      ),
                                      BlocBuilder<CartBloc, CartState>(
                                        builder: (context, state) {
                                          if (state is CartSuccess) {
                                            final countItem = state.products
                                                .where((element) =>
                                                    element.id == product.id)
                                                .length;
                                            return Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Text('$countItem'),
                                            );
                                          }
                                          return const Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Text('0'),
                                          );
                                        },
                                      ),
                                      InkWell(
                                        onTap: () {
                                          context.read<CartBloc>().add(
                                              AddToCartEvent(product: product));
                                        },
                                        child: const Icon(
                                          Icons.add_circle_outline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartSuccess) {
            if (state.products.isEmpty) {
              return Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
              );
            }
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
                        'Total Harga',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      /// menghitung total harga pakai fold
                      Text(
                        formatCurrency(total),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      final isLogin = await AuthLocalDatasource().isLogin();
                      if (isLogin) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CheckoutPage();
                            },
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Checkout',
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
