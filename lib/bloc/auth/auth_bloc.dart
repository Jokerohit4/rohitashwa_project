import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rohitashwa_project/bloc/auth/auth_event.dart';
import 'package:rohitashwa_project/bloc/auth/auth_helper.dart';
import 'package:rohitashwa_project/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc._() : super(AuthInitial()) {
    on<AuthObserve>(_observe);
    on<AuthNotify>(_notifyStatus);
  }

  static final AuthBloc _instance = AuthBloc._();

  factory AuthBloc() => _instance;

  void _observe(event, emit) {
    AuthHelper.observeAuth();
  }

  void _notifyStatus(AuthNotify event, emit) {
    event.isAuthenticated ? emit(AuthSuccess()) : emit(AuthFailure());
  }


}