import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_login/auth/user_auth_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  // auth provider
  UserAuthProvider _authProvider = UserAuthProvider();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    //logins auths
    if (event is LoginWithGoogleEvent) {
      try {
        yield LoginLoadingState();
        await _authProvider.signInwithGoogle();
        yield LoginSuccessState();
      } catch (e) {
        print(e.toString());
        yield LoginErrorState(
            error: "Error al hacer login con google: ${e.toString()}");
      }
    } else if (event is LoginAnonymousEvent) {
      try {
        yield LoginLoadingState();
        await _authProvider.anonymousSignIn();
        yield LoginSuccessState();
      } catch (e) {
        print(e.toString());
        yield LoginErrorState(
            error: "Error al hacer login con google: ${e.toString()}");
      }
    }
  }
}
