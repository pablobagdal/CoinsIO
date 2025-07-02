import 'package:coinio_app/domain/models/category/category.dart';
import 'package:coinio_app/domain/repositories/category_repository.dart';

class GetCategoryByIdUsecase {
  CategoryRepository repository;

  GetCategoryByIdUsecase({required this.repository});

  Future<Category> call({required final int id}) async =>
      await repository.getCategoryById(id: id);
}
