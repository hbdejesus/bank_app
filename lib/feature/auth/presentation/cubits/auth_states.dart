import 'package:appwrite/models.dart';

abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthLoading extends AuthStates {}

class Authenticated extends AuthStates {
  final User user;

  Authenticated(this.user);
}

class Unauthenticated extends AuthStates {}

class AuthError extends AuthStates {
  final String error;

  AuthError(this.error);
}
