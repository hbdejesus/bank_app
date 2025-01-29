import 'package:bank_app/feature/send_money/domain/repos/send_money_repo.dart';

class MockSendMoneyRepo extends SendMoneyRepo {
  bool throwException = false;

  @override
  Future<void> sendMoney(double amount) {
    if (throwException) {
      throw Exception('Error');
    }
    return Future.delayed(
      const Duration(seconds: 1),
      () => null,
    );
  }
}
