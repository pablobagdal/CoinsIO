import 'package:freezed_annotation/freezed_annotation.dart';
part 'stat_item.freezed.dart';
part 'stat_item.g.dart';

@freezed
abstract class StatItem with _$StatItem {
  const factory StatItem({
    // example: 1
    required int categoryId,
    // example: Зарплата
    required String categoryName,
    // example: 💰
    required String emoji,
    // example: 5000.00
    required String amount,
  }) = _StatItem;

  factory StatItem.fromJson(Map<String, dynamic> json) =>
      _$StatItemFromJson(json);
}
