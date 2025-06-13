import 'package:coinio_app/data/repositories/category/category_repository.dart';
import 'package:coinio_app/domain/models/category/category.dart';

class MockCategoryRepository implements CategoryRepository {
  @override
  Future<List<Category>> getCategories() async {
    await Future.delayed(Duration(seconds: 1));

    return <Category>[
      Category(id: 1, name: 'Зарплата', emoji: '💰💰💰', isIncome: true),
      Category(id: 2, name: 'Подработка', emoji: '💰', isIncome: true),
      Category(id: 3, name: 'Одежда', emoji: '👗', isIncome: false),
      Category(id: 4, name: 'Медицина', emoji: '💊', isIncome: false),
      Category(id: 5, name: 'Продукты', emoji: '🍭', isIncome: false),
    ];
  }

  @override
  Future<List<Category>> getCategoriesByType(bool isIncome) {
    return getCategories().then((categories) {
      return categories
          .where((category) => category.isIncome == isIncome)
          .toList();
    });
  }
}
