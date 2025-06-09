import 'package:coinio_app/domain/models/account_brief/account_brief.dart';
import 'package:coinio_app/domain/models/category/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_response.freezed.dart';
part 'transaction_response.g.dart';

@freezed
abstract class TransactionResponse with _$TransactionResponse {
  const factory TransactionResponse({
    // example: 1
    required int id,
    required AccountBrief account,
    required Category category,
    // example: 500.00
    required String amount,
    // example: 2023-10-01T12:00:00Z
    required DateTime transactionDate,
    // example: Зарплата за месяц
    String? comment,
    // example: 2023-10-01T12:00:00Z
    required DateTime createdAt,
    // example: 2023-10-01T12:00:00Z
    required DateTime updatedAt,
  }) = _TransactionResponse;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);
}
