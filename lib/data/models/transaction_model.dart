import 'package:coinio_app/data/models/account_model.dart';
import 'package:coinio_app/data/models/category_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
abstract class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    /// example: 1
    required final int id,

    /// example: 1
    required final int accountId,

    /// example: 1
    required final int categoryId,

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
  }) = _TransactionModel;

  factory TransactionModel.fromJson(final Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}

@freezed
abstract class TransactionRequest with _$TransactionRequest {
  const factory TransactionRequest({
    /// example: 1
    required final int accountId,

    /// example: 1
    required final int categoryId,

    /// example: 500.00
    required final String amount,

    /// example: 2023-10-01T12:00:00Z
    required final DateTime transactionDate,

    /// example: Зарплата за месяц
    final String? comment,
  }) = _TransactionRequest;

  factory TransactionRequest.fromJson(final Map<String, dynamic> json) =>
      _$TransactionRequestFromJson(json);
}

@freezed
abstract class TransactionResponse with _$TransactionResponse {
  const factory TransactionResponse({
    /// example: 1
    required final int id,
    required final AccountBrief account,
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
  }) = _TransactionResponse;

  factory TransactionResponse.fromJson(final Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);
}
