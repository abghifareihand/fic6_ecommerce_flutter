part of 'detail_product_bloc.dart';


abstract class DetailProductState {}

final class DetailProductInitial extends DetailProductState {}
final class DetailProductLoading extends DetailProductState {}
final class DetailProductSuccess extends DetailProductState {
  final DetailProductResponseModel detailProduct;
  DetailProductSuccess({
    required this.detailProduct,
  });
}
final class DetailProductError extends DetailProductState {
  final String error;
  DetailProductError({
    required this.error,
  });
}
