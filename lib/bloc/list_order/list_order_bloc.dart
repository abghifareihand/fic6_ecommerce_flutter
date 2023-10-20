

import 'package:fic6_ecommerce_flutter/data/datasources/order_remote_datasource.dart';
import 'package:fic6_ecommerce_flutter/data/models/list_order_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_order_event.dart';
part 'list_order_state.dart';

class ListOrderBloc extends Bloc<ListOrderEvent, ListOrderState> {
  ListOrderBloc() : super(ListOrderInitial()) {
    on<GetListOrderEvent>((event, emit) async {
      emit(ListOrderLoading());
      final result = await OrderRemoteDatasource().getListOrder();
      result.fold(
        (error) => emit(ListOrderError()),
        (success) => emit(ListOrderSuccess(listOrder: success)),
      );
    });
  }
}
