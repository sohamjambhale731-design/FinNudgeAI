import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/bottom_nav_bar.dart';


import '../widgets/income_summary_card.dart';
import '../../../core/api/income_api.dart';
import '../models/income_data.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() =>
      _IncomeScreenState();
}

class _IncomeScreenState
    extends State<IncomeScreen> {

  late Future<List<dynamic>>
      incomeFuture;

  @override
  void initState() {
    super.initState();

    incomeFuture =
        IncomeApi.getIncome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income'),
      ),

      body: FutureBuilder<List<dynamic>>(
          future: incomeFuture,

          builder: (context, snapshot) {
          
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final incomeList =
                snapshot.data!;

            if (incomeList.isEmpty) {
              return const Center(
                child: Text(
                  "No Income Found",
                ),
              );
            }

            final income =
                IncomeData.fromJson(
              incomeList.first,
            );

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                
                  IncomeSummaryCard(
                    title: 'Monthly Income',
                    amount:
                        '₹${income.totalIncome.toStringAsFixed(0)}',
                    icon:
                        Icons.account_balance_wallet,
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                    
                      Expanded(
                        child: IncomeSummaryCard(
                          title:
                              'Primary Income',

                          amount:
                              '₹${income.primaryIncome.toStringAsFixed(0)}',

                          icon: Icons.work,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: IncomeSummaryCard(
                          title:
                              'Additional Income',

                          amount:
                              '₹${income.additionalIncome.toStringAsFixed(0)}',

                          icon:
                              Icons.trending_up,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  IncomeSummaryCard(
                    title: 'Month',
                    amount: income.month,
                    icon: Icons.calendar_month,
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.push(
                          '/add-income',
                        );
                      },
                      icon:
                          const Icon(Icons.add),
                      label:
                          const Text('Update Income'),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.push(
                          '/add-additional-income',
                        );
                      },
                      icon: const Icon(
                        Icons.trending_up,
                      ),
                      label: const Text(
                        'Add Additional Income',
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child:
                        OutlinedButton.icon(
                      onPressed: () {
                        context.push(
                          '/income-history',
                        );
                      },
                      icon:
                          const Icon(Icons.history),
                      label:
                          const Text(
                        'View History',
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      bottomNavigationBar: const FinNudgeBottomNavBar(
        currentIndex: 1,
      ),
    );
  }
}