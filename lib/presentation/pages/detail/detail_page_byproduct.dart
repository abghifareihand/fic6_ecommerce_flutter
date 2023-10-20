import 'package:fic6_ecommerce_flutter/bloc/cart/cart_bloc.dart';
import 'package:fic6_ecommerce_flutter/common/constants.dart';
import 'package:fic6_ecommerce_flutter/data/models/list_product_response_model.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPageByproduct extends StatelessWidget {
  final Product product;
  const DetailPageByproduct({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.attributes.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            child: Image.network(
              product.attributes.image,
              height: 400,
              width: 400,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            formatCurrency(product.attributes.price),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.attributes.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Deskripsi Produk',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            product.attributes.description,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            }
          },
          builder: (context, state) {
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  context
                      .read<CartBloc>()
                      .add(AddToCartEvent(product: product));
                },
                child: Text(
                  state is CartLoading ? 'Loading...' : 'Beli',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
