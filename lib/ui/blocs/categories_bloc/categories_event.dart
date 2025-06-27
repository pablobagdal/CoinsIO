import 'package:coinio_app/domain/models/category/category.dart';

abstract class CategoriesEvent {}

class SearchCategoriesByName extends CategoriesEvent {
  final List<Category> categories;
  final String query;

  SearchCategoriesByName({required this.query, required this.categories});
}

class LoadCategories extends CategoriesEvent {}
