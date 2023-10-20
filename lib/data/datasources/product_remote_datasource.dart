import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fic6_ecommerce_flutter/common/constants.dart';
import 'package:fic6_ecommerce_flutter/data/models/detail_product_response_model.dart';
import 'package:fic6_ecommerce_flutter/data/models/list_product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDatasource {
  Future<Either<String, ListProductResponseModel>> getAllProduct() async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/products',
      ),
    );
    // print(response.body);

    if (response.statusCode == 200) {
      return Right(
        ListProductResponseModel.fromJson(
          jsonDecode(response.body),
        ),
      );
    } else {
      return const Left('Tidak dapat mengambil data');
    }
  }

  Future<Either<String, DetailProductResponseModel>> getProductById(int id) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/products/$id',
      ),
    );
    // print(response.body);

    if (response.statusCode == 200) {
      return Right(
        DetailProductResponseModel.fromJson(
          jsonDecode(response.body),
        ),
      );
    } else {
      return const Left('Tidak dapat mengambil data by id');
    }
  }
  
  Future<Either<String, ListProductResponseModel>> searchByName(String name) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/products?filters[name][\$contains]=$name',
      ),
    );
    print(response.body);

    if (response.statusCode == 200) {
      return Right(
        ListProductResponseModel.fromJson(
          jsonDecode(response.body),
        ),
      );
    } else {
      return const Left('Tidak dapat mengambil list by name');
    }
  }
}
