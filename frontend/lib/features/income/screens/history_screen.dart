import 'package:flutter/material.dart';
import '../../../core/api/income_history_api.dart';


class IncomeHistoryScreen extends StatefulWidget {
  const IncomeHistoryScreen({super.key});

  @override
  State<IncomeHistoryScreen> createState() =>
      _IncomeHistoryScreenState();
}

class _IncomeHistoryScreenState
    extends State<IncomeHistoryScreen> {

  late Future<List<dynamic>>
      historyFuture;

  @override
  void initState() {
    super.initState();

    historyFuture =
        IncomeHistoryApi.getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income History'),
      ),

      body: FutureBuilder<List<dynamic>>(
        future: historyFuture,

        builder: (context, snapshot) {
        
          if (!snapshot.hasData) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          final history =
              snapshot.data!;

          if (history.isEmpty) {
            return const Center(
              child: Text(
                "No income history found",
              ),
            );
          }

          return ListView.builder(
            itemCount: history.length,

            itemBuilder: (context, index) {
            
              final income =
                  history[index];

              return ListTile(
                leading:
                    const Icon(Icons.payments),

                title: Text(
                  income["source_name"],
                ),

                subtitle: Text(
                  income["date"],
                ),

                trailing: Text(
                  '₹${income["amount"]}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}