import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_core/firebase_core.dart';

class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryFailed extends CategoryState {
  final String message;
  CategoryFailed(this.message);
  @override
  List<Object?> get props => [message];
}

class CreateCategorySuccess extends CategoryState {}

class GetCategoryListSuccess extends CategoryState {
  final List<Category> categories;
  GetCategoryListSuccess(this.categories);
  @override
  List<Object?> get props => [categories];
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

class GetCategoryList extends CategoryEvent {}

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final BaseExpenseRepository _expenseRepository;
  CategoryBloc(this._expenseRepository) : super(CategoryInitial()) {
    on<CreateCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await _expenseRepository.cerateCategory(event.category);
        emit(CreateCategorySuccess());
      } catch (e) {
        emit(CategoryFailed(
            (e as FirebaseException).message ?? 'some error occurred'));
      }
    });
    on<GetCategoryList>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = await _expenseRepository.getCategories();
        emit(GetCategoryListSuccess(categories));
      } catch (e) {
        emit(CategoryFailed(
            (e as FirebaseException).message ?? 'some error occurred'));
      }
    });
  }
}
