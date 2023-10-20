part of 'cart_bloc.dart';


abstract class CartEvent {}

// Menambahkan produk ke keranjang
class AddToCartEvent extends CartEvent {
  final Product product;
  AddToCartEvent({
    required this.product,
  });
}

// Menghapus produk dari keranjang
class RemoveFromCartEvent extends CartEvent {
  final Product product;
  RemoveFromCartEvent({
    required this.product,
  });
}