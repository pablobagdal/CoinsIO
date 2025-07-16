import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:coinio_app/core/datasource_failures.dart';
import 'package:coinio_app/data/models/freezed_models/category_model.dart';
import 'package:coinio_app/data/repositories/swagger_repositories/swagger_drift_connection.dart';
import 'package:coinio_app/domain/entity/synced_response.dart';
import 'package:coinio_app/domain/repositories/category_repository.dart';

class SwaggerCategoryRepository implements CategoryRepository {
  final SwaggerDriftConnection _driftConnection;

  SwaggerCategoryRepository(this._driftConnection);

  @override
  Future<Either<Failure, SyncedResponse<List<CategoryModel>>>>
  getCategories() async {
    final isSynced = await _driftConnection.sync();
    try {
      return Right(
        SyncedResponse(
          await _driftConnection.getCategories(),
          isSynced: isSynced,
        ),
      );
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      log("${e.runtimeType} in $runtimeType.getCategories: $e");
      return Left(UnhandledFailure());
    }
  }
}
