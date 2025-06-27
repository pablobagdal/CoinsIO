import 'package:coinio_app/domain/models/category/category.dart';

abstract class CategoriesEvent {}

class SearchCategoriesByName extends CategoriesEvent {
  List<Category> categories;

  SearchCategoriesByName({required this.categories});
}

class LoadCategories extends CategoriesEvent {}
