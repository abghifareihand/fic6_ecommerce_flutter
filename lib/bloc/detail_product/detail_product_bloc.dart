import 'package:fic6_ecommerce_flutter/data/datasources/product_remote_datasource.dart';
import 'package:fic6_ecommerce_flutter/data/models/detail_product_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  DetailProductBloc() : super(DetailProductInitial()) {
    on<GetDetailProduct>((event, emit) async {
      emit(DetailProductLoading());
      final result = await ProductRemoteDatasource().getProductById(event.id);
      result.fold(
        (error) => emit(DetailProductError(error: error.toString())),
        (success) => emit(DetailProductSuccess(detailProduct: success)),
      );
    });
  }
}
