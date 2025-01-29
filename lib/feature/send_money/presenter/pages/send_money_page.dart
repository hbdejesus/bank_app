import 'package:bank_app/feature/send_money/presenter/cubits/send_money_cubit.dart';
import 'package:bank_app/feature/send_money/presenter/cubits/send_money_states.dart';
import 'package:bank_app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({
    required this.initialBalance,
    super.key,
  });

  final double initialBalance;
  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => BlocConsumer<SendMoneyCubit, SendMoneyStates>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text('Send Money'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: AppTextField(
                    controller: amountController,
                    label: 'Amount',
                    textInputType: TextInputType.numberWithOptions(decimal: true),
                    helperText: 'Must not exceed PHP ${widget.initialBalance.toStringAsFixed(2)}',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }

                      final doubleValue = double.tryParse(value) ?? 0.0;
                      if (doubleValue > widget.initialBalance) {
                        return 'Insufficient Balance';
                      }
                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                const Gap(20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      context.read<SendMoneyCubit>().sendMoney(double.parse(amountController.text));
                    }
                  },
                  child: state is SendMoneyLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          'Send Money',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                ),
                const Gap(20),
                Text('Note: As a demo, transactions will be pointed to user id {679988550038273c8d49}'),
              ],
            ),
          ),
        ),
        listener: (context, state) {
          if (state is SendMoneySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sending Successful!')));
            Navigator.pop(context);
          } else if (state is SendMoneyError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
      );
}
