import 'package:fic6_ecommerce_flutter/data/datasources/product_remote_datasource.dart';
import 'package:fic6_ecommerce_flutter/data/models/list_product_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchProductName>((event, emit) async {
      emit(SearchLoading());
      await Future.delayed(Duration(seconds: 2));
      final result = await ProductRemoteDatasource().searchByName(event.name);
      result.fold(
        (error) => emit(SearchError()),
        (success) => emit(SearchSuccess(listProduct: success)),
      );
    });
  }
}
