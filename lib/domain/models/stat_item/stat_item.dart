import 'package:freezed_annotation/freezed_annotation.dart';
part 'stat_item.freezed.dart';
part 'stat_item.g.dart';

@freezed
abstract class StatItem with _$StatItem {
  const factory StatItem({
    /// example: 1
    required final int categoryId,

    /// example: Зарплата
    required final String categoryName,

    /// example: 💰
    required final String emoji,

    /// example: 5000.00
    required final String amount,
  }) = _StatItem;

  factory StatItem.fromJson(final Map<String, dynamic> json) =>
      _$StatItemFromJson(json);
}
