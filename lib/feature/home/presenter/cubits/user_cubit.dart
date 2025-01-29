import 'package:bank_app/feature/home/domain/repos/user_repo.dart';
import 'package:bank_app/feature/home/presenter/cubits/user_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserStates> {
  final UserRepo userRepo;

  UserCubit(this.userRepo) : super(UserInitial());

  Future<void> getUserInfo() async {
    try {
      emit(UserLoading());

      final user = await userRepo.getCurrentUserInfo();

      if (user != null) {
        final wallet = await userRepo.getWalletBalance(user.documentId);
        emit(UserLoaded(user, wallet));
      } else {
        emit(UserError('No Current User'));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
