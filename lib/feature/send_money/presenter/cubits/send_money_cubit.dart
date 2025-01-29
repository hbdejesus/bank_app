import 'package:bank_app/feature/send_money/domain/repos/send_money_repo.dart';
import 'package:bank_app/feature/send_money/presenter/cubits/send_money_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMoneyCubit extends Cubit<SendMoneyStates> {
  SendMoneyCubit(this.repo) : super(SendMoneyInitial());

  final SendMoneyRepo repo;
  Future<void> sendMoney(double amount) async {
    try {
      emit(SendMoneyLoading());
      await repo.sendMoney(amount);
      emit(SendMoneySuccess());
    } catch (e) {
      emit(SendMoneyError(e.toString()));
    }
  }
}
