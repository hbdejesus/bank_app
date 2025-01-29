import 'package:appwrite/models.dart';
import 'package:bank_app/feature/auth/domain/repos/auth_repo.dart';
import 'package:bank_app/feature/auth/presentation/cubits/auth_states.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;
  User? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  User? get currentUser => _currentUser;

  void checkAuth() async {
    try {
      final user = await authRepo.getCurrentUser();
      _currentUser = user;

      emit(Authenticated(user));
    } catch (e) {
      debugPrint(e.toString());
      emit(Unauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      await authRepo.createEmailPasswordSession(email: email, password: password);
      final user = await authRepo.getCurrentUser();

      _currentUser = user;

      emit(Authenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> logout() async {
    await authRepo.logout();
    emit(Unauthenticated());
  }
}
