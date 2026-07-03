import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/income_api.dart';

class AddAdditionalIncomeScreen extends StatefulWidget {
  const AddAdditionalIncomeScreen({
    super.key,
  });

  @override
  State<AddAdditionalIncomeScreen> createState() =>
      _AddAdditionalIncomeScreenState();
}

class _AddAdditionalIncomeScreenState
    extends State<AddAdditionalIncomeScreen> {
  final amountController = TextEditingController();
  final sourceController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Additional Income'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: sourceController,
              decoration: const InputDecoration(
                labelText: 'Source Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await IncomeApi.addAdditionalIncome(
                      sourceName: sourceController.text,
                      amount: double.parse(amountController.text),
                    );


                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Additional Income Added"),
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
                child: const Text("Save Additional Income"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

