import 'package:coinio_app/domain/models/category/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();

  /// Тип категорий: true - доходы, false - расходы
  Future<List<Category>> getCategoriesByType({required final bool isIncome});
}
