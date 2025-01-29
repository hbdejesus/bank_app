import 'package:bank_app/feature/auth/domain/entities/user.dart';

abstract class UserRepo {
  Future<User?> getCurrentUserInfo();
  Future<double> getWalletBalance(String id);
}
