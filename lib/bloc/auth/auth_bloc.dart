import 'package:fic6_ecommerce_flutter/data/datasources/auth_remote_datasource.dart';
import 'package:fic6_ecommerce_flutter/data/models/auth_response_model.dart';
import 'package:fic6_ecommerce_flutter/data/models/request/login_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await AuthRemoteDatasource().login(event.model);
      result.fold(
        (l) => emit(AuthError()),
        (r) => emit(AuthSuccess(model: r)),
      );
    });
  }
}
