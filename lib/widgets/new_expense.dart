import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_app/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAdd});

  final void Function(Expense expense) onAdd;

  @override
  NewExpenseState createState() => NewExpenseState();
}

class NewExpenseState extends State<NewExpense> {
  final _expenseNameController = TextEditingController();
  final _expensePriceController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.work;

  void _openDatePicker() async {
    DateTime today = DateTime.now();
    DateTime oneYearAgo = DateTime(today.year - 1, today.month, today.day);

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate == null ? today : _selectedDate!,
      firstDate: oneYearAgo,
      lastDate: today,
    );
    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Hata"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("Tamam"),
          ),
        ],
      ),
    );
  }

  void addNewExpense() {
    final expenseName = _expenseNameController.text;
    final expensePrice = _expensePriceController.text;

    if (expenseName.isEmpty || expensePrice.isEmpty || _selectedDate == null) {
      _showErrorDialog("Lütfen tüm alanları doldurun.");
      return;
    }

    final amount = double.tryParse(expensePrice);
    if (amount == null || amount < 0) {
      _showErrorDialog("Geçerli bir tutar girin.");
      return;
    }

    Expense newExpense = Expense(
      name: expenseName,
      price: amount,
      date: _selectedDate!,
      category: _selectedCategory,
    );

    _expenseNameController.clear();
    _expensePriceController.clear();
    setState(() {
      _selectedDate = null;
      _selectedCategory = Category.work;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Harcama başarıyla eklendi: ${newExpense.formattedDate}"),
        backgroundColor: Colors.green,
      ),
    );
    widget.onAdd(newExpense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Harcama Ekle'),
        backgroundColor: Colors.deepPurple, // AppBar rengi
      ),
      body: Container(
        color: const Color.fromARGB(255, 221, 227, 231), // Arka plan rengi
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _expenseNameController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    labelText: "Harcama Adı",
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _expensePriceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Harcama Miktarı",
                          prefixText: "₺",
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _openDatePicker(),
                      icon: const Icon(Icons.calendar_today),
                    ),
                    Text(
                      _selectedDate == null
                          ? "Tarih Seçiniz"
                          : DateFormat.yMd().format(_selectedDate!),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text("Kategori: "),
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) _selectedCategory = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 226, 148, 222), // Kapat butonu rengi
                      ),
                      child: const Text("Kapat"),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: addNewExpense,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Kaydet butonu rengi
                      ),
                      child: const Text("Kaydet"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
