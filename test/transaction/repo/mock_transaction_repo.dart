import 'package:appwrite/appwrite.dart';
import 'package:bank_app/feature/transaction/domain/entities/transaction.dart';
import 'package:bank_app/feature/transaction/domain/repos/transaction_repo.dart';

class MockTransactionRepo extends TransactionRepo {
  bool throwException = false;
  @override
  Future<List<Transaction>> getTransactions() {
    if (throwException) {
      throw Exception('Error');
    }

    return Future.delayed(
      const Duration(seconds: 1),
      () => [
        Transaction(
          user: ID.unique(),
          destinationId: ID.unique(),
          amount: 1000.0,
          timestamp: DateTime.now(),
          status: 'in_progress',
        ),
      ],
    );
  }
}
