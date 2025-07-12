import 'package:dio/dio.dart';

class SwaggerCategoryDatasource {
  SwaggerCategoryDatasource(this.dio);

  final Dio dio;

  Future<List<CategoryModel>> getCategories() async {
    final response = await dio.get("/categories");

    if (response.statusCode == 401) {
      throw UnauthorizedRequest();
    }

    return (response.data as List)
        .map((el) => CategoryModel.fromJson(el))
        .toList();
  }
}
