import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/src/models/category.dart';

import 'package:expense_repository/src/models/expense.dart';

import 'base_expense_repository.dart';

class FirebaseExpenseRepositry extends BaseExpenseRepository {
  final _categoryCollection =
      FirebaseFirestore.instance.collection('categories');
  final _expenseCollection = FirebaseFirestore.instance.collection('expenses');

  @override
  Future<void> cerateCategory(Category category) async {
    try {
      await _categoryCollection.doc(category.id).set(category.toMap());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createExpense(Expense expense) async {
    try {
      await _expenseCollection.doc(expense.id).set(expense.toMap());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      return await _categoryCollection.get().then((value) =>
          value.docs.map((e) => Category.fromMap(e.data())).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Expense>> getExpenses() async {
    try {
      return await _expenseCollection.get().then(
          (value) => value.docs.map((e) => Expense.fromMap(e.data())).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
