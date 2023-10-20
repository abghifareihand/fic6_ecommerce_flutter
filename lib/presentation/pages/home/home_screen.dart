import 'package:fic6_ecommerce_flutter/bloc/get_products/get_products_bloc.dart';
import 'package:fic6_ecommerce_flutter/common/constants.dart';
import 'package:fic6_ecommerce_flutter/common/theme.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  var category = [
    'Technology',
    'Fashion',
    'Sports',
    'Home',
  ];

  @override
  void initState() {
    context.read<GetProductsBloc>().add(GetAllProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            if (!mounted) return;
            context.read<GetProductsBloc>().add(GetAllProduct());
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            children: [
              /// Search Products
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: whiteColor,
                          hintText: 'Search products',
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.all(16),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: whiteColor),
                            borderRadius: BorderRadius.circular(64),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: whiteColor),
                            borderRadius: BorderRadius.circular(64),
                          ),
                        ),
                        onFieldSubmitted: (value) {},
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                      ),
                      child: const Icon(
                        Icons.notifications_none_outlined,
                      ),
                    ),
                  ],
                ),
              ),

              /// Banner Products
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
                height: 149,
                decoration: BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.circular(26),
                ),
              ),

              /// Categories
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      for (var i = 0; i < 4; i++)
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(62),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            category[i],
                            style: blackTextStyle.copyWith(
                              fontWeight: medium,
                              fontSize: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              /// New Products
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Text
                    Text(
                      'New Products',
                      style: blackTextStyle.copyWith(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),

                    /// Card Product
                    BlocBuilder<GetProductsBloc, GetProductsState>(
                      builder: (context, state) {
                        if (state is GetProductsError) {
                          return Center(
                            child: Text(state.error),
                          );
                        }

                        if (state is GetProductsSuccess) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 14,
                              crossAxisSpacing: 14,
                              childAspectRatio: 0.65,
                            ),
                            itemCount: state.listProduct.data.length,
                            itemBuilder: (context, index) {
                              final product = state.listProduct.data[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailScreen(product: product),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: whiteColor,
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
                                          /// Image
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16),
                                            ),
                                            child: Image.network(
                                              product.attributes.image,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),

                                          /// Icon Favorite
                                          Container(
                                            margin: const EdgeInsets.all(16),
                                            width: 36,
                                            height: 36,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: whiteColor,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.favorite_border,
                                              color: primaryColor,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),

                                      /// Name Product
                                      Container(
                                        padding: const EdgeInsets.all(
                                          16,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              product.attributes.name,
                                              style: blackTextStyle.copyWith(
                                                fontWeight: medium,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              formatCurrency(
                                                  product.attributes.price),
                                              style: blackTextStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: semiBold,
                                              ),
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
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
