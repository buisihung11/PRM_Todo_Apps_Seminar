import 'package:TodoApp_Seminar_PRM/database/categoryModel.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {
  final List propss;
  CategoryState([this.propss]);

  @override
  List<Object> get props => (propss ?? []);
}

/// UnInitialized
class CategoryLoadInProgress extends CategoryState {}

/// Initialized
class CategoryLoadSuccess extends CategoryState {
  final List<Category> categories;

  CategoryLoadSuccess(this.categories) : super([categories]);

  @override
  String toString() => 'InCategoryState $categories';
}

class ErrorCategoryState extends CategoryState {
  final String errorMessage;

  ErrorCategoryState(this.errorMessage) : super([errorMessage]);

  @override
  String toString() => 'ErrorCategoryState';
}
