import 'package:fic6_ecommerce_flutter/data/datasources/product_remote_datasource.dart';
import 'package:fic6_ecommerce_flutter/data/models/list_product_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_products_event.dart';
part 'get_products_state.dart';

class GetProductsBloc extends Bloc<GetProductsEvent, GetProductsState> {
  GetProductsBloc() : super(GetProductsInitial()) {
    on<GetAllProduct>((event, emit) async {
      emit(GetProductsLoading());
      final result = await ProductRemoteDatasource().getAllProduct();
      result.fold(
        (error) => emit(GetProductsError(error: error.toString())),
        (success) => emit(GetProductsSuccess(listProduct: success)),
      );
    });
  }
}
