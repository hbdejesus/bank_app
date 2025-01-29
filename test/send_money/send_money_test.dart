import 'package:bank_app/feature/send_money/presenter/cubits/send_money_cubit.dart';
import 'package:bank_app/feature/send_money/presenter/cubits/send_money_states.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'repo/mock_send_money_repo.dart';

void main() {
  group('Send Money Test', () {
    late SendMoneyCubit sendMoneyCubit;
    late MockSendMoneyRepo mockSendMoneyRepo;

    setUp(() {
      mockSendMoneyRepo = MockSendMoneyRepo();
      sendMoneyCubit = SendMoneyCubit(mockSendMoneyRepo);
    });

    blocTest<SendMoneyCubit, SendMoneyStates>(
      'emits [SendMoneyLoading, SendMoneySuccess] when successfully send money',
      build: () => sendMoneyCubit,
      act: (cubit) => cubit.sendMoney(100),
      expect: () => [
        isA<SendMoneyLoading>(),
        isA<SendMoneySuccess>(),
      ],
    );

    blocTest<SendMoneyCubit, SendMoneyStates>(
      'emits [SendMoneyLoading, SendMoneyError] when sending money throws an exception',
      build: () => sendMoneyCubit,
      act: (cubit) {
        mockSendMoneyRepo.throwException = true;
        return cubit.sendMoney(100);
      },
      expect: () => [
        isA<SendMoneyLoading>(),
        isA<SendMoneyError>(),
      ],
    );
  });
}
