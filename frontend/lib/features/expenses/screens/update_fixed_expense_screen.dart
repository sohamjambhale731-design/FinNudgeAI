import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/expense_api.dart';

class UpdateFixedExpenseScreen extends StatefulWidget {
  final Map<String, dynamic> expense;

  const UpdateFixedExpenseScreen({
    super.key,
    required this.expense,
  });

  @override
  State<UpdateFixedExpenseScreen> createState() =>
      _UpdateFixedExpenseScreenState();
}

class _UpdateFixedExpenseScreenState
    extends State<UpdateFixedExpenseScreen> {
  late TextEditingController categoryController;
  late TextEditingController subCategoryController;
  late TextEditingController amountController;

  late bool recurring;

  @override
  void initState() {
    super.initState();

    categoryController = TextEditingController(
      text: widget.expense['category'],
    );

    subCategoryController = TextEditingController(
      text: widget.expense['subcategory'],
    );

    amountController = TextEditingController(
      text: widget.expense['amount'].toString(),
    );

    recurring = widget.expense['recurring'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Fixed Expense'),
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
                  labelText: 'Subcategory',
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
                  label: const Text('Update'),
                  onPressed: () async {
                    try {
                      await ExpenseApi.updateFixedExpense(
                        expenseId: widget.expense['expense_id'],
                        category: categoryController.text,
                        subcategory: subCategoryController.text,
                        amount: double.parse(amountController.text),
                        recurring: recurring,
                      );

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Updated Successfully'),
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
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () async {
                    try {
                      await ExpenseApi.deleteFixedExpense(
                        widget.expense['expense_id'],
                      );

                      if (!context.mounted) return;

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

