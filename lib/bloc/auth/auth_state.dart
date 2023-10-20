part of 'auth_bloc.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final AuthResponseModel model;
  AuthSuccess({
    required this.model,
  });
}

final class AuthError extends AuthState {}
