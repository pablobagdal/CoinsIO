import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_request.freezed.dart';
part 'transaction_request.g.dart';

@freezed
abstract class TransactionRequest with _$TransactionRequest {
  const factory TransactionRequest({
    // example: 1
    required int accountId,
    // example: 1
    required int categoryId,
    // example: 500.00
    required String amount,
    // example: 2023-10-01T12:00:00Z
    required String transactionDate,
    // example: Зарплата за месяц
    String? comment,
  }) = _TransactionRequest;

  factory TransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$TransactionRequestFromJson(json);
}
