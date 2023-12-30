import 'package:flutter/material.dart';
import 'package:ExpenseApp/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              expense.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Beyaz renk
              ),
            ),
            Row(
              children: [
                Text(
                  "${expense.price.toStringAsFixed(2)} ₺",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Beyaz renk
                  ),
                ),
                const Spacer(),
                Icon(
                  categoryIcons[expense.category],
                  color: Colors.white, // Beyaz renk
                ),
                const SizedBox(width: 8),
                Text(
                  expense.formattedDate,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Beyaz renk
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
