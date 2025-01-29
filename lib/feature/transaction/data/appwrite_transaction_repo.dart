import 'package:appwrite/appwrite.dart';
import 'package:bank_app/feature/transaction/domain/entities/transaction.dart';
import 'package:bank_app/feature/transaction/domain/repos/transaction_repo.dart';
import 'package:bank_app/main.dart';
import 'package:bank_app/utils/appwrite_handler.dart';

class AppWriteTransactionRepo implements TransactionRepo {
  late final AppWriteHandler appWriteHandler;

  AppWriteTransactionRepo() {
    appWriteHandler = getIt<AppWriteHandler>();
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    try {
      final user = await appWriteHandler.getCurrentUser();
      final documents = await appWriteHandler.getFromTransactionCollection([Query.equal('user', user.$id)]);

      if (documents.documents.isNotEmpty) {
        final transactionList = documents.documents.map((document) {
          return Transaction(
            amount: double.parse(document.data['amount'].toString()),
            status: document.data['status'],
            destinationId: document.data['destinationId'],
            user: document.data['user'][r'$id'],
            timestamp: DateTime.parse(document.data['timestamp']),
          );
        }).toList();

        return transactionList..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      }
      return List.empty();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
