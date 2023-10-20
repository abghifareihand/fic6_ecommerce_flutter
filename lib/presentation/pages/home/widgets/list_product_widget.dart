import 'package:fic6_ecommerce_flutter/bloc/cart/cart_bloc.dart';
import 'package:fic6_ecommerce_flutter/common/constants.dart';
import 'package:fic6_ecommerce_flutter/data/models/list_product_response_model.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/detail/detail_page_byproduct.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/detail/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListProductWidget extends StatelessWidget {
  final Product product;
  const ListProductWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return ProductDetailPage(
        //         id: product.id,
        //       );
        //     },
        //   ),
        // );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailPageByproduct(
                product: product,
              );
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    product.attributes.image,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  width: 40, // Mengatur lebar Container
                  height: 40, // Mengatur tinggi Container
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white, // Warna latar belakang putih
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.attributes.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    formatCurrency(product.attributes.price),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                        width: 8.0,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            '${product.attributes.rating}',
                          ),
                        ],
                      ),
                    ],
                  ),

                  /// Add cart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          context
                              .read<CartBloc>()
                              .add(RemoveFromCartEvent(product: product));
                        },
                        child: const Icon(
                          Icons.remove_circle_outline,
                        ),
                      ),
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          if (state is CartSuccess) {
                            final countItem = state.products
                                .where((element) => element.id == product.id)
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
                          context
                              .read<CartBloc>()
                              .add(AddToCartEvent(product: product));
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
  }
}
