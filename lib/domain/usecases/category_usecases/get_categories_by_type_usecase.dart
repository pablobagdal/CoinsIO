import 'package:coinio_app/data/models/category/category.dart';
import 'package:coinio_app/domain/repositories/category_repository.dart';

class GetCategoriesByTypeUsecase {
  CategoryRepository categoryRepository;

  GetCategoriesByTypeUsecase({required this.categoryRepository});

  Future<List<Category>> call({required final bool isIncome}) async =>
      await categoryRepository.getCategoriesByType(isIncome: isIncome);
}
