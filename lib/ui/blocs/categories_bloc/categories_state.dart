import 'package:coinio_app/domain/models/category/category.dart';

abstract class CategoriesState {}

class CategoriesError extends CategoriesState {
  final String error;

  CategoriesError({required this.error});
}

class CategoriesLoading extends CategoriesState {
  final List<Category> categories;

  CategoriesLoading({required this.categories});
}

class CategoriesLoaded extends CategoriesState {
  final List<Category> categories;

  CategoriesLoaded({required this.categories});
}
