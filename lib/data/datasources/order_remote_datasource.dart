import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic6_ecommerce_flutter/common/constants.dart';
import 'package:fic6_ecommerce_flutter/data/datasources/auth_local_datasource.dart';
import 'package:fic6_ecommerce_flutter/data/models/list_order_response_model.dart';
import 'package:fic6_ecommerce_flutter/data/models/order_response_model.dart';
import 'package:fic6_ecommerce_flutter/data/models/request/order_request_model.dart';
import 'package:http/http.dart' as http;

class OrderRemoteDatasource {
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel model) async {
    final token = await AuthLocalDatasource().getToken();
    print(model.toJson());
    final response = await http.post(
      Uri.parse(
        '$baseUrl/orders',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: model.toRawJson(),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return Right(OrderResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal Login');
    }
  }

  Future<Either<String, ListOrderResponseModel>> getListOrder() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final token = await AuthLocalDatasource().getToken();

    final response = await http.get(
      Uri.parse(
        '$baseUrl/orders?filters[userId][\$eq]=${authData.user.id}',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      print(response.body);
      return Right(ListOrderResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Gagal Login');
    }
  }
}
