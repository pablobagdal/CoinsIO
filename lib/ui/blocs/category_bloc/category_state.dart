import 'package:coinio_app/data/models/category/category.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {
  CategoryInitial();
}

class CategoryError extends CategoryState {
  final List<Category>? categories;
  final String message;

  CategoryError({required this.message, this.categories});
}

class CategoryLoading extends CategoryState {}

class CategoriesLoaded extends CategoryState {
  final List<Category> categories;
  CategoriesLoaded({required this.categories});
}

class CategoryLoaded extends CategoryState {
  final Category category;
  CategoryLoaded({required this.category});
}
