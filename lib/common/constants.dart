import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String baseUrl = 'http://10.0.2.2:1337/api';

String formatCurrency(num number, {String symbol = 'Rp'}) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: symbol,
    decimalDigits: 0,
  ).format(number);
}



const kPrimaryColor = Color(0xff6849ef);
const kPrimaryLight = Color(0xff8a72f1);