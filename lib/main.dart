import 'package:bank_app/feature/auth/data/appwrite_auth.dart';
import 'package:bank_app/feature/auth/presentation/cubits/auth_cubit.dart';
import 'package:bank_app/feature/auth/presentation/cubits/auth_states.dart';
import 'package:bank_app/feature/auth/presentation/pages/login_page.dart';
import 'package:bank_app/feature/home/data/appwrite_user_repo.dart';
import 'package:bank_app/feature/home/presenter/cubits/user_cubit.dart';
import 'package:bank_app/feature/home/presenter/pages/home_page.dart';
import 'package:bank_app/feature/send_money/data/appwrite_send_money_repo.dart';
import 'package:bank_app/feature/send_money/presenter/cubits/send_money_cubit.dart';
import 'package:bank_app/feature/transaction/data/appwrite_transaction_repo.dart';
import 'package:bank_app/feature/transaction/presenter/cubits/transaction_cubits.dart';
import 'package:bank_app/utils/appwrite_handler.dart';
import 'package:bank_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerLazySingleton<AppWriteHandler>(AppWriteHandler.new);
  getIt<AppWriteHandler>().initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(authRepo: AppWriteAuth())..checkAuth()),
        BlocProvider(create: (context) => UserCubit(AppWriteUserRepo())),
        BlocProvider(create: (context) => TransactionCubit(AppWriteTransactionRepo())),
        BlocProvider(create: (context) => SendMoneyCubit(AppWriteSendMoneyRepo())),
      ],
      child: MaterialApp(
        title: 'Bank App',
        theme: appTheme,
        home: BlocConsumer<AuthCubit, AuthStates>(
          builder: (context, states) => switch (states) {
            Unauthenticated _ => LoginPage(),
            Authenticated _ => const HomePage(),
            _ => Scaffold(body: Center(child: const CircularProgressIndicator())),
          },
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
        ),
      ),
    );
  }
}
