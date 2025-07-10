import 'package:coinio_app/data/models/account_brief/account_brief.dart';
import 'package:coinio_app/data/models/category/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_response.freezed.dart';
part 'transaction_response.g.dart';

@freezed
abstract class TransactionResponse with _$TransactionResponse {
  const factory TransactionResponse({
    /// example: 1
    required final int id,
    required final AccountBrief account,
    required final Category category,

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
