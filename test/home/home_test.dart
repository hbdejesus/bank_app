import 'package:bank_app/feature/home/presenter/cubits/user_cubit.dart';
import 'package:bank_app/feature/home/presenter/cubits/user_states.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'repo/mock_home_repo.dart';

void main() {
  group('User Cubit Test', () {
    late UserCubit userCubit;
    late MockUserRepo mockUserRepo;

    setUp(() {
      mockUserRepo = MockUserRepo();
      userCubit = UserCubit(mockUserRepo);
    });

    blocTest<UserCubit, UserStates>(
      'emits [UserLoading, UserLoaded] when successfuly fetch user info',
      build: () => userCubit,
      act: (cubit) => cubit.getUserInfo(),
      expect: () => [
        isA<UserLoading>(),
        isA<UserLoaded>(),
      ],
    );

    blocTest<UserCubit, UserStates>(
      'emits [UserLoading, UserError] when fetching user info throws an exception',
      build: () => userCubit,
      act: (cubit) {
        mockUserRepo.throwException = true;
        return cubit.getUserInfo();
      },
      expect: () => [
        isA<UserLoading>(),
        isA<UserError>(),
      ],
    );

    tearDown(() {
      userCubit.close();
    });
  });
}
