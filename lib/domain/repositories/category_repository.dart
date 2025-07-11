import 'package:coinio_app/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<Category> getCategoryById({required final int id});
  Future<List<Category>> getCategoriesByType({required final bool isIncome});
}
