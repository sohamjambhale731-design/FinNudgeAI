import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/income_api.dart';
import '../models/income_data.dart';

class AddIncomeScreen extends StatefulWidget {
  final IncomeData income;

  const AddIncomeScreen({
    super.key,
    required this.income,
  });

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();

    amountController =
        TextEditingController(text: widget.income.primaryIncome.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Income'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Income Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await IncomeApi.updateIncome(
                      incomeId: widget.income.incomeId,
                      primaryIncome: double.parse(amountController.text),
                    );

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Income Updated"),
                        ),
                      );
                      context.pop(true);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
                  }
                },
                child: const Text('Update Income'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

