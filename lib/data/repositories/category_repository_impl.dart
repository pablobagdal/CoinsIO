import 'package:coinio_app/data/datasources/local/local_data_source/app_database.dart';
import 'package:coinio_app/data/models/category/category.dart';
import 'package:coinio_app/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final AppDatabase db;

  CategoryRepositoryImpl({required this.db});

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

  @override
  Future<Category> getCategoryById({required int id}) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }
}
