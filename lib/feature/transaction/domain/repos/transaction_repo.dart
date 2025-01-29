import 'package:bank_app/feature/transaction/domain/entities/transaction.dart';

abstract class TransactionRepo {
  Future<List<Transaction>> getTransactions();
}
