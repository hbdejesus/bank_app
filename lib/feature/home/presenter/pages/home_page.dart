import 'package:bank_app/feature/auth/presentation/cubits/auth_cubit.dart';
import 'package:bank_app/feature/home/presenter/cubits/user_cubit.dart';
import 'package:bank_app/feature/home/presenter/cubits/user_states.dart';
import 'package:bank_app/feature/home/presenter/widgets/wallet_card.dart';
import 'package:bank_app/feature/send_money/presenter/pages/send_money_page.dart';
import 'package:bank_app/feature/transaction/presenter/pages/transaction_page.dart';
import 'package:bank_app/utils/colors.dart';
import 'package:bank_app/widgets/text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final userCubit = context.read<UserCubit>();

  @override
  void initState() {
    super.initState();

    userCubit.getUserInfo();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          final textTheme = Theme.of(context).textTheme;

          return Scaffold(
            backgroundColor: grayLightest,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    state is UserLoaded
                        ? ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: ClipOval(
                              child: Image.network(
                                state.user.avatarUrl,
                                height: 40,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                context.read<AuthCubit>().logout();
                              },
                              icon: FaIcon(FontAwesomeIcons.rightFromBracket),
                            ),
                            title: Text(state.user.username),
                            subtitle: Text(state.user.email),
                          )
                        : const CircularProgressIndicator(),
                    const Gap(10),
                    Text(
                      'Account',
                      style: textTheme.headlineSmall,
                    ),
                    const Gap(20),
                    Align(
                      child: WalletCard(
                        isLoading: state is UserLoading,
                        balance: state is UserLoaded ? state.balance : 2,
                      ),
                    ),
                    const Gap(20),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextIconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SendMoneyPage(initialBalance: state is UserLoaded ? state.balance : 0.0)));
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.paperPlane,
                                color: callToActionColor,
                              ),
                              text: 'Send Money',
                            ),
                            const Gap(20),
                            TextIconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionPage()));
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.tableList,
                                color: callToActionColor,
                              ),
                              text: 'View Transactions',
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
}
