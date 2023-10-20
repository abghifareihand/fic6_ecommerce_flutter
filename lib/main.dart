import 'package:fic6_ecommerce_flutter/bloc/auth/auth_bloc.dart';
import 'package:fic6_ecommerce_flutter/bloc/cart/cart_bloc.dart';
import 'package:fic6_ecommerce_flutter/bloc/detail_product/detail_product_bloc.dart';
import 'package:fic6_ecommerce_flutter/bloc/get_products/get_products_bloc.dart';
import 'package:fic6_ecommerce_flutter/bloc/list_order/list_order_bloc.dart';
import 'package:fic6_ecommerce_flutter/bloc/order/order_bloc.dart';
import 'package:fic6_ecommerce_flutter/bloc/search/search_bloc.dart';
import 'package:fic6_ecommerce_flutter/presentation/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProductsBloc(),
        ),
        BlocProvider(
          create: (context) => DetailProductBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => ListOrderBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: OnboardingScreen(),
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}
