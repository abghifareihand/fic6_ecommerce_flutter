part of 'detail_product_bloc.dart';


abstract class DetailProductEvent {}

class GetDetailProduct extends DetailProductEvent {
  final int id;
  GetDetailProduct({
    required this.id,
  });
}