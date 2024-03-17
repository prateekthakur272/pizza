import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ExpenseInitial extends ExpenseState{}
class ExpenseLoading extends ExpenseState{}
class ExpenseFailed extends ExpenseState{
  final String message;
  ExpenseFailed(this.message);
}
class ExpenseCreated extends ExpenseState{}

class ExpensesFetched extends ExpenseState{
  final List<Expense> expenses;
  ExpensesFetched(this.expenses);
  @override
  List<Object?> get props => [expenses];
}


class ExpenseEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class CreateExpense extends ExpenseEvent{
  final Expense expense;
  CreateExpense(this.expense);
}

class GetExpenses extends ExpenseEvent{}


class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState>{
  final BaseExpenseRepository _expenseRepository;
  ExpenseBloc(this._expenseRepository):super(ExpenseInitial()){
    on<CreateExpense>((event, emit) async {
      emit(ExpenseLoading());
      try {
        await _expenseRepository.createExpense(event.expense);
        emit(ExpenseCreated());
      } on FirebaseException catch (e) {
        emit(ExpenseFailed(e.message??'some error occured'));
      }
    });
    on<GetExpenses>((event, emit) async {
      emit(ExpenseLoading());
      try {
        final expenses = await _expenseRepository.getExpenses();
        emit(ExpensesFetched(expenses));
      } on FirebaseException catch (e) {
        emit(ExpenseFailed(e.message??'some error occured'));
      }
    });
  }
}