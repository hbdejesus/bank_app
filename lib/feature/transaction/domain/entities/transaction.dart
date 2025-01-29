import 'package:bank_app/utils/datetime_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

///
@freezed
class Transaction with _$Transaction {
  factory Transaction({
    required double amount,
    required String status,
    required String destinationId,
    required String user,
    @DateTimeConverter() required DateTime timestamp,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
}
