import 'package:coinio_app/data/datasources/local/category_local_data_source.dart';
import 'package:coinio_app/data/datasources/remote/category_remote_data_source.dart';
import 'package:coinio_app/domain/entities/category.dart';
import 'package:coinio_app/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;

  CategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

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
