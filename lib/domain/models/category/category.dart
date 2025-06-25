import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
abstract class Category with _$Category {
  const factory Category({
    /// example: 1
    required final int id,

    /// example: Зарплата
    required final String name,

    /// example: 💰
    required final String emoji,

    /// example: true
    required final bool isIncome,
  }) = _Category;

  factory Category.fromJson(final Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
