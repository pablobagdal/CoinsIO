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
