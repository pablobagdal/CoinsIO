import 'package:coinio_app/domain/models/stat_item/stat_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_response.freezed.dart';
part 'account_response.g.dart';

@freezed
abstract class AccountResponse with _$AccountResponse {
  const factory AccountResponse({
    /// example: 1
    required final int id,

    /// example: Основной счёт
    required final String name,

    /// example: 1000.00
    required final String balance,

    /// example: RUB
    required final String currency,

    /// example: [StatItem{
    ///  categoryId*	integer
    ///  example: 1
    ///  categoryName*	string
    ///  example: Зарплата
    ///  emoji*	string
    ///  example: 💰
    ///  amount*	string
    ///  example: 5000.00
    ///  }]
    required final List<StatItem> incomeStats,

    /// example: [StatItem{
    /// categoryId*	integer
    /// example: 1
    /// categoryName*	string
    /// example: Зарплата
    /// emoji*	string
    /// example: 💰
    /// amount*	string
    /// example: 5000.00
    /// }]
    required final List<StatItem> expenseStats,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _AccountResponse;

  factory AccountResponse.fromJson(final Map<String, dynamic> json) =>
      _$AccountResponseFromJson(json);
}
