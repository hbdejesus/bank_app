import 'package:bank_app/feature/auth/domain/entities/user.dart';

abstract class UserStates {}

class UserInitial extends UserStates {}

class UserLoading extends UserStates {}

class UserLoaded extends UserStates {
  final User user;
  final double balance;

  UserLoaded(this.user, this.balance);
}

class UserError extends UserStates {
  final String message;

  UserError(this.message);
}
