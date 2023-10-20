import 'package:fic6_ecommerce_flutter/data/models/list_product_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartSuccess(products: [])) {
    // on<AddToCartEvent>((event, emit) {
    //   emit(CartLoading());
    //   final List<Product> products = [];
    //   products.add(event.product);
    //   emit(CartSuccess(products: products));
    // });

    // on<RemoveFromCartEvent>((event, emit) {
    //   emit(CartLoading());
    //   final List<Product> products = [];
    //   products.remove(event.product);
    //   emit(CartSuccess(products: products));
    // });

    on<AddToCartEvent>((event, emit) {
      final addProduct = state as CartSuccess;
      addProduct.products.add(event.product);
      emit(CartLoading());
      emit(CartSuccess(products: addProduct.products));
    });

    on<RemoveFromCartEvent>((event, emit) {
      final removeProduct = state as CartSuccess;
      removeProduct.products.remove(event.product);
      emit(CartLoading());

      emit(CartSuccess(products: removeProduct.products));
    });
  }
}
