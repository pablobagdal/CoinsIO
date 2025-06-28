import 'package:coinio_app/domain/models/category/category.dart';
import 'package:coinio_app/domain/repositories/category_repository.dart';

class GetCategoriesUsecase {
  CategoryRepository repository;

  GetCategoriesUsecase({required this.repository});

  Future<List<Category>> call() async => await repository.getCategories();
}
