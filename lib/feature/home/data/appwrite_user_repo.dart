import 'package:appwrite/appwrite.dart';
import 'package:bank_app/feature/auth/domain/entities/user.dart';
import 'package:bank_app/feature/home/domain/repos/user_repo.dart';
import 'package:bank_app/main.dart';
import 'package:bank_app/utils/appwrite_handler.dart';

class AppWriteUserRepo implements UserRepo {
  late final AppWriteHandler appWriteHandler;

  AppWriteUserRepo() {
    appWriteHandler = getIt<AppWriteHandler>();
  }

  @override
  Future<User?> getCurrentUserInfo() async {
    final user = await appWriteHandler.getCurrentUser();
    final document = await appWriteHandler.getFromUserDocument(user.$id);

    return User(
      documentId: document.$id,
      username: document.data['username'],
      email: document.data['email'],
      avatarUrl: document.data['avatarUrl'],
    );
  }

  @override
  Future<double> getWalletBalance(String id) async {
    final documents = await appWriteHandler.getFromWalletCollection([Query.equal('users', id)]);
    if (documents.documents.isNotEmpty) {
      final document = documents.documents.first;

      return double.parse(document.data['balance'].toString());
    }

    return 0.0;
  }
}
