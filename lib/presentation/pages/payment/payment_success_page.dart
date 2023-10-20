import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/home/home_page.dart';
import 'package:fic6_ecommerce_flutter/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Payment Success',
        desc: 'Selamat pembayaran anda berhasil',
        btnOkOnPress: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
              (route) => false);
        },
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
