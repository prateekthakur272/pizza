import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/src/models/models.dart';
import 'category.dart';

class Expense {
  String id;
  Category category;
  DateTime date;
  int amount;
  Expense({
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
