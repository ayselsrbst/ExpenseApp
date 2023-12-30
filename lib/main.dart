import 'package:flutter/material.dart';
import 'package:ExpenseApp/pages/main_page.dart';
import 'models/expense.dart';

ColorScheme lightColorsScheme = ColorScheme.fromSeed(seedColor: Colors.black54);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorsScheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: lightColorsScheme.onPrimaryContainer,
            foregroundColor: lightColorsScheme.primaryContainer),
        cardTheme: const CardTheme()
            .copyWith(color: lightColorsScheme.onPrimaryContainer),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18)),
      ),
      home: MainPage(
        onAdd: (Expense expense) {},
      ),
    ),
  );
}
