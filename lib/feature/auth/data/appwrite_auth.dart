import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:bank_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:bank_app/main.dart';
import 'package:bank_app/utils/appwrite_handler.dart';

class AppWriteAuth implements AuthRepo {
  late Account account;

  AppWriteAuth() {
    account = getIt<AppWriteHandler>().account;
  }
  @override
  Future<Session> createEmailPasswordSession({required String email, required String password}) =>
      account.createEmailPasswordSession(
        email: email,
        password: password,
      );

  @override
  Future<User> getCurrentUser() => account.get();

  @override
  Future<void> logout() => account.deleteSessions();
}
