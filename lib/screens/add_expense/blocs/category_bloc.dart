import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_core/firebase_core.dart';

class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CreateCategorySuccess extends CategoryState {}

class CreateCategoryLoading extends CategoryState {}

class CreateCategoryFailed extends CategoryState {
  final String message;
  CreateCategoryFailed(this.message);
  @override
  List<Object?> get props => [message];
}

class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateCategory extends CategoryEvent {
  final Category category;
  CreateCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class CategoryBloc extends Bloc {
  final BaseExpenseRepository _expenseRepository;
  CategoryBloc(this._expenseRepository) : super(CategoryInitial()) {
    on<CreateCategory>((event, emit) async {
      emit(CreateCategoryLoading());
      try {
        await _expenseRepository.cerateCategory(event.category);
        emit(CreateCategorySuccess());
      } catch (e) {
        emit(CreateCategoryFailed(
            (e as FirebaseException).message ?? 'some error occurred'));
      }
    });
  }
}
