part of 'order_bloc.dart';

abstract class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderSuccess extends OrderState {
  final OrderResponseModel model;
  OrderSuccess({
    required this.model,
  });
}

final class OrderError extends OrderState {}
