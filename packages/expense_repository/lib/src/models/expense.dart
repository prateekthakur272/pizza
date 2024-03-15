import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/src/models/models.dart';
import 'category.dart';

class Expense {
  final String id;
  final Category category;
  final DateTime date;
  final int amount;
  const Expense({
    required this.id,
    required this.category,
    required this.date,
    required this.amount,
  });

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
        id: map['id'],
        category: map['category'],
        date: (map['date'] as Timestamp).toDate(),
        amount: map['amount']);
  }

  static final empty = Expense(
    id: '',
    category: Category.empty,
    date: DateTime.now(),
    amount: 0,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category.toMap(),
      'datetime': date,
      'amount': amount
    };
  }
}
