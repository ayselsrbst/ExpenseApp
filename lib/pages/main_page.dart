import 'package:flutter/material.dart';

import 'package:expense_app/models/expense.dart';
import 'package:expense_app/pages/expense_list.dart';
import 'package:expense_app/widgets/new_expense.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.onAdd,
  });

  final void Function(Expense expense) onAdd;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final List<Expense> expenses = [
    Expense(
      name: "Yiyecek",
      price: 200,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      name: "Flutter Udemy Course",
      price: 100,
      date: DateTime.now(),
      category: Category.education,
    ),
    Expense(
      name: "Galata Kulesi",
      price: 150,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    setState(() {
      expenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense App"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) => NewExpense(
                  onAdd: (expense) {
                    widget.onAdd(expense);
                    addExpense(expense); // Yeni harcamayı ekleyin
                  },
                ),
              ).then((newExpense) {
                if (newExpense != null) {
                  setState(() {
                    addExpense(newExpense); // Yeni harcamayı ekleyin
                  });
                }
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ExpenseList(
        expenses: expenses,
        onRemove: (expense) => removeExpense(expense),
      ),
    );
  }
}
