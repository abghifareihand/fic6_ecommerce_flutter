part of 'list_order_bloc.dart';

abstract class ListOrderState {}

final class ListOrderInitial extends ListOrderState {}

final class ListOrderLoading extends ListOrderState {}

final class ListOrderSuccess extends ListOrderState {
  final ListOrderResponseModel listOrder;
  ListOrderSuccess({
    required this.listOrder,
  });
}

final class ListOrderError extends ListOrderState {}
