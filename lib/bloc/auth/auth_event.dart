part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final LoginRequestModel model;

  AuthLoginEvent({
    required this.model,
  });
}
