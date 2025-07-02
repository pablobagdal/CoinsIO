import 'package:coinio_app/domain/models/category/category.dart';
import 'package:coinio_app/domain/repositories/category_repository.dart';

class GetCategoryByTypeUsecase {
  CategoryRepository repository;

  GetCategoryByTypeUsecase({required this.repository});

  Future<List<Category>> call({required final bool isIncome}) async =>
      await repository.getCategoriesByType(isIncome: isIncome);
}
