import 'package:coinio_app/data/models/account/account_brief_model.dart';
import 'package:coinio_app/data/models/category/category_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_response_model.freezed.dart';
part 'transaction_response_model.g.dart';

@freezed
abstract class TransactionResponseModel with _$TransactionResponseModel {
  const factory TransactionResponseModel({
    /// example: 1
    required final int id,
    required final AccountBriefModel account,
    required final CategoryModel category,

    /// example: 500.00
    required final String amount,

    /// example: 2023-10-01T12:00:00Z
    required final DateTime transactionDate,

    /// example: Зарплата за месяц
    final String? comment,

    /// example: 2023-10-01T12:00:00Z
    required final DateTime createdAt,

    /// example: 2023-10-01T12:00:00Z
    required final DateTime updatedAt,
  }) = _TransactionResponseModel;

  factory TransactionResponseModel.fromJson(final Map<String, dynamic> json) =>
      _$TransactionResponseModelFromJson(json);
}
