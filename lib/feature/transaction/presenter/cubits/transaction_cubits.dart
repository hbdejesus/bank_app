import 'package:bank_app/feature/transaction/domain/repos/transaction_repo.dart';
import 'package:bank_app/feature/transaction/presenter/cubits/transaction_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionCubit extends Cubit<TransactionStates> {
  final TransactionRepo transactionRepo;

  TransactionCubit(this.transactionRepo) : super(TransactionInitial());

  Future<void> getTransactions() async {
    try {
      emit(TransactionLoading());

      final transactions = await transactionRepo.getTransactions();

      emit(TransactionLoaded(transactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}
