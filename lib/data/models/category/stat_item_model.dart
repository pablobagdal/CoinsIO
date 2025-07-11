import 'package:freezed_annotation/freezed_annotation.dart';
part 'stat_item_model.freezed.dart';
part 'stat_item_model.g.dart';

@freezed
abstract class StatItemModel with _$StatItemModel {
  const factory StatItemModel({
    /// example: 1
    required final int categoryId,

    /// example: Зарплата
    required final String categoryName,

    /// example: 💰
    required final String emoji,

    /// example: 5000.00
    required final String amount,
  }) = _StatItemModel;

  factory StatItemModel.fromJson(final Map<String, dynamic> json) =>
      _$StatItemModelFromJson(json);
}
