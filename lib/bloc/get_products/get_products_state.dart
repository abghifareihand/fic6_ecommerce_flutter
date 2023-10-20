part of 'get_products_bloc.dart';

abstract class GetProductsState {}

final class GetProductsInitial extends GetProductsState {}

final class GetProductsLoading extends GetProductsState {}

final class GetProductsSuccess extends GetProductsState {
  final ListProductResponseModel listProduct;
  GetProductsSuccess({
    required this.listProduct,
  });
}

final class GetProductsError extends GetProductsState {
  final String error;
  GetProductsError({
    required this.error,
  });
}
