import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

const databaseId = '6798d697001c65de84be';
const userCollectionId = '6798d83e000cd51fe2fd';
const walletCollectionId = '6798d6ad0031c01c682b';
const transactionCollectionId = '679987230034e963bea9';

class AppWriteHandler {
  late Account _account;
  late Databases _databases;

  Account get account => _account;

  Databases get databases => _databases;

  void initialize() {
    final client = Client().setProject('67981f35000b60001312');
    _account = Account(client);
    _databases = Databases(client);
  }

  Future<User> getCurrentUser() => _account.get();

  Future<DocumentList> getFromUserCollection([List<String> queries = const []]) async {
    return databases.listDocuments(
      databaseId: databaseId,
      collectionId: userCollectionId,
      queries: queries,
    );
  }

  Future<Document> getFromUserDocument(String documentId, [List<String> queries = const []]) async {
    return databases.getDocument(
      databaseId: databaseId,
      collectionId: userCollectionId,
      documentId: documentId,
      queries: queries,
    );
  }

  Future<DocumentList> getFromWalletCollection([List<String> queries = const []]) async {
    return databases.listDocuments(
      databaseId: databaseId,
      collectionId: walletCollectionId,
      queries: queries,
    );
  }

  Future<DocumentList> getFromTransactionCollection([List<String> queries = const []]) async {
    return databases.listDocuments(
      databaseId: databaseId,
      collectionId: transactionCollectionId,
      queries: queries,
    );
  }
}
