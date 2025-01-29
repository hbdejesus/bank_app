import 'package:bank_app/feature/auth/domain/entities/user.dart';
import 'package:bank_app/feature/home/domain/repos/user_repo.dart';

class MockUserRepo extends UserRepo {
  bool throwException = false;

  @override
  Future<User?> getCurrentUserInfo() {
    if (throwException) {
      throw Exception('Error');
    }
    return Future.delayed(
      const Duration(seconds: 1),
      () => User(
        documentId: 'documentId',
        username: 'username',
        email: 'email',
        avatarUrl: 'avatarUrl',
      ),
    );
  }

  @override
  Future<double> getWalletBalance(String id) {
    if (throwException) {
      throw Exception('Error');
    }
    return Future.delayed(
      const Duration(seconds: 1),
      () => 1000.0,
    );
  }
}
