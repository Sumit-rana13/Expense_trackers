import 'package:flutter/material.dart';

import '../../modle/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("\$${expense.amount.toStringAsFixed(2)}"),
                Spacer(),
                Row(
                  children: [
                    // Icon(categoryIcons[expense.category]),
                    // Icon(Icons.alarm),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(expense.formatterDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
