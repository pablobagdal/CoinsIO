import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:coinio_app/core/utils/date_time_converter.dart';
import 'package:coinio_app/core/utils/decimal_converter.dart';
import 'package:coinio_app/data/models/freezed_models/transaction_models/transaction_model.dart';

part 'transaction_request_model.freezed.dart';
part 'transaction_request_model.g.dart';

@freezed
abstract class TransactionRequestModel with _$TransactionRequestModel {
  const factory TransactionRequestModel({
    required int accountId,
    required int categoryId,
    @DecimalConverter() required Decimal amount,
    @DateTimeConverter() required DateTime transactionDate,
    String? comment,
  }) = _TransactionRequestModel;

  factory TransactionRequestModel.fromJson(Map<String, Object?> json) =>
      _$TransactionRequestModelFromJson(json);

  factory TransactionRequestModel.fromTransactionModel(
    TransactionModel transaction,
  ) => TransactionRequestModel(
    accountId: transaction.accountId,
    categoryId: transaction.categoryId,
    amount: transaction.amount,
    transactionDate: transaction.transactionDate,
    comment: transaction.comment,
  );
}
