import 'package:coinio_app/data/repositories/category_repository.dart';
import 'package:coinio_app/domain/models/category/category.dart';

class MockCategoryRepository implements CategoryRepository {
  @override
  Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));

    return <Category>[
      const Category(id: 1, name: 'Зарплата', emoji: '💰💰💰', isIncome: true),
      const Category(id: 2, name: 'Подработка', emoji: '💰', isIncome: true),
      const Category(id: 3, name: 'Одежда', emoji: '👗', isIncome: false),
      const Category(id: 4, name: 'Медицина', emoji: '💊', isIncome: false),
      const Category(id: 5, name: 'Продукты', emoji: '🍭', isIncome: false),
    ];
  }

  @override
  Future<List<Category>> getCategoriesByType({required final bool isIncome}) =>
      getCategories().then(
        (final categories) =>
            categories
                .where((final category) => category.isIncome == isIncome)
                .toList(),
      );
}
