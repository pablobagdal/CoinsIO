import 'package:coinio_app/data/models/category/category.dart';
import 'package:coinio_app/domain/repositories/category_repository.dart';

class GetCategoryByIdUsecase {
  CategoryRepository categoryRepository;

  GetCategoryByIdUsecase({required this.categoryRepository});

  Future<Category> call({required final int id}) async =>
      await categoryRepository.getCategoryById(id: id);
}
