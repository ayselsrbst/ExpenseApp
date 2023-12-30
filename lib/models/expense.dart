import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

const uuid = Uuid();

enum Category { food, education, travel, work }

final categoryIcons = {
  Category.food: Icons.food_bank,
  Category.education: Icons.cast_for_education,
  Category.travel: Icons.car_rental,
  Category.work: Icons.business,
};

class Expense {
  Expense({
    required this.name,
    required this.price,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String name;
  final double price;
  final DateTime date;
  final Category category;

  String get formattedDate {
    var formatter = DateFormat.yMd();
    return formatter.format(date);
  }

  void add(Expense expense) {}
}
