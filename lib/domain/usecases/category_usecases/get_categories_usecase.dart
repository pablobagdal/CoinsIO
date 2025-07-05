import 'package:coinio_app/domain/models/category/category.dart';
import 'package:coinio_app/domain/repositories/category_repository.dart';

class GetCategoriesUsecase {
  CategoryRepository categoryRepository;

  GetCategoriesUsecase({required this.categoryRepository});

  Future<List<Category>> call() async =>
      await categoryRepository.getCategories();
}
