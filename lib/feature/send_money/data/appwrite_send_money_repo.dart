import 'package:appwrite/appwrite.dart';
import 'package:bank_app/feature/send_money/domain/repos/send_money_repo.dart';
import 'package:bank_app/feature/transaction/domain/entities/transaction.dart';
import 'package:bank_app/main.dart';
import 'package:bank_app/utils/appwrite_handler.dart';
import 'package:bank_app/utils/enum/status.dart';

class AppWriteSendMoneyRepo extends SendMoneyRepo {
  late final AppWriteHandler appWriteHandler;

  AppWriteSendMoneyRepo() {
    appWriteHandler = getIt<AppWriteHandler>();
  }

  @override
  Future<void> sendMoney(double amount) async {
    try {
      final user = await appWriteHandler.getCurrentUser();
      await appWriteHandler.databases.createDocument(
        databaseId: databaseId,
        collectionId: transactionCollectionId,
        documentId: ID.unique(),
        data: Transaction(
          amount: amount,
          status: Status.inProgress.value,
          destinationId: '679988550038273c8d49',
          user: user.$id,
          timestamp: DateTime.now(),
        ).toJson(),
      );
    } catch (e) {
      throw (Exception(e));
    }
  }
}
