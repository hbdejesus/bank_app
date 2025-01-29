import 'package:bank_app/feature/transaction/presenter/cubits/transaction_cubits.dart';
import 'package:bank_app/feature/transaction/presenter/cubits/transaction_states.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'repo/mock_transaction_repo.dart';

void main() {
  group('Transaction Test', () {
    late TransactionCubit transactionCubit;
    late MockTransactionRepo mockTransactionRepo;

    setUp(() {
      mockTransactionRepo = MockTransactionRepo();
      transactionCubit = TransactionCubit(mockTransactionRepo);
    });

    blocTest<TransactionCubit, TransactionStates>(
      'emits [TransactionLoading, TransactionLoaded] when successfully fetch transactions',
      build: () => transactionCubit,
      act: (cubit) => cubit.getTransactions(),
      expect: () => [
        isA<TransactionLoading>(),
        isA<TransactionLoaded>(),
      ],
    );

    blocTest<TransactionCubit, TransactionStates>(
      'emits [TransactionLoading, TransactionError] when fetching transactions throws an exception',
      build: () => transactionCubit,
      act: (cubit) {
        mockTransactionRepo.throwException = true;
        return cubit.getTransactions();
      },
      expect: () => [
        isA<TransactionLoading>(),
        isA<TransactionError>(),
      ],
    );
  });
}
