import 'package:dartz/dartz.dart';
import 'package:coinio_app/core/datasource_failures.dart';
import 'package:coinio_app/data/models/freezed_models/category_model.dart';
import 'package:coinio_app/domain/entity/synced_response.dart';

abstract class CategoryRepository {
  Future<Either<Failure, SyncedResponse<List<CategoryModel>>>> getCategories();
}
