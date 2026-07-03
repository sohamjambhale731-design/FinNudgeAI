import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/expense_api.dart';

class AddFixedExpenseScreen extends StatefulWidget {
  const AddFixedExpenseScreen({super.key});

  @override
  State<AddFixedExpenseScreen> createState() =>
      _AddFixedExpenseScreenState();
}

class _AddFixedExpenseScreenState extends State<AddFixedExpenseScreen> {
  final categoryController = TextEditingController();
  final subCategoryController = TextEditingController();
  final amountController = TextEditingController();

  bool recurring = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Fixed Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: subCategoryController,
                decoration: const InputDecoration(
                  labelText: 'Sub Category',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                value: recurring,
                title: const Text('Recurring Every Month'),
                onChanged: (value) {
                  setState(() {
                    recurring = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Save Fixed Expense'),
                  onPressed: () async {
                    try {
                      await ExpenseApi.addFixedExpense(
                        category: categoryController.text,
                        subcategory: subCategoryController.text,
                        amount: double.parse(amountController.text),
                        recurring: recurring,
                      );

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fixed Expense Added'),
                        ),
                      );

                      context.pop(true);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

