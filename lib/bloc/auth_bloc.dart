import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_login/auth/user_auth_provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());
  // auth provider
  UserAuthProvider _authProvider = UserAuthProvider();
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    //request a APIs
    //acceso a BD locales
    //lo que se deba hacer pata inicializar la app
    //Future.delayed(Duration(seconds: 3));
    if (event is VerifyAuthEvent) {
      if (_authProvider.isAlreadyLogged())
        yield AlreadyAuthState();
      else
        yield UnAuthState();
    }
    if (event is SignOutAuthEvent) {
      if (FirebaseAuth.instance.currentUser.isAnonymous)
        await _authProvider.signOutFirebase();
      else {
        await _authProvider.signOutFirebase();
        await _authProvider.signOutGoogle();
      }
      yield UnAuthState();
    }
  }
}
