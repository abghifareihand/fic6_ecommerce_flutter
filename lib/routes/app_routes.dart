import 'package:fic6_ecommerce_flutter/presentation/onboarding_screen.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/auth/login_page.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/checkout/checkout_page.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/home/home_screen.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      // '/': (context) => const MainPage(),
      '/': (context) => const OnboardingScreen(),
      '/login': (context) => const LoginPage(),
      '/checkout': (context) => const CheckoutPage(),

      //'/register': (context) => const RegisterPage(),

      '/home': (context) => const HomeScreen(),
    };
  }
}
