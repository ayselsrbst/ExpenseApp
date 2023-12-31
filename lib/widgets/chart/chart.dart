import 'package:flutter/material.dart';
import 'package:expense_app/models/category_expense.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/chart/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});
  final List<Expense> expenses;

  List<CategoryExpense> get categoryExpenses {
    return [
      CategoryExpense.forCategory(expenses, Category.education),
      CategoryExpense.forCategory(expenses, Category.food),
      CategoryExpense.forCategory(expenses, Category.travel),
      CategoryExpense.forCategory(expenses, Category.work),
    ];
  }

  double get maxTotal {
    double maxTotalExpense = 0;

    for (var element in categoryExpenses) {
      if (element.totalExpensePrice > maxTotalExpense) {
        maxTotalExpense = element.totalExpensePrice;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 250,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.secondary.withOpacity(0.0)
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Column(children: [
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: categoryExpenses
                .map((categoryExpense) => ChartBar(
                    height: categoryExpense.totalExpensePrice == 0
                        ? 0
                        : categoryExpense.totalExpensePrice / maxTotal))
                .toList(),
          )),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: categoryExpenses
                .map((categoryExpense) => Expanded(
                    child: Icon(categoryIcons[categoryExpense.category])))
                .toList(),
          )
        ]));
  }
}
