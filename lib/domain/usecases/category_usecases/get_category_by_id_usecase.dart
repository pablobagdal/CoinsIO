import 'package:coinio_app/data/models/category/category_model.dart';
import 'package:coinio_app/domain/repositories/category_repository.dart';

class GetCategoryByIdUsecase {
  CategoryRepository categoryRepository;

  GetCategoryByIdUsecase({required this.categoryRepository});

  Future<Category> call({required final int id}) async =>
      await categoryRepository.getCategoryById(id: id);
}
