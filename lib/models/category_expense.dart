import 'package:expense_app/models/expense.dart';

class CategoryExpense {
  const CategoryExpense({required this.category, required this.expenses});

  CategoryExpense.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpensePrice {
    double sum = 0;

    for (var element in expenses) {
      sum += element.price;
    }

    return sum;
  }
}
