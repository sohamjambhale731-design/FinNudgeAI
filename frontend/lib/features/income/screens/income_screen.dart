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
        title: const Text(
          "FinNudge AI",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        actions: [
          IconButton(
            icon: const CircleAvatar(
              radius: 16,
              child: Icon(Icons.person, size: 18),
            ),
            onPressed: () {
              context.push('/profile');
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    child: Icon(Icons.person, size: 30),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "FinNudge AI",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                context.push('/profile');
              },
            ),

            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("About"),
              onTap: () {
                context.push('/about');
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                context.go('/');
              },
            ),
          ],
        ),
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
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0xFFE6FFFA),
                        child: Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Color(0xFF14B8A6),
                          size: 50,
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "No Income Yet",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 14),

                      const Text(
                        "Track your salary, freelance earnings,\nscholarships or any other income.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: 260,
                        height: 55,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF14B8A6),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () async {
                            final result = await context.push(
                              '/add-income',
                            );

                            if (result == true) {
                              setState(() {
                                incomeFuture = IncomeApi.getIncome();
                              });
                            }
                          },
                          icon: const Icon(Icons.add),
                          label: const Text(
                            "Add Income",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Why add income?",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Color(0xFF14B8A6)),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Calculate your available balance",
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Color(0xFF14B8A6)),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Track monthly earnings",
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Color(0xFF14B8A6)),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Unlock AI financial insights",
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Color(0xFF14B8A6)),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Monitor your savings growth",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                      onPressed: () async {
                        final result =
                            await context.push(
                          '/add-income',
                          extra: income,
                        );

                        if (result == true) {
                          setState(() {
                            incomeFuture =
                                IncomeApi.getIncome();
                          });
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Update Income'),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final result = await context.push(
                          '/add-additional-income',
                        );

                        if (result == true) {
                          setState(() {
                            incomeFuture = IncomeApi.getIncome();
                          });
                        }
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