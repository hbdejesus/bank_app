import 'package:bank_app/feature/transaction/presenter/cubits/transaction_cubits.dart';
import 'package:bank_app/feature/transaction/presenter/cubits/transaction_states.dart';
import 'package:bank_app/feature/transaction/presenter/widgets/transaction_status.dart';
import 'package:bank_app/utils/enum/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late final transactionCubit = context.read<TransactionCubit>();

  @override
  void initState() {
    super.initState();

    transactionCubit.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
        centerTitle: true,
      ),
      body: BlocConsumer<TransactionCubit, TransactionStates>(
        builder: (context, state) => Column(
          children: [
            if (state is TransactionLoading)
              Center(child: const CircularProgressIndicator())
            else if (state is TransactionLoaded)
              ListView(
                shrinkWrap: true,
                children: [
                  ...state.transactions.map((e) => ListTile(
                        dense: true,
                        leading: TransactionStatus(status: Status.fromValue(e.status)),
                        trailing: Text(
                          '-${e.amount.toStringAsFixed(2)}',
                          style: textTheme.bodyLarge?.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        title: Text('To: ${e.destinationId}'),
                        subtitle: Text(e.timestamp.toString()),
                      ))
                ],
              )
          ],
        ),
        listener: (context, state) {
          if (state is TransactionError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
      ),
    );
  }
}
