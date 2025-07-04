import 'package:coinio_app/domain/models/category/category.dart';
import 'package:coinio_app/domain/repositories/category_repository.dart';

class GetCategoryByTypeUsecase {
  CategoryRepository categoryRepository;

  GetCategoryByTypeUsecase({required this.categoryRepository});

  Future<List<Category>> call({required final bool isIncome}) async =>
      await categoryRepository.getCategoriesByType(isIncome: isIncome);
}
