import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_request_model.freezed.dart';
part 'transaction_request_model.g.dart';

@freezed
abstract class TransactionRequestModel with _$TransactionRequestModel {
  const factory TransactionRequestModel({
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
  }) = _TransactionRequestModel;

  factory TransactionRequestModel.fromJson(final Map<String, dynamic> json) =>
      _$TransactionRequestModelFromJson(json);
}
