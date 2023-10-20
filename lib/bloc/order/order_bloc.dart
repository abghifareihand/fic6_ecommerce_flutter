import 'package:fic6_ecommerce_flutter/data/datasources/order_remote_datasource.dart';
import 'package:fic6_ecommerce_flutter/data/models/order_response_model.dart';
import 'package:fic6_ecommerce_flutter/data/models/request/order_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<PayOrderEvent>((event, emit) async {
     emit(OrderLoading());
     final result = await OrderRemoteDatasource().order(event.model);
     result.fold(
       (l) => emit(OrderError()),
       (r) => emit(OrderSuccess(model: r)),
     );
    });
  }
}
