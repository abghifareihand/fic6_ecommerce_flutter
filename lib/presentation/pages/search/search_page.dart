import 'package:fic6_ecommerce_flutter/bloc/search/search_bloc.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/detail/detail_page_byproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  final String search;
  const SearchPage({
    super.key,
    required this.search,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController.text = widget.search;
    context.read<SearchBloc>().add(SearchProductName(name: widget.search));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Colors.white),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                height: 42,
                child: Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: 1,
                  child: TextFormField(
                    controller: searchController,
                    onFieldSubmitted: (_) {
                      context.read<SearchBloc>().add(
                            SearchProductName(name: searchController.text),
                          );
                    },
                    decoration: InputDecoration(
                      prefixIcon: InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.only(
                            left: 6,
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 23,
                          ),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(top: 10),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black38,
                          width: 1,
                        ),
                      ),
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          print(state);
          if (state is SearchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SearchSuccess) {
            if (state.listProduct.data.isEmpty) {
              return const Center(
                child: Text('Empty data'),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.listProduct.data.length,
              itemBuilder: (context, index) {
                final product = state.listProduct.data[index];
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPageByproduct(
                        product: product,
                      ),
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product.attributes.image),
                  ),
                  title: Text(product.attributes.name),
                );
              },
            );
          }
          return const Center(
            child: Text('Error data'),
          );
        },
      ),
    );
  }
}
