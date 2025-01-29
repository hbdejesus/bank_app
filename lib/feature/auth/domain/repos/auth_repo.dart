import 'package:appwrite/models.dart';

abstract class AuthRepo {
  Future<Session> createEmailPasswordSession({required String email, required String password});
  Future<void> logout();
  Future<User> getCurrentUser();
}
