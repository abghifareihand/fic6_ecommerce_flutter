import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, String message, bool isSuccess) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: isSuccess ? Colors.green : Colors.redAccent,
    duration: const Duration(seconds: 2),
  ).show(context);
}
