import 'package:flutter/material.dart';

class AddAdditionalIncomeScreen extends StatelessWidget {
  const AddAdditionalIncomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Additional Income',
        ),
      ),

      body: const Center(
        child: Text(
          'Additional Income Form',
        ),
      ),
    );
  }
}