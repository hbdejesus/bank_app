import 'package:bank_app/feature/transaction/domain/entities/transaction.dart';

abstract class TransactionStates {}

class TransactionInitial extends TransactionStates {}

class TransactionLoading extends TransactionStates {}

class TransactionLoaded extends TransactionStates {
  final List<Transaction> transactions;

  TransactionLoaded(this.transactions);
}

class TransactionError extends TransactionStates {
  final String message;

  TransactionError(this.message);
}
