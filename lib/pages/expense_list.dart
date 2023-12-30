import 'package:flutter/material.dart';
import 'package:ExpenseApp/models/expense.dart';
import 'package:ExpenseApp/widgets/chart/chart.dart';
import 'package:ExpenseApp/widgets/expense_item.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onRemove,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemove;

  @override
  ExpenseListState createState() => ExpenseListState();
}

class ExpenseListState extends State<ExpenseList> {
  List<Expense> removedExpenses = [];

  void undoRemoveExpense(int index) {
    Expense removedExpense = removedExpenses.removeAt(0);
    setState(() {
      widget.expenses.insert(index, removedExpense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            child: Chart(
              expenses: widget.expenses,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.expenses.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(widget.expenses[index]),
                  child: ExpenseItem(widget.expenses[index]),
                  onDismissed: (direction) {
                    Expense removedExpense = widget.expenses[index];
                    widget.onRemove(removedExpense);
                    setState(() {
                      removedExpenses.add(removedExpense);
                    });
                    final snackBar = SnackBar(
                      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
                      content: const Text(
                        "Harcama listesini sildiniz!",
                        style: TextStyle(
                            color: Color.fromARGB(255, 199, 17, 17),
                            fontSize: 16),
                      ),
                      action: SnackBarAction(
                        backgroundColor: const Color.fromARGB(255, 76, 175, 80),
                        label: "Geri al",
                        textColor: const Color.fromARGB(255, 51, 37, 133),
                        onPressed: () {
                          setState(() {
                            undoRemoveExpense(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor:
                                    Color.fromARGB(255, 145, 175, 153),
                                content: Text(
                                  "Geri alındı.",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 105, 110, 138),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
