import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic6_ecommerce_flutter/common/constants.dart';
import 'package:fic6_ecommerce_flutter/data/models/auth_response_model.dart';
import 'package:fic6_ecommerce_flutter/data/models/request/login_request_model.dart';
import 'package:fic6_ecommerce_flutter/data/models/request/register_request_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel model) async {
    final response = await http.post(
      Uri.parse(
        '$baseUrl/auth/local',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: model.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Gagal Login');
    }
  }
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel model) async {
    final response = await http.post(
      Uri.parse(
        '$baseUrl/auth/local/register',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: model.toJson(),
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Gagal Register');
    }
  }
}
