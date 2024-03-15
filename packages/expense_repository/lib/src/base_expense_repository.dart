import 'models/models.dart';

abstract class BaseExpenseRepository {
  Future<void> cerateCategory(Category category);
  Future<List<Category>> getCategories();
  Future<void> createExpense(Expense expense);
  Future<List<Expense>> getExpenses();
}
