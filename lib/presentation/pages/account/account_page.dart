import 'package:fic6_ecommerce_flutter/bloc/list_order/list_order_bloc.dart';
import 'package:fic6_ecommerce_flutter/data/datasources/auth_local_datasource.dart';
import 'package:fic6_ecommerce_flutter/data/models/auth_response_model.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User? user;

  @override
  void initState() {
    getUser();
    context.read<ListOrderBloc>().add(GetListOrderEvent());
    super.initState();
  }

  Future<void> getUser() async {
    user = await AuthLocalDatasource().getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Page'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Username: ${user != null ? user!.username : '-'}',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Name: ${user != null ? user!.name : '-'}',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'Email: ${user != null ? user!.email : '-'}',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'List Ordermu',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          BlocBuilder<ListOrderBloc, ListOrderState>(
            builder: (context, state) {
              print(state);
              if (state is ListOrderError) {
                return const Center(
                  child: Text('Error'),
                );
              }
              if (state is ListOrderSuccess) {
                if (state.listOrder.data!.isEmpty) {
                  return const Center(
                    child: Text('Kamu belum pernah order'),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.listOrder.data!.length,
                  itemBuilder: (context, index) {
                    final order = state.listOrder.data![index];
                    return Column(
                      children: [
                        Column(
                          children: order.attributes!.items!.map((data) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: data.productImage == null
                                    ? const NetworkImage(
                                        'https://placehold.co/400')
                                    : NetworkImage(data.productImage!)
                                        as ImageProvider,
                              ),
                              title: Text(data.productName!),
                              subtitle: Text(data.price.toString()),
                              trailing: Text('#${data.id}'),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  },
                );
              }
              return const Center(
                child: Text('Kamu belum pernah order'),
              );
            },
          ),
          ElevatedButton(
            onPressed: () async {
              await AuthLocalDatasource().removeAuthData();
              if (!mounted) return;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
