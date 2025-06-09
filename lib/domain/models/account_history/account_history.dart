import 'package:coinio_app/domain/models/account_state/account_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_history.g.dart';
part 'account_history.freezed.dart';

enum ChangeType { MODIFICATION, CREATION }

@freezed
abstract class AccountHistory with _$AccountHistory {
  const factory AccountHistory({
    // example: 1
    required int id,
    // example: 1
    required int accountId,
    // example: MODIFICATION or CREATION
    required ChangeType changeType,
    // previous state of the account
    required AccountState previousState,
    // new state of the account after the change
    required AccountState newState,
    // timestamp of the change
    required DateTime changeTimestamp,
    // creation timestamp of the history record
    required DateTime createdAt,
  }) = _AccountHistory;

  factory AccountHistory.fromJson(Map<String, dynamic> json) =>
      _$AccountHistoryFromJson(json);
}
