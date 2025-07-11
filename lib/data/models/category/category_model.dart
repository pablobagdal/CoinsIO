import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    /// example: 1
    required final int id,

    /// example: Зарплата
    required final String name,

    /// example: 💰
    required final String emoji,

    /// example: true
    required final bool isIncome,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(final Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
