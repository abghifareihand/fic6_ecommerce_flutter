part of 'order_bloc.dart';

abstract class OrderEvent {}

final class PayOrderEvent extends OrderEvent {
  final OrderRequestModel model;

  PayOrderEvent({
    required this.model,
  });
}
