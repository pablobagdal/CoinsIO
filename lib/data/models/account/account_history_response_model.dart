import 'package:coinio_app/data/models/account/account_history_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_history_response_model.freezed.dart';
part 'account_history_response_model.g.dart';

@freezed
abstract class AccountHistoryResponseModel with _$AccountHistoryResponseModel {
  const factory AccountHistoryResponseModel({
    /// example: 1
    required final int accountId,

    /// example: Основной счет
    required final String accountName,

    /// example: USD
    required final String currency,

    /// example: 2000.00
    required final String currentBalance,

    /// example: [AccountHistory{...}]
    required final List<AccountHistoryModel> history,
  }) = _AccountHistoryResponseModel;

  factory AccountHistoryResponseModel.fromJson(
    final Map<String, dynamic> json,
  ) => _$AccountHistoryResponseModelFromJson(json);
}
