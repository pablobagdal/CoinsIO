import 'package:coinio_app/domain/models/category/category.dart';
import 'package:coinio_app/domain/repositories/category_repository.dart';

abstract class CategoryLocalDataSource implements CategoryRepository {}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  @override
  Future<List<Category>> getCategories() {
    // TODO: implement getCategories
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getCategoriesByType({required bool isIncome}) {
    // TODO: implement getCategoriesByType
    throw UnimplementedError();
  }
}
