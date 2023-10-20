part of 'cart_bloc.dart';

abstract class CartState {}

final class CartInitial extends CartState {}
final class CartLoading extends CartState {}
final class CartSuccess extends CartState {
  final List<Product> products;
  CartSuccess({
    required this.products,
  });
}
final class CartError extends CartState {}
