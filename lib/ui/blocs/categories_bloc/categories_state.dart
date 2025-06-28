import 'package:coinio_app/domain/models/category/category.dart';

abstract class CategoriesState {
  List<Category> categories;

  CategoriesState({required this.categories});
}

class CategoriesError extends CategoriesState {
  final String message;

  CategoriesError({required this.message}) : super(categories: []);
}

class CategoriesLoading extends CategoriesState {
  CategoriesLoading({required super.categories});
}

class CategoriesLoaded extends CategoriesState {
  CategoriesLoaded({required super.categories});
}
