part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class VerifyAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignOutAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
