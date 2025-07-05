import 'package:coinio_app/domain/repositories/category_repository.dart';
import 'package:coinio_app/domain/models/category/category.dart';

class MockCategoryRepository implements CategoryRepository {
  @override
  Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));

    return _mockCategories;
  }

  @override
  Future<List<Category>> getCategoriesByType({
    required final bool isIncome,
  }) async {
    final categories = await getCategories();
    final filteredCategories =
        categories
            .where((final category) => category.isIncome == isIncome)
            .toList();

    return filteredCategories;
  }

  @override
  Future<Category> getCategoryById({required int id}) async {
    await Future.delayed(const Duration(seconds: 1));
    final categories = await getCategories();

    final category = categories.firstWhere(
      (final category) => category.id == id,
      orElse: () => throw Exception('Category not found'),
    );

    return category;
  }
}

final List<Category> _mockCategories = [
  const Category(id: 1, name: 'Подработка', emoji: '💰', isIncome: true),
  const Category(id: 2, name: 'Зарплата', emoji: '💰💰💰', isIncome: true),
  const Category(id: 3, name: 'Одежда', emoji: '👗', isIncome: false),
  const Category(id: 4, name: 'Медицина', emoji: '💊', isIncome: false),
  const Category(id: 5, name: 'Продукты', emoji: '🍭', isIncome: false),
];
