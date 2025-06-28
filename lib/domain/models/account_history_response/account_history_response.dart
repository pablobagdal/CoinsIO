import 'package:coinio_app/domain/models/account_history/account_history.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_history_response.freezed.dart';
part 'account_history_response.g.dart';

@freezed
abstract class AccountHistoryResponse with _$AccountHistoryResponse {
  const factory AccountHistoryResponse({
    /// example: 1
    required final int accountId,

    /// example: Основной счет
    required final String accountName,

    /// example: USD
    required final String currency,

    /// example: 2000.00
    required final String currentBalance,

    /// example: [AccountHistory{...}]
    required final List<AccountHistory> history,
  }) = _AccountHistoryResponse;

  factory AccountHistoryResponse.fromJson(final Map<String, dynamic> json) =>
      _$AccountHistoryResponseFromJson(json);
}
