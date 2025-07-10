import 'package:coinio_app/data/models/account_state/account_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_history.g.dart';
part 'account_history.freezed.dart';

enum ChangeType {
  @JsonValue('MODIFICATION')
  modification,
  @JsonValue('CREATION')
  creation,
}

@freezed
abstract class AccountHistory with _$AccountHistory {
  const factory AccountHistory({
    /// example: 1
    required final int id,

    /// example: 1
    required final int accountId,

    /// example: MODIFICATION or CREATION
    required final ChangeType changeType,

    /// previous state of the account
    required final AccountState previousState,

    /// new state of the account after the change
    required final AccountState newState,

    /// timestamp of the change
    required final DateTime changeTimestamp,

    /// creation timestamp of the history record
    required final DateTime createdAt,
  }) = _AccountHistory;

  factory AccountHistory.fromJson(final Map<String, dynamic> json) =>
      _$AccountHistoryFromJson(json);
}
