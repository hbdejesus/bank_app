import 'package:bank_app/feature/auth/presentation/cubits/auth_cubit.dart';
import 'package:bank_app/utils/colors.dart';
import 'package:bank_app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    if (formKey.currentState?.validate() ?? false) {
      final email = emailController.text;
      final password = passwordController.text;

      final authCubit = context.read<AuthCubit>();

      authCubit.login(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Lottie.asset('assets/login.json'),
                Text(
                  'Login',
                  style: textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const Gap(30),
                AppTextField(
                  isRequired: true,
                  label: 'Email',
                  controller: emailController,
                  prefixIcon: FaIcon(
                    FontAwesomeIcons.at,
                    color: Colors.grey,
                  ),
                  textInputType: TextInputType.emailAddress,
                ),
                AppTextField(
                  isRequired: true,
                  obscureText: true,
                  label: 'Password',
                  controller: passwordController,
                  prefixIcon: FaIcon(
                    FontAwesomeIcons.lock,
                    color: Colors.grey,
                  ),
                  textInputType: TextInputType.visiblePassword,
                ),
                const Gap(10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: textTheme.bodyMedium?.copyWith(
                      color: callToActionColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Gap(20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: login,
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(callToActionColor),
                          minimumSize: WidgetStatePropertyAll(Size.fromHeight(50)),
                          shape:
                              WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        ),
                        child: Text(
                          'Login',
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
