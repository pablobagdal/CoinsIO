import 'package:coinio_app/data/models/category/stat_item_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_response_model.freezed.dart';
part 'account_response_model.g.dart';

@freezed
abstract class AccountResponseModel with _$AccountResponseModel {
  const factory AccountResponseModel({
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
    required final List<StatItemModel> incomeStats,

    /// example: [StatItemModel{
    /// categoryId*	integer
    /// example: 1
    /// categoryName*	string
    /// example: Зарплата
    /// emoji*	string
    /// example: 💰
    /// amount*	string
    /// example: 5000.00
    /// }]
    required final List<StatItemModel> expenseStats,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _AccountResponseModel;

  factory AccountResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$AccountResponseModelFromJson(json);
}
