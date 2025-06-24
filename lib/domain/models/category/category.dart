import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
abstract class Category with _$Category {
  const factory Category({
    /// example: 1
    required int id,

    /// example: Зарплата
    required String name,

    /// example: 💰
    required String emoji,

    /// example: true
    required bool isIncome,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
